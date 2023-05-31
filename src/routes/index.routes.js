import { Router } from "express";
import authRoutes from "./auth.routes.js";
import trendingRouter from "./trendings.routes.js";

const router = Router();
router.use(authRoutes);
router.use(trendingRouter)

export default router;