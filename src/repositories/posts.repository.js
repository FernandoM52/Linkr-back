import { db } from "../database/db.connection.js";

export async function createPostDB(id, link, title, description, image, content) {
  const post = await db.query(
    `INSERT INTO posts (user_id, link, title, description, image, content) VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
    [id, link, title, description, image, content]
  );
  return post;
}