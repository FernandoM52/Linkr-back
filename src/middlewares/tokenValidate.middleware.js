import { db } from "../database/db.connection.js";

export async function tokenValidate(req, res, next) {
  const headers = req.headers.authorization;
  const token = headers?.replace("Bearer ", "");

  if (!token) {
    res.sendStatus(401);
    return;
  }

  try {
    const { rows } = await db.query(`SELECT * FROM sessions WHERE token = $1`, [
      token,
    ]);

    if (!rows[0]) {
      res.sendStatus(401);
      return;
    }

    const userId = rows[0].user_id;
    const { rows: users } = await db.query(
      `SELECT * FROM users WHERE id = $1`,
      [userId]
    );

    if (!users[0]) {
      res.sendStatus(401);
      return;
    }

    res.locals.userId = users[0].id; // Armazena o ID do usuário em res.locals.userId
    next();
  } catch (err) {
    res.status(500).send(err.message);
  }
}
