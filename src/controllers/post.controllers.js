import urlMetadata from "url-metadata";
import { db } from "../database/db.connection.js";
import { postSchema } from "../schemas/post.schema.js";

export async function newPost(req, res) {
  const user = res.locals.user;
  const { link, content } = req.body;

  try {
    await postSchema.validateAsync({ link, content });
    const linkData = await urlMetadata(link);

    // const metadata = linkData.map((m) => (
    //   {
    //     title: m.title,
    //     description: m.description,
    //     url: m.url,
    //     image: m.jsonld.image

    //   }));
    // console.log(metadata);

    const confirm = await db.query(
      `
    INSERT INTO posts (user_id, link, content) VALUES ($1, $2, $3) RETURNING *;`,
      [user.id, link, content]
    );

    if (!confirm) {
      res.status(404).send("Não foi possivel publicar um novo post");
      return;
    }

    //Feat - Fernando 01/06 - Inicio
    const postId = confirm.rows[0].id;
    const hashtags = findHashtags(content);

    if (hashtags?.length > 0) {
      for (const hashtag of hashtags) {
        const existingHashtag = await db.query(
          `SELECT * FROM trendings WHERE hashtag = $1;`,
          [hashtag]
        );

        let hashtagData;
        if (existingHashtag.rows.length === 0) {
          const postHashtag = await db.query(
            `INSERT INTO trendings (hashtag) VALUES ($1) RETURNING *;`,
            [hashtag]
          );
          hashtagData = postHashtag.rows[0];
        } else {
          hashtagData = existingHashtag.rows[0];
        }
        const { id, hash_count } = hashtagData;

        await db.query(
          `INSERT INTO posts_hashtag (posts_id, hashtags_id)
           VALUES ($1, $2);`,
          [postId, id]
        );

        const newCount = hash_count + 1;
        await db.query(
          `UPDATE trendings SET hash_count = $1 WHERE id = $2;`,
          [newCount, id]
        );
      }
      return res.status(201).send("Post created successfully");
    }
    //Feat - Fernando 01/06 - Fim

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
    console.log(posts);
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

function findHashtags(content) {
  const regex = /#(\w+)/g;
  return content.match(regex);
}