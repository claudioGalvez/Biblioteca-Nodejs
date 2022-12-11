const mysql = require('mysql');
const { promisify} = require('util');

const { database } = require('./keys');

const pool = mysql.createPool(database);

pool.getConnection((err, Connection) => {
    if (err){
        if (err.code == 'PROTOCOL_CONNECTION_LOST') {
            console.error('DATABASE CONNECTIONWAS CLOSED');
        }
        if (err.code === 'ER_CON_COUNT_ERROR') {
            console.error('DATABASE HAS TO MANY CONNECTIONS');
        }
        if (err.code === 'ECONNREFUSED') {
            console.error('DATABASE CONNECTION WAS REFUSED');
        }
    }

    if(Connection) Connection.release();
        console.log('DB is Connected');
        return;
});

// Promisify Pool Querys
pool.query = promisify(pool.query);

module.exports = pool;