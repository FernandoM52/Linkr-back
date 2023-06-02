import { Router } from "express";
import { signIn, signUp , logOut} from "../controllers/auth.controllers.js";

const authRoutes = Router();

authRoutes.post("/", signIn);
authRoutes.post("/sign-up", signUp);
authRoutes.delete("/logout/:token", logOut)

export default authRoutes;