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
