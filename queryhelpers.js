'use strict';
// Express
// We are using the express library for the web server
var express = require('express');   
// We need to instantiate an express object to interact with the server in our code
var app = express(); 
// Set a port number at the top so it's easy to change in the future           
PORT = 64052;                 

// Database
var db = require('./db-connector')

 // Define our queries
 query1 = 'SELECT * FROM Subtasks;';
 query2 = 'SELECT * FROM Tasks;';

 // Execute every query in an asynchronous manner, we want each query to finish before the next one starts

const selectAllQuery = (table) => {
    let queryParam = `SELECT * FROM ${table}`;
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results);
    });
}

const insertQuery = (objParams, table) => {
    // objParams = array of parameters
    let newValue = "("
    for (let i = 0; i < objParams.length; i++) {
        newValue += objParams[i]
        newValue += ","
    }
    newValue += ");"
    let queryParam = `INSERT INTO ${table.toUpperCase()} VALUES ${newValue}`;
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results)
    });
}

const updateQuery = (objParams, selectParams, table) => {
    // objParams = Javascript object, 
    // key-value pairs for conditions to change
    // key-value pairs for item to select 
    let valuesToChange = "";
    for (const key in objParams) {
        valuestoChange += `${key} = ${objParams[key]}`;
        valuestoChange += ",";
    }
    // Remove last comma
    valuesToChange = valuesToChange.slice(-1);

    let itemsToSelect = "";
    for (const key in selectParams) {
        itemsToSelect += `${key} = ${selectParams[key]}`;
        itemsToSelect += ",";
    }
    // Remove last comma
    itemsToSelect = itemsToSelect.slice(-1);

    console.log(`valuesToChange: ${valuesToChange}`)
    let queryParam = `UPDATE ${table.toUpperCase()} SET ${valuesToChange} WHERE ${itemsToSelect}`;
    console.log(queryParam);
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results);
    });
}

const deleteQuery = (selectParams, table) => {
    let itemsToSelect = "";
    for (const key in selectParams) {
        itemsToSelect += `${key} = ${selectParams[key]}`;
        itemsToSelect += ",";
    }
    // Remove last comma
    itemsToSelect = itemsToSelect.slice(-1);

    let queryParam = `DELETE FROM ${table.toUpperCase()} WHERE ${selectParam}`;
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results);
    });
}
