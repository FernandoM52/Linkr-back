import bcrypt from 'bcrypt';
import { db } from "../database/db.connection.js"
import { v4 as uuidV4 } from 'uuid'
import { signUpSchema, signInSchema } from '../schemas/auth.schemas.js';

export async function signUp(req, res) {
    const { name, email, password, photo } = req.body;

    try {
        await signUpSchema.validateAsync(req.body);

        const existingUser = await db.query('SELECT * FROM users WHERE email = $1', [email]);

        if (existingUser.rows.length > 0) {
            return res.status(409).send("E-mail already exists");
        }

        const hashedPassword = bcrypt.hashSync(password, 10);
        await db.query(`
        INSERT INTO users (name, email, password, photo) VALUES ($1, $2, $3, $4)`
        , [name, email, hashedPassword, photo]);

        res.status(201).send("User created successfully");
    } catch (error) {
        if (error.details) {
            const errors = error.details.map((detail) => detail.message);
            return res.status(422).send(errors);
        } else {
            return res.status(500).send("Internal server error");
        }
    }
}

export async function signIn(req, res) {
    const { email, password } = req.body;

    try {
        await signInSchema.validateAsync(req.body);

        const userExist = await db.query('SELECT * FROM users WHERE email = $1', [email]);

        if (userExist.rows.length === 0) {
            return res.status(400).send("Incorrect email or password");
        }

        const matchPassword = bcrypt.compareSync(password, userExist.rows[0].password);
        if (!matchPassword) {
            return res.status(400).send("Incorrect email or password");
        }

        const token = uuidV4();

        await db.query(`
            INSERT INTO sessions (user_id, token) VALUES ($1, $2)`
            , [userExist.rows[0].id, token]);

        const session = await db.query('SELECT * FROM sessions WHERE token = $1', [token]);

        return res.send(session.rows[0]);
    } catch (error) {
        if (error.details) {
            const errors = error.details.map((detail) => detail.message);
            return res.status(422).send(errors);
        } else {
            return res.status(500).send("Internal server error");
        }
    }
}