import { Router } from "express";
import { tokenValidate } from "../middlewares/tokenValidate.middleware.js";
import { getTrendings, getPostsByTrending } from "../controllers/trendings.controller.js";


const trendingRouter = Router();

trendingRouter.use(tokenValidate)
trendingRouter.get("/trendings", getTrendings);
trendingRouter.get("/hashtag/:hashtag", getPostsByTrending);

export default trendingRouter;