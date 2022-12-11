const passport = require('passport');
const LocalStrategy = require('passport-local').Strategy;

const pool = require('../database');
const helpers = require('./helpers');

passport.use('local.signin', new LocalStrategy( {
    usernameField: 'username',
    passwordField: 'password',
    passReqToCallback: true
}, async (req, username, password, done) => {
    const rows = await pool.query('SELECT * FROM alumnos WHERE username = ?', [username]);
    if (rows.length > 0 ) {
        const user = rows[0];
        const validPassword = await helpers.matchPassword(password, user.password)
        if (validPassword) {
            done(null, user, req.flash('success', 'Welcome' + user.username));
        } else {
            done(null, false, req.flash('message', 'Password Incorrecta'));
        }
    } else {
        return done(null, false, req.flash('message', 'Usuario No Existe'));
    }
}));

passport.use('local.signup', new LocalStrategy( {
    usernameField: 'username',
    passwordField: 'password',
    passReqToCallback: true
}, async (req, username, password, done) => {
    const { nombre } = req.body;
    const { direccion } = req.body;
    const { email } = req.body;
    let newUser = {
        username,
        password,
        nombre,
        direccion,
        email
    };
    newUser.password = await helpers.encryptPassword(password);

//    const rows = await pool.query('SELECT * FROM alumnos WHERE username = ?', [username]);
//    if (rows.length > 0 ) {
//        done(null, null, req.flash('message', 'Usuario Ya Existe'));
//    } else {
        const result = await pool.query('INSERT INTO alumnos SET ?', [newUser]);
        newUser.id = result.insertId;
        return done(null, newUser);
//        return done(null, username, req.flash('success', 'Usuario Registrado Correctamente'));
//    }
}));

passport.serializeUser((user, done) => {
    console.log(user);
    done(null, user.id);
});

passport.deserializeUser(async (id, done) => {
    const rows = await pool.query('SELECT * FROM alumnos WHERE id = ?', [id]);
    done(null, rows[0]);
});