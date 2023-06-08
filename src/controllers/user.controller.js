import { db } from "../database/db.connection.js";

export async function searchUser(req, res) {
  const { name } = req.params;
  try {
    await db.query(
      `SELECT * FROM users WHERE name LIKE $1;
    `,
      [name]
    );
  } catch (err) {
    return res.status(500).send(err.message);
  }
}
