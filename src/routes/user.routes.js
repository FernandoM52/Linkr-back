import { Router } from "express";
import { getPostByUser } from "../controllers/post.controllers.js";
import { searchUser } from "../controllers/user.controller.js";

const userRouter = Router();

userRouter.get("/user/:id", getPostByUser);
userRouter.get("/user/name/:name", searchUser);

export default userRouter;
