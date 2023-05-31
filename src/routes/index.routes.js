import { Router } from "express";
import authRoutes from "./auth.routes.js";
import postRoutes from "./post.routes.js";
import trendingRouter from "./trendings.routes.js";

const router = Router();
router.use(authRoutes);
router.use(postRoutes);
router.use(trendingRouter);

export default router;
