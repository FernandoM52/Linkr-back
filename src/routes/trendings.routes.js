import { Router } from "express";
import { tokenValidate } from "../middlewares/tokenValidate.middleware.js";
import { getTrendings, getPostsByTrendings } from "../controllers/trendings.controller.js";


const trendingRouter = Router();

trendingRouter.get("/trendings", getTrendings);
trendingRouter.get("/hashtag/:hashtag", tokenValidate, getPostsByTrendings);

export default trendingRouter;