import { Router } from "express";
import { getPostByUser } from "../controllers/post.controllers.js";
import { getLikedPostsByUser, searchUser } from "../controllers/user.controller.js";
import { tokenValidate } from "../middlewares/tokenValidate.middleware.js";

const userRouter = Router();

userRouter.get("/user/:id", getPostByUser);
userRouter.get("/user/name/:name", searchUser);
userRouter.get("/liked-posts", tokenValidate, getLikedPostsByUser);


export default userRouter;
