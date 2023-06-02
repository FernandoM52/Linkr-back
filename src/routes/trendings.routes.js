import { Router } from "express";
import { getPostsByTrendings } from "../controllers/trendings.controller.js";


const trendingRouter = Router();

trendingRouter.get("/hashtag/:hashtag", getPostsByTrendings);

export default trendingRouter;