import urlMetadata from "url-metadata";
import { db } from "../database/db.connection.js";
import { postSchema } from "../schemas/post.schema.js";

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

export async function newPost(req, res) {
  const user = res.locals.user;
  const { link, content } = req.body;
  
  try {
    await postSchema.validateAsync({ link, content });

    const linkData = await getLinkData(link);
    const confirm = await db.query(
      `
      INSERT INTO posts (user_id, link, title, description, image, content) VALUES ($1, $2, $3, $4, $5, $6)`,
      [user.id, link, linkData.title, linkData.description, linkData.image, content]
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
