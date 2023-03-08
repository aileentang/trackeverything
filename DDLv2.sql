SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;
-- Project Step 3 Draft
-- Aileen Tang and Jennifer Hoang
--
-- Host: mysql.eecs.oregonstate.edu    Database: `cs340_hoangje`

-- !!!!!!IMPORTANT!!!!!!!
-- Make sure you UNCHECK 'Enable foreign key checks' if you are copying and pasting the SQL into phpMyAdmin. 
-- If you don't, it won't import properly! 
-- phpMyAdmin doesn't like creating the foreign key constraints at the same time as the table. 
-- If you `source DDL.sql` from CLI it works fine.

--
-- Table structure for table `Users`
--
CREATE OR REPLACE TABLE Users(
    userID INT(20) NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL, 
    email VARCHAR(50),
    constraint UNIQUE(userID),
    PRIMARY KEY (userID)
);

--
-- Table structure for table `Tasks`
--
CREATE OR REPLACE TABLE Tasks(
    taskID INT(20) NOT NULL AUTO_INCREMENT,
    userID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    deadline DATETIME(0) NOT NULL,
    priorityLevel ENUM("Optional", "Low", "Medium", "High", "Critical"),
    FOREIGN KEY (userID) REFERENCES Users(userID)
    ON DELETE CASCADE,
    constraint UNIQUE(taskID),
    PRIMARY KEY (taskID)
);

--
-- Table structure for table `Subtasks`
--
CREATE OR REPLACE TABLE Subtasks(
    subtaskID INT(20) NOT NULL AUTO_INCREMENT,
    taskID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    deadline DATETIME(0) NOT NULL,
    priorityLevel ENUM("Optional", "Low", "Medium", "High", "Critical"),
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    constraint UNIQUE(subtaskID),
    PRIMARY KEY (subtaskID)
);

--
-- Table structure for table `Teammates`
--
CREATE OR REPLACE TABLE Teammates(
    teammateID INT(20) NOT NULL AUTO_INCREMENT,
    userID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(12),
    FOREIGN KEY (userID) REFERENCES Users(userID)
    ON DELETE CASCADE,
    constraint UNIQUE(teammateID),
    PRIMARY KEY (teammateID)
);

--
-- Table structure for table `Categories`
--
CREATE OR REPLACE TABLE Categories(
    categoryID INT(20) NOT NULL AUTO_INCREMENT,
    userID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    constraint UNIQUE(categoryID),
    FOREIGN KEY (userID) REFERENCES Users(userID)
    ON DELETE CASCADE,
    PRIMARY KEY (categoryID)
);

--
-- Table structure for table `TaskAndTeammates`
--
CREATE OR REPLACE TABLE TasksAndTeammates(
    taskID INT(20),
    teammateID INT(20),
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    FOREIGN KEY (teammateID) REFERENCES Teammates(teammateID)
    ON DELETE CASCADE,
    PRIMARY KEY (taskID, teammateID)
);

--
-- Table structure for table `SubtaskAndTeammates`
--
CREATE OR REPLACE TABLE SubtasksAndTeammates(
    subtaskID INT(20),
    teammateID INT(20),
    FOREIGN KEY (subtaskID) REFERENCES Subtasks(subtaskID)
    ON DELETE CASCADE,
    FOREIGN KEY (teammateID) REFERENCES Teammates(teammateID)
    ON DELETE CASCADE,
    PRIMARY KEY (subtaskID, teammateID)
);

--
-- Table structure for table `TaskAndCategories`
--
CREATE OR REPLACE TABLE TasksAndCategories(
    taskID INT(20),
    categoryID INT(20),
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    FOREIGN KEY (categoryID) REFERENCES Categories(categoryID)
    ON DELETE CASCADE,
    PRIMARY KEY (taskID, categoryID)
);

--
-- Table structure for table `SubtaskAndCategories`
--
CREATE OR REPLACE TABLE SubtaskAndCategories(
    subtaskID INT(20),
    categoryID INT(20),
    FOREIGN KEY (subtaskID) REFERENCES Subtasks(subtaskID)
    ON DELETE CASCADE,
    FOREIGN KEY (categoryID) REFERENCES Categories(categoryID)
    ON DELETE CASCADE,
    PRIMARY KEY (subtaskID, categoryID)
);


-----------------
-- INSERT DATA --
-----------------
 
--
-- Dumping data for table `Users`
--

INSERT INTO Users (name, email) VALUES 
    ("Person1", "person1@gmail.com"),
    ("Person2", "person2@gmail.com"),
    ("Person3", "person3@gmail.com"),
    ("Person4", NULL),
    ("Person5", "person5@gmail.com");

--
-- Dumping data for table `Tasks`
--

INSERT INTO Tasks (userID, name, description, deadline, priorityLevel) VALUES 
    (1, "Task1", "This is a description for Task 1", "2023-01-01 11:59:59", NULL),
    (1, "Task2", "This is a description for Task 2", "2023-01-02 11:59:59", "Optional"),
    (1, "Task3", "This is a description for Task 3", "2023-01-03 11:59:59", "Low"),
    (1, "Task4", NULL, "2023-01-04 11:59:59", "Medium"),
    (2, "Task5", "This is a description for Task 5", "2023-01-05 11:59:59", "High"),
    (2, "Task6", "This is a description for Task 6", "2023-01-06 11:59:59", "Critical"),
    (2, "Task7", "This is a description for Task 7", "2023-01-07 11:59:59", NULL),
    (2, "Task8", NULL, "2023-01-08 11:59:59", "Optional"),
    (3, "Task9", "This is a description for Task 9", "2023-01-09 11:59:59", "Low"),
    (3, "Task10", "This is a description for Task 10", "2023-01-10 11:59:59", "Medium"),
    (3, "Task11", "This is a description for Task 11", "2023-01-11 11:59:59", "High"),
    (3, "Task12", NULL, "2023-01-12 11:59:59", "Critical"),
    (4, "Task13", "This is a description for Task 13", "2023-01-13 11:59:59", NULL),
    (4, "Task14", "This is a description for Task 14", "2023-01-14 11:59:59", "Optional"),
    (4, "Task15", "This is a description for Task 15", "2023-01-15 11:59:59", "Low"),
    (4, "Task16", NULL, "2023-01-16 11:59:59", "Medium"),
    (5, "Task17", "This is a description for Task 17", "2023-01-17 11:59:59", "High"),
    (5, "Task18", "This is a description for Task 18", "2023-01-18 11:59:59", "Critical"),
    (5, "Task19", "This is a description for Task 19", "2023-01-19 11:59:59", NULL),
    (5, "Task20", NULL, "2023-01-20 11:59:59", "Optional");

--
-- Dumping data for table `Subtasks`
--
INSERT INTO Subtasks (taskID, name, description, deadline, priorityLevel) VALUES 
    (1, "Subtask 1", "Description for Subtask 1", "2023-03-01 11:59:59", NULL), 
    (1, "Subtask 2", "Description for Subtask 2", "2023-03-02 11:59:59", "Optional"),  
    (1, "Subtask 3", NULL, "2023-03-03 11:59:59", "Low"),
    (1, "Subtask 4", NULL, "2023-03-04 11:59:59", "Medium"),
    (5, "Subtask 5", "Description for Subtask 5", "2023-03-05 11:59:59", "High"), 
    (5, "Subtask 6", "Description for Subtask 6", "2023-03-06 11:59:59", "Critical"),  
    (5, "Subtask 7", NULL, "2023-03-07 11:59:59", NULL),
    (5, "Subtask 8", NULL, "2023-03-08 11:59:59", "Optional"),
    (9, "Subtask 9", "Description for Subtask 9", "2023-03-09 11:59:59", "Low"),  
    (9, "Subtask 10", "Description for Subtask 10 ", "2023-03-10 11:59:59", "Medium"),
    (9, "Subtask 11", NULL, "2023-03-11 11:59:59", "High"),
    (13, "Subtask 12", "Description for Subtask 12", "2023-03-12 11:59:59", "Critical"),  
    (13, "Subtask 13", "Description for Subtask 13 ", "2023-03-13 11:59:59", NULL),
    (13, "Subtask 14", NULL, "2023-03-14 11:59:59", "Optional"),
    (17, "Subtask 15", "Description for Subtask 15", "2023-03-15 11:59:59", "Low"),  
    (17, "Subtask 16", "Description for Subtask 16 ", "2023-03-16 11:59:59", "Medium"),
    (17, "Subtask 17", NULL, "2023-03-17 11:59:59", "High");

--
-- Dumping data for table `Teammates`
--

INSERT INTO Teammates (userID, name, email, phone) VALUES 
    (1, "Teammate1", 'teammate1@gmail.com', "1111111111"),
    (1, "Teammate2", NULL, "2222222222"),
    (2, "Teammate3", 'teammate3@gmail.com', NULL),
    (2, "Teammate4", 'teammate4@gmail.com', "4444444444"),
    (3, "Teammate5", NULL, "5555555555"),
    (3, "Teammate6", 'teammate6@gmail.com', NULL),
    (4, "Teammate7", 'teammate7@gmail.com', "7777777777"),
    (4, "Teammate8", NULL, "8888888888"),
    (5, "Teammate9", 'teammate9@gmail.com', NULL),
    (5, "Teammate10", NULL, NULL);

--
-- Dumping data for table `Categories`
--

INSERT INTO Categories (userID, name, description) VALUES 
    (1, "Category A for User 1", "Description for CategoryA User1"), 
    (1, "Category B for User 1", "Description for CategoryB User1"), 
    (2, "Category A for User 2", "Description for CategoryA User2"),
    (2, "Category B for User 2", NULL),
    (3, "Category A for User 3", "Description for CategoryA User3"),
    (3, "Category B for User 3", "Description for CategoryB User3"),
    (4, "Category A for User 4", NULL),
    (4, "Category B for User 4", "Description for CategoryB User4"),
    (5, "Category A for User 5", "Description for CategoryA User5"),
    (5, "Category B for User 5", NULL);

--
-- Dumping data for table `TasksAndTeammates`
--

INSERT INTO TasksAndTeammates (taskID, teammateID) VALUES 
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 2),
    (5, 3),
    (5, 4),
    (6, 3),
    (6, 4),
    (9, 5),
    (9, 6),
    (10, 5),
    (10, 6),
    (13, 7),
    (13, 8),
    (14, 7),
    (14, 8),
    (17, 9),
    (17, 10),
    (18, 9),
    (18, 10);

--
-- Dumping data for table `SubtasksAndTeammates`
--

INSERT INTO SubtasksAndTeammates (subtaskID, teammateID) VALUES 
    (1, 1),
    (1, 2),
    (2, 1),
    (2, 2),
    (5, 3),
    (5, 4),
    (6, 3),
    (6, 4),
    (9, 5),
    (10, 6),
    (10, 6),
    (12, 7),
    (13, 8),
    (13, 8),
    (15, 9),
    (16, 10),
    (16, 10);


--
-- Dumping data for table `TasksAndCategories`
--

INSERT INTO TasksAndCategories (taskID, categoryID) VALUES 
    (1, 1),
    (2, 1),
    (3, 2),
    (4, 2),
    (5, 3),
    (6, 4),
    (7, 4),
    (8, NULL),
    (9, 5),
    (10, 5),
    (11, 6),
    (12, NULL),
    (13, 7),
    (13, 8),
    (14, 7),
    (15, 8),
    (16, NULL),
    (17, 9),
    (18, 10),
    (19, NULL),
    (20, NULL);


--
-- Dumping data for table `SubtasksAndCategories`
--

INSERT INTO SubtasksAndCategories ( subtaskID, categoryID ) VALUES 
    (1, 1),
    (1, 2),
    (2, 2),
    (5, 3),
    (5, 4),
    (6, 3),
    (9, 6),
    (10, 5),
    (10, 6),
    (12, 8),
    (13, 7),
    (13, 7),
    (15, 9),
    (16, 9),
    (16, 10);

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
