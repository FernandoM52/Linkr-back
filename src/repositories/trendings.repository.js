import { db } from "../database/db.connection.js";

export async function createTrendingDB(hashtag) {
  const trending = await db.query(
    `INSERT INTO trendings (hashtag) VALUES ($1) RETURNING *;`,
    [hashtag.replace("#", "")]
  );
  return trending;
}

export async function getTrendingsDB() {
  const result = await db.query("SELECT * FROM trendings ORDER BY hash_count DESC LIMIT 10;");
  return result;
}

export async function getHashtagDB(hashtag) {
  const trending = await db.query(
    `SELECT * FROM trendings WHERE hashtag = $1;`,
    [hashtag.replace("#", "")]
  );
  return trending;
}

export async function getPostsByTrendingDB(params, query) {
  const { hashtag } = params;
  const { page } = query;
  const PAGE_SIZE = 10;
  const offset = (page - 1) * PAGE_SIZE;

  const posts = await db.query(
    `SELECT p.*, u.name as "userName", u.photo as "userPhoto"
      FROM posts AS p
      JOIN posts_hashtag AS ph ON p.id = ph.posts_id
      JOIN trendings AS t ON ph.hashtags_id = t.id
      JOIN users AS u ON u.id = p.user_id
      WHERE t.hashtag = $1
      ORDER BY p.date DESC
      LIMIT $2 OFFSET $3;`,
    [hashtag, Number(PAGE_SIZE), Number(offset)]
  );
  return posts.rows;
}

export async function updateHashCountDB(newCount, id) {
  await db.query(
    `UPDATE trendings SET hash_count = $1 WHERE id = $2;`,
    [newCount, id]
  );
}