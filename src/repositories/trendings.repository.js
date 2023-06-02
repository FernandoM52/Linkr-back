import { db } from "../database/db.connection.js";

export async function createTrendingDB(hashtag) {
  const trending = await db.query(
    `INSERT INTO trendings (hashtag) VALUES ($1) RETURNING *;`,
    [hashtag.replace("#", "")]
  );
  return trending;
}

export async function getHashtagDB(hashtag) {
  const trending = await db.query(
    `SELECT * FROM trendings WHERE hashtag = $1;`,
    [hashtag.replace("#", "")]
  );
  return trending;
}

export async function getPostsByTrendingsDB(params) {
  const { hashtag } = params;

  const posts = await db.query(
    `SELECT link, content, title, description, image, likes_count, date FROM posts
     JOIN posts_hashtag ph ON ph.posts_id = posts.id
     JOIN trendings t ON t.id = ph.hashtags_id
     WHERE t.hashtag = $1
     ORDER BY date;`,
    [hashtag.replace("#", "")]
  );
  return posts.rows;
}

export async function updateHashCountDB(newCount, id) {
  await db.query(
    `UPDATE trendings SET hash_count = $1 WHERE id = $2;`,
    [newCount, id]
  );
}