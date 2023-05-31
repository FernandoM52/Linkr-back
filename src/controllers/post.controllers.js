import { db } from "../database/db.connection.js";
import { postSchema } from "../schemas/post.schema.js";

export async function newPost(req, res) {
  const user = res.locals.user;
  const { link, content } = req.body;

  try {
    await postSchema.validateAsync({ link, content });

    const confirm = await db.query(
      `
    INSERT INTO posts (user_id, link, content) VALUES ($1, $2, $3)`,
      [user.id, link, content]
    );

    if (!confirm) {
      res.status(404).send("Não foi possivel publicar um novo post");
      return;
    }

    res.sendStatus(200);
  } catch (err) {
    if (err.details) {
      const errs = err.details.map((detail) => detail.message);
      return res.status(422).send(errs);
    } else {
      return res.status(500).send("Internal server error");
    }
  }
}

export async function getPost(req, res) {
  try {
    const posts = await db.query("SELECT * FROM posts");

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
