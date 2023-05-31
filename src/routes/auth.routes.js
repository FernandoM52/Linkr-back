import { Router } from "express";
import { signIn, signUp } from "../controllers/auth.controllers.js";

const authRoutes = Router();

authRoutes.post("/", signIn);
authRoutes.post("/sign-up", signUp);

export default authRoutes;