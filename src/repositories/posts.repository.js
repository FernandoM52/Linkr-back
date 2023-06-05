import { db } from "../database/db.connection.js";

export async function createPostDB(id, link, title, description, image, content) {
  const post = await db.query(
    `INSERT INTO posts (user_id, link, title, description, image, content) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
    [id, link, title, description, image, content]
  );
  return post;
}

export async function likePostById(userId, postId) {
  const isLiked = await db.query(
    `SELECT * FROM likes WHERE post_id = $1 AND user_id = $2`,
    [postId, userId]
  );

  if (isLiked.rowCount > 0) {
    await db.query(
      `DELETE FROM likes WHERE post_id = $1 AND user_id = $2`,
      [postId, userId]
    );

    await db.query(
      `UPDATE posts SET likes_count = likes_count - 1 WHERE id = $1`,
      [postId]
    );
  } else {
    await db.query(
      `INSERT INTO likes (post_id, user_id) VALUES ($1, $2)`,
      [postId, userId]
    );

    await db.query(
      `UPDATE posts SET likes_count = likes_count + 1 WHERE id = $1`,
      [postId]
    );
  }
}

export function getPostId(postId) {
  return db.query(`
    SELECT likes.post_id, users.name
    FROM likes
    JOIN users ON users.id = likes.user_id
    WHERE likes.post_id = $1
  `, [postId]);
}