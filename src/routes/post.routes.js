import { Router } from "express";
import { tokenValidate } from "../middlewares/tokenValidate.middleware.js";
import { newPost, getPost } from "../controllers/post.controllers.js";

const postRoutes = Router();

postRoutes.post("/home", tokenValidate, newPost);
postRoutes.get("/home", getPost);

export default postRoutes;
