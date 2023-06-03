import { db } from "../database/db.connection.js"

export async function findUser(name, email) {
    return db.query(`
        SELECT * FROM users 
        WHERE name=$1 
        OR email=$2
    `, [name, email]);
}

export async function findUserByEmail(email) {
    return db.query(`
        SELECT * FROM users 
        WHERE email=$1
    `, [email]);
}

export async function insertUser(email, name, photo, hashPassword) {
    return db.query(`
        INSERT INTO users (email, name, photo, password, created_at)
        VALUES ($1,$2,$3,$4,NOW());
    `, [email, name, photo, hashPassword]);
}

export async function insertSession(token,user){
    return db.query(`
        INSERT INTO sessions 
        (token, user_id, created_at) 
        VALUES ($1, $2,NOW())
    `,[token, user.rows[0].id]);
}

export async function deleteSession(user){
    return db.query(`
        DELETE FROM sessions 
        WHERE user_id = $1
    `,[user.rows[0].id]);
}

export async function deleteSessionByToken(token){
    return db.query(`
        DELETE FROM sessions 
        WHERE token = $1
    `,[token]);
}