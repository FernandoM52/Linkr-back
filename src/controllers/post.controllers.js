import urlMetadata from "url-metadata";
import { db } from "../database/db.connection.js";
import { postSchema } from "../schemas/post.schema.js";
import {
  createPostDB,
  likePostDB,
  getPostId,
  getPostByUserId,
  unlikePostDB,
  checkIfPostLikedDB,
} from "../repositories/posts.repository.js";
import {
  createTrendingDB,
  getHashtagDB,
  updateHashCountDB,
} from "../repositories/trendings.repository.js";
import { createPostWithHashtagDB } from "../repositories/postsHashtag.repository.js";

export async function newPost(req, res) {
  const user = res.locals.user;
  const { link, content } = req.body;

  try {
    await postSchema.validateAsync({ link, content });

    const linkData = await getLinkData(link);

    const confirm = await createPostDB(
      user.id,
      link,
      linkData.title,
      linkData.description,
      linkData.image,
      content
    );
    if (!confirm)
      return res.status(404).send("Não foi possivel publicar um novo post");
    const postId = confirm.rows[0].id;

    const hashtags = findHashtags(content);
    if (hashtags?.length > 0) {
      for (const hashtag of hashtags) {
        const newHashtag = hashtag.replace("#", "");
        const existingHashtag = await getHashtagDB(newHashtag);

        let hashtagData;
        if (existingHashtag.rows.length === 0) {
          const postHashtag = await createTrendingDB(newHashtag);
          hashtagData = postHashtag.rows[0];
        } else {
          hashtagData = existingHashtag.rows[0];
        }
        const { id, hash_count } = hashtagData;

        await createPostWithHashtagDB(postId, id);

        const newCount = hash_count + 1;
        await updateHashCountDB(newCount, id);
      }
      return res.status(201).send("Post created successfully");
    }

    res.status(201).send("Post created successfully");
  } catch (err) {
    if (err.details) {
      const errs = err.details.map((detail) => detail.message);
      return res.status(422).send(errs);
    } else {
      return res.status(500).send(console.log(err));
    }
  }
}

export async function getPost(req, res) {
  const limit = 20;
  try {
    const posts = await db.query(
      `SELECT posts.*, users.photo, users.name FROM posts
    JOIN users ON users.id = posts.user_id
                                  ORDER BY date DESC LIMIT $1`,
      [limit]
    );

    res.send(posts.rows);
  } catch (err) {
    if (err.details) {
      const errs = err.details.map((detail) => detail.message);
      return res.status(422).send(errs);
    } else {
      return res.status(500).send("Internal server error");
    }
  }
}

export async function deletePost(req, res) {
  const { id } = req.params;
  const user = res.locals.user;

  if (!id) return res.status(404).send("Post doesn't exist");
  try {
    const verifyOwner = await db.query(
      `SELECT user_id, id FROM posts WHERE user_id = $1 and id = $2`,
      [user.id, id]
    );
    if (!verifyOwner.rowCount) return res.sendStatus(401);
    await db.query(`DELETE FROM posts_hashtag WHERE posts_id = $1`, [id]);
    const deletePost = await db.query(`DELETE FROM posts WHERE id = $1;`, [id]);
    if (!deletePost.rowCount) return res.sendStatus(400);

    res.sendStatus(200);
  } catch (err) {
    console.error(err);
    if (err.details) {
      const errs = err.details.map((detail) => detail.message);
      return res.status(422).send(errs);
    } else {
      return res.status(500).send("Internal server error");
    }
  }
}

async function getLinkData(linkData) {
  try {
    const result = await urlMetadata(linkData);

    const data = {
      url: result.url,
      title: result.title,
      description: result.description,
      image: result.image,
    };

    return data;
  } catch (err) {
    console.log(err);
  }
}

function findHashtags(content) {
  const regex = /#(\w+)/g;
  return content.match(regex);
}

export async function likePost(req, res) {
  const { postId } = req.params;
  const { id } = res.locals.user;

  if (!id) {
    return res.status(400).send("User ID is missing");
  }
  try {
    const isLiked = await checkIfPostLikedDB(id, postId);
    if (isLiked) {
      await unlikePostDB(id, postId);
      return res.send({ liked: false });
    } else {
      await likePostDB(id, postId);
      return res.send({ liked: true });
    }
  } catch (error) {
    return res.status(500).send(error.message);
  }
}

export async function getPostById(req, res) {
  const { id } = req.params;

  try {
    const getPosts = await getPostId(id);
    return res.send(getPosts.rows);
  } catch (error) {
    return res.status(500).send(error.message);
  }
}

export async function getPostByUser(req, res) {
  const { id } = req.params;

  try {
    const getUserPosts = await getPostByUserId(id);
    return res.send(getUserPosts.rows);
  } catch (error) {
    return res.status(500).send(error.message);
  }
}
