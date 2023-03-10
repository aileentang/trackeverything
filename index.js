const mysql = require('mysql');

const con = mysql.createConnection({
  host     : 'database-1.cpghishhlixw.us-west-2.rds.amazonaws.com',
  user     : 'admin',
  password : 'Ucla2018!',
  port     : 3306,
  database : 'TaskTracker'
});

exports.handler = (event, context, callback) => {
    // allows for using callbacks as finish/error-handlers
    // console.log(event);
    context.callbackWaitsForEmptyEventLoop = false;
    console.log(event);

    const noSupportResponse = {
        statusCode: 200,
        body: "We currently do not support AND and OR SQL queries"
    };
    
    if (event.path === "/users") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                con.query(selectAllQuery("Users"), (err, res) => {
                  callback(null, generateResponse(err,res));
                })
            } else if (Object.keys(event.queryStringParameters).length === 1) {
                let queryString = selectItemQuery(event.queryStringParameters, "Users");
                con.query(queryString, (err, res) => {
                  callback(null, generateResponse(err,res));
                })
            } else {
                callback(null, noSupportResponse);
            }
        }
        else if (event.httpMethod === "POST") {
            const queryString = insertQuery(event.queryStringParameters, "Users");
            con.query(queryString, (err, res) => {
                callback(null, generateResponse(err,res));
            })
        }
        else {
            
        }
    }
    else if (event.path === "/tasks") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                con.query(selectAllQuery("Tasks"), (err, res) => {
                    callback(null, generateResponse(err,res));
                })
            }
            else if (Object.keys(event.queryStringParameters).length === 1) {
                let queryString = selectItemQuery(event.queryStringParameters, "Tasks");
                con.query(queryString, (err, res) => {
                    callback(null, generateResponse(err,res));
                })
            } else {
                callback(null, noSupportResponse);
            }
        }
        else if (event.httpMethod === "POST") {
            const queryString = insertQuery(event.queryStringParameters, "Tasks");
            con.query(queryString, (err, res) => {
                callback(null, generateResponse(err,res));
            })
        }
        else if (event.httpMethod === "DELETE") {
            const queryString = deleteQueryBasedOnID(event.queryStringParameters, "Tasks");
            con.query(queryString, (err, res) => {
                callback(null, generateResponse(err,res));
            })
        }
    }
    else if (event.path === "/subtasks") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                con.query(selectAllQuery("Subtasks"), (err, res) => {
                    callback(null, generateResponse(err,res));
                })
            } else if (Object.keys(event.queryStringParameters).length === 1) {
                let queryString = selectItemQuery(event.queryStringParameters, "Subtasks");
                con.query(queryString, (err, res) => {
                    callback(null, generateResponse(err,res));
                })
            } else {
                callback(null, noSupportResponse);
            }
        }
        else if (event.httpMethod === "POST") {
            const queryString = insertQuery(event.queryStringParameters, "Subtasks");
            con.query(queryString, (err, res) => {
                callback(null, generateResponse(err,res));
            })
        }
    }
    else if (event.path === "/teammates") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                con.query(selectAllQuery("Teammates"), (err, res) => {
                    callback(null, generateResponse(err,res));
                })
            } else if (Object.keys(event.queryStringParameters).length === 1) {
                let queryString = selectItemQuery(event.queryStringParameters, "Teammates");
                con.query(queryString, (err, res) => {
                    callback(null, generateResponse(err,res));
                })
            } else {
                callback(null, noSupportResponse);
            }
        }
        else if (event.httpMethod === "POST") {
            const queryString = insertQuery(event.queryStringParameters, "Teammates");
            con.query(queryString, (err, res) => {
                callback(null, generateResponse(err,res));
            })
        }
    }
    else if (event.path === "/categories") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                con.query(selectAllQuery("Categories"), (err, res) => {
                    callback(null, generateResponse(err,res));
                })
            } else if (Object.keys(event.queryStringParameters).length === 1) {
                let queryString = selectItemQuery(event.queryStringParameters, "Categories");
                con.query(queryString, (err, res) => {
                    callback(null, generateResponse(err,res));
                })
            } else {
                callback(null, noSupportResponse);
            }
        }
        else if (event.httpMethod === "POST") {
            const queryString = insertQuery(event.queryStringParameters, "Categories");
            con.query(queryString, (err, res) => {
                callback(null, generateResponse(err, res));
            })
        }
        else if (event.httpMethod === "PUT") {
            let queryObject = event.queryStringParameters;
            let updateParams = decodeURI(queryObject.updateParams);
            let selectParams = decodeURI(queryObject.selectParams);
            const queryString = updateQuery(updateParams, selectParams, "Categories");

            con.query(queryString, (err, res) => {
                callback(null, generateResponse(err, res));
            })
        }
    }
    else if (event.path === "/tasksandteammates") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                let queryString = "SELECT Tasks.taskID, Teammates.teammateID, Tasks.name as taskName, Teammates.name as teammateName, Users.userID, Users.name as userName FROM Tasks INNER JOIN TasksAndTeammates ON Tasks.taskID = TasksAndTeammates.taskID INNER JOIN Teammates ON TasksAndTeammates.teammateID = Teammates.teammateID INNER JOIN Users ON Users.userID = Tasks.userID;"
                con.query(queryString, (err, res) => {
                    callback(null, generateResponse(err, res));
                })
            }
        }
    }
    else if (event.path === "/subtasksandteammates") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                let queryString = "SELECT Subtasks.subtaskID, Teammates.teammateID, Subtasks.name as subtaskName, Teammates.name as teammateName, Users.userID, Users.name as userName FROM Subtasks INNER JOIN SubtasksAndTeammates ON Subtasks.subtaskID = SubtasksAndTeammates.subtaskID INNER JOIN Teammates ON SubtasksAndTeammates.teammateID = Teammates.teammateID INNER JOIN Tasks ON Tasks.taskID = Subtasks.taskID INNER JOIN Users ON Users.userID = Tasks.userID;";
                con.query(queryString, (err, res) => {
                    callback(null, generateResponse(err, res));
                })
            }
        }
    }
    else if (event.path === "/tasksandcategories") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                let queryString = "SELECT Tasks.taskID, Tasks.name as taskName, Categories.categoryID, Categories.name as categoryName, Users.userID, Users.name as userName FROM TasksAndCategories INNER JOIN Tasks ON Tasks.taskID = TasksAndCategories.taskID INNER JOIN Categories ON Categories.categoryID = TasksAndCategories.categoryID INNER JOIN Users ON Users.userID = Tasks.userID;";
                con.query(queryString, (err, res) => {
                    callback(null, generateResponse(err, res));
                })
            }
        }
    }
    else if (event.path === "/subtasksandcategories") {
        if (event.httpMethod === "GET") {
            if (event.queryStringParameters === null) {
                let queryString = "SELECT Subtasks.subtaskID, Categories.categoryID, Subtasks.name as subtaskName, Categories.name as categoryName, Users.userID, Users.name as userName FROM SubtasksAndCategories INNER JOIN Categories ON SubtasksAndCategories.categoryID = Categories.categoryID INNER JOIN Subtasks ON Subtasks.subtaskID = SubtasksAndCategories.categoryID INNER JOIN Tasks ON Tasks.taskID = Subtasks.taskID INNER JOIN Users ON Users.userID = Tasks.taskID;"
                con.query(queryString, (err, res) => {
                    callback(null, generateResponse(err, res));
                })
            }
        }
    }
};

function selectAllQuery (table) {
    let queryParam = `SELECT * FROM ${table};`;
    return queryParam;
}

function selectItemQuery (selectParams, table) {
    // selectParams is a JS Object and contains
    // key-value pairs for item to select 
    let selectParamString= generateSelectParam(selectParams);

    let queryParam = `SELECT * FROM ${table} WHERE ${selectParamString};`;
    return queryParam;
}

function insertQuery (insertObject, table) {
    let insertObjectParams = generateInsertParam(insertObject);
    let insertKeyString = insertObjectParams[0];
    let insertValueString = insertObjectParams[1];
    let queryParam = `INSERT INTO ${table} ${insertKeyString} VALUES ${insertValueString};`;
    return queryParam;
}

function updateQuery (updateParams, selectParams, table) {
    // objParams is a JS Object and contains key-value pairs for conditions to change
    // selectParams is a JS Object and contains key-value pairs for item to select 
    let updateParamString = generateUpdateParam(JSON.parse(updateParams));
    let selectParamString = generateSelectParam(JSON.parse(selectParams));

    let queryParam = `UPDATE ${table} SET ${updateParamString} WHERE ${selectParamString};`;
    return queryParam;
}

function deleteQueryBasedOnID(selectParams, table) {
    let selectParamString = "";
    for (const key in selectParams) {
        selectParamString += `${key} = ${selectParams[key]}`;
        selectParamString += ",";
    }
    // Remove last comma
    selectParamString = selectParamString.slice(0,-1);

    let queryParam = `DELETE FROM ${table} WHERE ${selectParamString};`;
    return queryParam;
}

/*
* Generate Functions
*/

function generateSelectParam(selectParams) {
    let selectParamString = "";
    for (const key in selectParams) {
        if (!isNaN(parseInt(selectParams[key]))) {
             // No quotations needed for int queries
            selectParamString += `${key} = ${selectParams[key]},`;
        }
        else {
            selectParamString += `${key} = '${decodeURI(selectParams[key])}',`;
        }
    }
    // Remove last comma
    selectParamString = selectParamString.slice(0,-1);
    return selectParamString;
}


function generateUpdateParam(updateParams) {
    let updateParamString = "";
    for (const key in updateParams) {
        updateParamString += `${key} = ${updateParams[key]}`;
        updateParamString += ",";
    }
    // Remove last comma
    updateParamString = updateParamString.slice(0,-1);
    return updateParamString;
}

/*INSERT INTO Tasks (userID, name, description, deadline, priorityLevel) VALUES 
    (1, "Task1", "This is a description for Task 1", "2023-01-01 11:59:59", NULL)*/

function generateInsertParam(insertParam) {
    let insertKeyString = "(";
    let insertValueString = "(";
    for (const key in insertParam) {
        if (!isNaN(parseInt(insertParam[key]))) {
                // No quotations needed for int queries
            insertKeyString += `${key},`;
            insertValueString +=  `${insertParam[key]},`;
        }
        else {
            insertKeyString += `${key},`;
            insertValueString +=  `"${decodeURI(insertParam[key])}",`;
        }
    }
    // Remove last comma
    insertKeyString = insertKeyString.slice(0,-1);
    insertValueString = insertValueString.slice(0,-1);
    insertKeyString += ")"
    insertValueString += ")"
    return [insertKeyString, insertValueString];
}

function generateResponse (err, res) {
    if (err) {
        const response = {
            statusCode:400,
            headers: {
                "Access-Control-Allow-Origin": "*",
                "Access-Control-Allow-Headers": "*"
            },
            body: JSON.stringify(err)
        };
        return response;
    } else {
        const response = {
        statusCode: 200,
        headers: {
            "Access-Control-Allow-Origin": "*",
            "Access-Control-Allow-Headers": "*"
        },
        body: JSON.stringify(res)
        };
        return response
    }
}
