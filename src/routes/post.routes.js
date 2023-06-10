import { Router } from "express";
import { tokenValidate } from "../middlewares/tokenValidate.middleware.js";
import {
  newPost,
  getPost,
  likePost,
  getPostById,
  deletePost,
  editPost,
} from "../controllers/post.controllers.js";

const postRoutes = Router();

postRoutes.post("/home", tokenValidate, newPost);
postRoutes.get("/home", getPost);
postRoutes.get("/posts/:id", getPostById);
postRoutes.post("/like/:postId", tokenValidate, likePost);
postRoutes.delete("/home/:id", tokenValidate, deletePost);
postRoutes.put("/home/:id", tokenValidate, editPost);

export default postRoutes;
