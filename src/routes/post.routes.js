import { Router } from "express";
import { tokenValidate } from "../middlewares/tokenValidate.middleware.js";
import { newPost, getPost, likePost, getPostById } from "../controllers/post.controllers.js";

const postRoutes = Router();

postRoutes.post("/home", tokenValidate, newPost);
postRoutes.get("/home", getPost);
postRoutes.get("/posts/:id",getPostById)
postRoutes.post("/like/:postId", tokenValidate, likePost);

export default postRoutes;
