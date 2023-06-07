import { Router } from "express";
import authRoutes from "./auth.routes.js";
import postRoutes from "./post.routes.js";
import trendingRouter from "./trendings.routes.js";
import userRouter from "./user.routes.js";

const router = Router();
router.use(authRoutes);
router.use(postRoutes);
router.use(trendingRouter);
router.use(userRouter);

export default router;
