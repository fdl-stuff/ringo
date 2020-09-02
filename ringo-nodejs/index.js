const mysql = require('mysql');

const connection = mysql.createConnection({
    host : 'localhost',
    user : 'root',
    password : 'sutekina#SQL',
    database : 'ringo'
}); 

connection.connect();

let input = {
    email: 'other@info.com',
    sha256: '5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8',
    created_at: '2020-05-12',
	birth_date: '1970-01-01', 
    first_name: 'Other person',
    last_name: 'surname'
}

let inputKeys = Object.keys(input);
let inputValues = Object.values(input);
let inputPlaceholders = [];

for(let i = 0; i < inputValues.length; i++) inputPlaceholders.push("?");

let inputQuery = `INSERT INTO users(${inputKeys.join(", ")})
                  VALUES(${inputPlaceholders.join(", ")})`;

connection.query(inputQuery, inputValues, function(err, res, fields) {
    if (err) throw err;
    logUsers(res)
})

connection.query(`SELECT * FROM users`, function(err, res, fields) {
    if (err) throw err;
    logUsers(res)
})

function logUsers(data) {
    console.log(data);
}

connection.end();