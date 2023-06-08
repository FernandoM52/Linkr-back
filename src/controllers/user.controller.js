import { db } from "../database/db.connection.js";

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
