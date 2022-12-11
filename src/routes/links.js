const express = require('express');
const router = express.Router();

const pool = require('../database');

router.get('/add', (req, res) => {
    res.render('links/add');
})

router.post('/add', (req, res) => {
    res.send('received');
});

router.get('/', async (req, res) => {
    const links = await pool.query('SELECT * FROM libros');
    console.log(links);
    res.render('links/list', { links })
})

module.exports = router;