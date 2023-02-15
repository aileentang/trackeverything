-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the tracking database.

-- get all users for List User page
SELECT Users.userID, name, email FROM Users

-- get all user IDs, names and emails to populate User dropdown
SELECT userID, name FROM Users

-- get all task IDs, users, task names, descriptions, deadlines and priority levels for Tasks page
SELECT Tasks.taskID, Users.name AS userID, Tasks.name, Tasks.description, Tasks.deadline, Tasks.priorityLevel FROM Tasks INNER JOIN Users ON userID = Users.userID

-- add a new task
INSERT INTO Tasks (name, description, deadline, priorityLevel) VALUES
    (:nameInput, :descriptionInput, :deadlineInput, :priorityLevelInput)