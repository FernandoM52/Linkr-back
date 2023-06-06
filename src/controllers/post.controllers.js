import urlMetadata from "url-metadata";
import { db } from "../database/db.connection.js";
import { postSchema } from "../schemas/post.schema.js";
import { createPostDB, likePostById, getPostId } from "../repositories/posts.repository.js";
import { createTrendingDB, getHashtagDB, updateHashCountDB } from "../repositories/trendings.repository.js";
import { createPostWithHashtagDB } from "../repositories/postsHashtag.repository.js";

export async function newPost(req, res) {
  const user = res.locals.user;
  const { link, content } = req.body;

  try {
    await postSchema.validateAsync({ link, content });

    const linkData = await getLinkData(link);

    const confirm = await createPostDB(user.id, link, linkData.title, linkData.description, linkData.image, content);
    if (!confirm) return res.status(404).send("Não foi possivel publicar um novo post");
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
    const posts = await db.query(`SELECT * FROM posts
                                  ORDER BY date DESC LIMIT $1`, [limit]);

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

async function getLinkData(linkData) {
  try {
    const result = await urlMetadata(linkData);

    const data =
    {
      url: result.url,
      title: result.title,
      description: result.description,
      image: result.image
    }

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

  try {
    if (!id) {
      return res.status(400).send('User ID is missing');
    }

    await likePostById(id, postId);
    return res.send();
  } catch (error) {
    console.log(error.message);
    return res.status(500).send(error.message);
  }
}

export async function getPostById(req, res) {
  const { id } = req.params

  try {
    const getPosts = await getPostId(id)
    console.log(getPosts)
    return res.send(getPosts.rows)
  } catch (error) {
    console.log(error.message)
    return res.status(500).send(error.message)

  }

}
