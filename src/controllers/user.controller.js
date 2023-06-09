import { db } from "../database/db.connection.js";
import { getLikedPostsByUserDB } from "../repositories/posts.repository.js";

export async function searchUser(req, res) {
  const { name } = req.params;
  const queryName = name.replace(`${name}`, `%${name}%`);

  try {
    const matchUsersList = await db.query(
      `SELECT users.id, users.name, users.photo  FROM users WHERE upper(name) LIKE upper($1);
    `,
      [queryName]
    );

    res.send(matchUsersList.rows);
  } catch (err) {
    return res.status(500).send(err.message);
  }
}

export async function getLikedPostsByUser(req, res) {
  const { id } = res.locals.user;
  if (!id) return res.status(400).send("User ID is missing");

  try {
    const likedPosts = await getLikedPostsByUserDB(id);
    res.send(likedPosts);
  } catch (err) {
    return res.status(500).send(err.message);
  }
}