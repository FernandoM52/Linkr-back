import { getPostsByTrendingsDB, getTrendingsDB } from "../repositories/trendings.repository.js";

export async function getTrendings(req, res) {
  try {
    const trendings = await getTrendingsDB();
    res.send(trendings.rows);
  } catch (err) {
    res.status(500).send(err.message);
  }
}

export async function getPostsByTrendings(req, res) {
  try {
    const posts = await getPostsByTrendingsDB(req.params);
    if (posts.length === 0) return res.send("Não há posts com esta hashtag");

    res.send(posts);
  } catch (err) {
    res.status(500).send(err.message);
  }
}