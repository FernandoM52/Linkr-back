import bcrypt from 'bcrypt';
import { v4 as uuid } from 'uuid'
//import { signUpSchema, signInSchema } from '../schemas/auth.schemas.js';
import { deleteSession, deleteSessionByToken, findUser, findUserByEmail, insertSession, insertUser } from '../repositories/auth.repository.js';

export async function signUp(req, res) {
    try {
        const { email, password, name, photo } = req.body;
        const hashPassword = bcrypt.hashSync(password, 10);
        const user = await findUser(name, email)
        if (user.rows.length !== 0) {
            return res.sendStatus(409)
        }
        await insertUser(email, name, photo, hashPassword)
        return res.sendStatus(200)
    } catch (err) {
        return res.status(500).send(err.message)
    }
}

export async function signIn(req, res) {
    try {
        const { email, password } = req.body;
        const user = await findUserByEmail(email);

        if (
            user.rows.length !== 0 &&
            bcrypt.compareSync(password, user.rows[0].password)
        ) {
            const token = uuid();
            await deleteSession(user);
            await insertSession(token, user);
            return res.status(200).send({
                token,
                user: {
                    id: user.rows[0].id,
                    photo: user.rows[0].photo,
                    name: user.rows[0].name,
                },
            });
        } else {
            return res.status(401).send('Email e/ou senha incorreta');
        }
    } catch (err) {
        if (err.response && err.response.status === 401) {
            return res.status(401).send('Não autorizado');
        }
        return res.status(500).send(err.message);
    }
}

export async function logOut(req, res) {
    try {
        const token = req.params.token;

        if (!token) {
            return res.sendStatus(401)
        }
        await deleteSessionByToken(token);
        return res.sendStatus(204)
    } catch (err) {
        return res.status(500).send(err.message)
    }
}