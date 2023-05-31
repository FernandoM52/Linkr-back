import { db } from "../database/db.connection.js";

export async function getPostsByHashtag() {
  const { hashtag } = req.params;
  if (!hashtag) return res.status(404).send("Parâmetro de trending inválido");

  try {
    //await getPostsByHashtagDB();
    const posts = await db.query(
      `SELECT * FROM posts
       JOIN posts_hashtag ph ON ph.posts_id = posts.id
       JOIN trendings t ON t.id = ph.hashtags_id
       WHERE t.hashtag = $1;`,
      [hashtag]
    );

    return res.send(posts.rows);
  } catch (err) {
    res.status(500).send(err.message);
  }
}