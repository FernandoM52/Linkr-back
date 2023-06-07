import { Router } from "express";
import { tokenValidate } from "../middlewares/tokenValidate.middleware.js";
import { getPostByUser } from "../controllers/post.controllers.js";

const userRouter = Router();

userRouter.get("/user/:id", getPostByUser);

export default userRouter;
