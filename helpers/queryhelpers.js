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

const selectAllQuery = (table) => {
    let queryParam = `SELECT * FROM ${table};`;
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results);
    });
}

const selectItemQuery = (selectParams, table) => {
    // selectParams is a JS Object and contains
    // key-value pairs for item to select 
    let = generateSelectParam(selectParams);

    let queryParam = `SELECT * FROM ${table} where ${selectParamString};`;
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results);
        return results;
    });
}

const insertQuery = (insertObject, table) => {
    // objParams = array of argument
    insertParams = Object.keys(insertObject);
    insertInfo = Object.keys(insertObject).map(key => insertObject[key]);
    let insertParamsString = generateInsertParam(insertParams);
    let insertInfoString = generateInsertParam(insertInfo);
    let queryParam = `INSERT INTO ${table} ${insertParamsString} VALUES ${insertInfoString};`;
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results)
        return results;
    });
}

const updateQuery = (updateParams, selectParams, table) => {
    // objParams is a JS Object and contains key-value pairs for conditions to change
    // selectParams is a JS Object and contains key-value pairs for item to select 
    let updateParamString = generateUpdateParam(updateParams);
    let selectParamString = generateSelectParam(selectParams);

    console.log(`objParamString: ${objParamString}`)
    console.log(`selectParamString: ${selectParamString}`)

    let queryParam = `UPDATE ${table} SET ${objParamString} WHERE ${updateParamString};`;
    console.log(queryParam);
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results);
        return results;
    });
}

const deleteQuery = (selectParams, table) => {
    let selectParamString = "";
    for (const key in selectParams) {
        selectParamString += `${key} = ${selectParams[key]}`;
        selectParamString += ",";
    }
    // Remove last comma
    selectParamString = selectParamString.slice(-1);

    let queryParam = `DELETE FROM ${table} WHERE ${selectParamString};`;
    db.pool.query(queryParam, (err, results, fields) => {
        console.log(results);
        return results;
    });
}

/*
* Generate Functions
*/

const generateSelectParam = (selectParams) => {
    let selectParamString = "";
    for (const key in selectParams) {
        if (typeof selectParams[key] == "string" || typeof selectParams[key] == "object") {
            selectParamString += `${key} = '${selectParams[key]}'`;
            selectParamString += ",";
        }
        else {
            // No quotations needed for int queries
            selectParamString += `${key} = ${selectParams[key]}`;
            selectParamString += ",";
        }
    }
    // Remove last comma
    selectParamString = selectParamString.slice(-1);
    return selectParamsString;
}

const generateUpdateParam = (updateParams) => {
    let updateParamString = "";
    for (const key in updateParams) {
        updateParams += `${key} = ${updateParams[key]}`;
        updateParams += ",";
    }
    // Remove last comma
    updateParamString = updateParamString.slice(-1);
    return updateParamString;
}

const generateInsertParam = (insertParam) => {
    let insertParamString = "("
    for (let i = 0; i < insertParam.length; i++) {
        insertParamString += insertParam[i]
        insertParamString += ","
    }
    insertParamString = insertParamString.slice(-1);
    insertParamString += ")"
    return insertParamString;
}

/*
 // DROP TABLE...
 db.pool.query(query1, function (err, results, fields){
     console.log(results)

     // CREATE TABLE...
     db.pool.query(query2, function(err, results, fields){
         console.log(results)

         // Send the results to the browser
         let base = "<h1>MySQL Results:</h1>"
         res.send(base + JSON.stringify(results));
     });
 });
 */
