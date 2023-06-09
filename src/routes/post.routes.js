import { Router } from "express";
import { tokenValidate } from "../middlewares/tokenValidate.middleware.js";
import {
  newPost,
  getPost,
  likePost,
  getPostById,
  deletePost,
} from "../controllers/post.controllers.js";

const postRoutes = Router();

postRoutes.use(tokenValidate);
postRoutes.post("/home", newPost);
postRoutes.post("/like/:postId", likePost);
postRoutes.get("/home", getPost);
postRoutes.get("/posts/:id", getPostById);
postRoutes.delete("/home/:id", deletePost);

export default postRoutes;
