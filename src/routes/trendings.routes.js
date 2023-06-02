import { Router } from "express";
import { getPostsByHashtag } from "../controllers/trendings.controller.js";


const trendingRouter = Router();

trendingRouter.get("/hashtag/:hashtag", getPostsByHashtag);

export default trendingRouter;