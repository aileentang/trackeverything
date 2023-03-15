-- CS 340 Project Step 6
-- Aileen Tang and Jennifer Hoang
-- Description: These are some Database Manipulation queries for our Project Website using the tracking database.

-- get all users to populate User dropdown
SELECT userID, name FROM Users;

-- get all tasks and user's names for List Tasks page
SELECT taskID, Users.name AS userID, Tasks.name, description, deadline, priorityLevel FROM Tasks
INNER JOIN Users ON Tasks.userID = Users.userID
ORDER BY taskID;

-- get a single task's data for the Update Task form
SELECT taskID, Users.userID, name, description, deadline, priorityLevel FROM Tasks
WHERE taskID = :task_ID_selected;

-- get all user data for List Users page
SELECT userID, name, email FROM Users;

-- get a single user's data for the Update User form
SELECT userID, name, email FROM Users
WHERE userID = :user_ID_selected;

-- get all category data for List Categories page
SELECT categoryID, Users.name AS userID, Categories.name, description FROM Categories
INNER JOIN Users ON Categories.userID = Users.userID
ORDER BY categoryID;

-- get all subtask data for List Subtasks page
SELECT subtaskID, taskID, name, description, deadline, priorityLevel FROM Subtasks;

-- get all teammate data for List Teammates page
SELECT teammateID, Users.name AS userID, Teammates.name, Teammates.email, phone FROM Teammates
INNER JOIN Users ON Teammates.userID = Users.userID
ORDER BY teammateID;

-- TasksAndCategories
SELECT Tasks.taskID, Tasks.name as taskName, Categories.categoryID, Categories.name as categoryName, Users.userID, Users.name as userName FROM TasksAndCategories 
INNER JOIN Tasks ON 
Tasks.taskID = TasksAndCategories.taskID 
INNER JOIN Categories ON 
Categories.categoryID = TasksAndCategories.categoryID INNER JOIN Users ON 
Users.userID = Tasks.userID;

--TasksAndTeammates
SELECT Tasks.taskID, Teammates.teammateID, Tasks.name as taskName, Teammates.name as teammateName, Users.userID, Users.name as userName FROM Tasks 
INNER JOIN TasksAndTeammates ON 
Tasks.taskID = TasksAndTeammates.taskID 
INNER JOIN Teammates ON 
TasksAndTeammates.teammateID = Teammates.teammateID 
INNER JOIN Users ON 
Users.userID = Tasks.userID;

--SubtasksAndCategories
SELECT Subtasks.subtaskID, Categories.categoryID, Subtasks.name as subtaskName, Categories.name as categoriesName, Users.userID, Users.name as userName FROM SubtasksAndCategories
INNER JOIN Categories ON
SubtasksAndCategories.categoryID = Categories.categoryID
INNER JOIN Subtasks ON
Subtasks.subtaskID = SubtasksAndCategories.categoryID
INNER JOIN Tasks ON 
Tasks.taskID = Subtasks.taskID
INNER JOIN Users ON
Users.userID = Tasks.taskID;

--SubtasksAndTeammates
SELECT Subtasks.subtaskID, Teammates.teammateID, Subtasks.name as subtaskName, Teammates.name as teammateName, Users.userID, Users.name as userName FROM Subtasks
INNER JOIN SubtasksAndTeammates ON
Subtasks.subtaskID = SubtasksAndTeammates.subtaskID
INNER JOIN Teammates ON
SubtasksAndTeammates.teammateID = Teammates.teammateID
INNER JOIN Tasks ON 
Tasks.taskID = Subtasks.taskID
INNER JOIN Users ON
Users.userID = Tasks.userID;

-- add a new task
INSERT INTO Tasks (name, description, deadline, priorityLevel) VALUES
    (:nameInput, :descriptionInput, :deadlineInput, :priorityLevelInput);

-- add a new user
INSERT INTO Users (name, email) VALUES
    (:nameInput, :emailInput);

-- add a new category
INSERT INTO Categories (userID, name, description) VALUES
    (:userIDInput, :nameInput, :descriptionInput);

-- add a new subtask
INSERT INTO Subtasks (taskID, name, description, deadline, priorityLevel) VALUES
    (:taskIDInput, :nameInput, :descriptionInput, :deadlineInput, :priorityLevelInput);

-- update a category's data
UPDATE Categories
    SET name = :nameInput, description = :descriptionInput
    WHERE categoryID = :category_ID_from_update_form;

-- delete a task
DELETE FROM Tasks WHERE taskID = :task_ID_selected;

-- delete a user
DELETE FROM Users WHERE userID = :user_ID_selected;

-- delete a category
DELETE FROM Categories WHERE categoryID = :category_ID_selected;

-- delete a subtask
DELETE FROM Subtasks WHERE subtaskID = :subtask_ID_selected;
