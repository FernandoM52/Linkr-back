import { Router } from "express";
import { getTrendings, getPostsByTrendings } from "../controllers/trendings.controller.js";


const trendingRouter = Router();

trendingRouter.get("/trendings", getTrendings);
trendingRouter.get("/hashtag/:hashtag", getPostsByTrendings);

export default trendingRouter;