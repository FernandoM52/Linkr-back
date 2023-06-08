import { db } from "../database/db.connection.js";

export async function createPostWithHashtagDB(postId, id) {
  await db.query(
    `INSERT INTO posts_hashtag (posts_id, hashtags_id)
     VALUES ($1, $2);`,
    [postId, id]
  );
}

export async function getPostsWithHashtag(postId, id) {
  await db.query(
    `SELECT * FROM posts;`,
    [postId, id]
  );
}