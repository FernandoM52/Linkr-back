import { db } from "../database/db.connection.js";

export async function createPostDB(
  id,
  link,
  title,
  description,
  image,
  content
) {
  const post = await db.query(
    `INSERT INTO posts (user_id, link, title, description, image, content) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
    [id, link, title, description, image, content]
  );
  return post;
}

export async function checkIfPostLikedDB(id, postId) {
  const result = await db.query(
    `SELECT COUNT(*) FROM likes WHERE user_id = $1 AND post_id = $2;`,
    [id, postId]
  );

  const count = parseInt(result.rows[0].count);
  return count > 0;
}

export async function likePostDB(id, postId) {
  const likeCount = await db.query(`SELECT likes_count FROM posts WHERE id = $1;`, [postId]);

  await db.query(`INSERT INTO likes (user_id, post_id) VALUES ($1, $2);`, [id, postId]);

  const newLikeCount = likeCount.rows[0].likes_count + 1;
  console.log(newLikeCount);
  await db.query(`UPDATE posts SET likes_count = $1 WHERE id = $2;`, [newLikeCount, postId]);
}

export async function unlikePostDB(id, postId) {
  const likeCount = await db.query(`SELECT likes_count FROM posts WHERE id = $1;`, [postId]);

  await db.query(`DELETE FROM likes WHERE user_id = $1 AND post_id = $2;`, [id, postId]);

  const newLikeCount = likeCount.rows[0].likes_count - 1;
  await db.query(`UPDATE posts SET likes_count = $1 WHERE id = $2;`, [newLikeCount, postId]);
}

export function getPostId(postId) {
  return db.query(
    `
    SELECT likes.post_id, users.name
    FROM likes
    JOIN users ON users.id = likes.user_id
    WHERE likes.post_id = $1
  `,
    [postId]
  );
}

export function getPostByUserId(userId) {
  return db.query(
    `SELECT posts.*, users.photo, users.name FROM posts
  JOIN users ON users.id = posts.user_id
  WHERE posts.user_id = $1 ORDER BY date DESC`,
    [userId]
  );
}

export function getLikedPostsByUserDB(userId) {
  const result = db.query(`
    SELECT posts.*
    FROM posts
    INNER JOIN likes ON posts.id = likes.post_id
    WHERE likes.user_id = $1;`,
    [userId]
  );
  return result.rows;
}