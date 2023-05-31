import { Router } from "express";
import { getPostsByHashtag } from "../controllers/tendings.controller.js";


const trendingRouter = Router();

trendingRouter.get("/hashtag/:hashtag", getPostsByHashtag);

export default trendingRouter;