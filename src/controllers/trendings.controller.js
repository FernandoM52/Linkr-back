import { getPostsByTrendingDB, getTrendingsDB } from "../repositories/trendings.repository.js";

export async function getTrendings(req, res) {
  try {
    const trendings = await getTrendingsDB();
    res.send(trendings.rows);
  } catch (err) {
    res.status(500).send(err.message);
  }
}

export async function getPostsByTrending(req, res) {
  try {
    const posts = await getPostsByTrendingDB(req.params, req.query);
    res.send(posts);
  } catch (err) {
    res.status(500).send(err.message);
  }
}