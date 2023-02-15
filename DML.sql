-- These are some Database Manipulation queries for a partially implemented Project Website 
-- using the tracking database.

-- get all users for List User page
SELECT Users.userID, name, email FROM Users

-- get all user IDs, names and emails to populate User dropdown
SELECT userID, name FROM Users

-- get all task IDs, users, task names, descriptions, deadlines and priority levels for Tasks page
SELECT Tasks.taskID, Users.name AS userID, name, description, deadline, priorityLevel
    FROM Tasks
        INNER JOIN Users
        ON userID = Users.userID

-- get a single task's data for the Update Task form
SELECT taskID, userID, name, description, deadline, priorityLevel
    FROM Tasks
    WHERE taskID = :task_ID_selected

-- add a new task
INSERT INTO Tasks (name, description, deadline, priorityLevel) VALUES
    (:nameInput, :descriptionInput, :deadlineInput, :priorityLevelInput)

-- update a task's data
UPDATE Tasks
    SET name = :nameInput, description = :descriptionInput,
        deadline = :deadlineInput, priorityLevel = :priorityLevelInput
    WHERE taskID = :task_ID_from_update_form

-- delete a task
DELETE FROM Tasks WHERE taskID = :task_ID_selected
