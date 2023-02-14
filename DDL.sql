SET FOREIGN_KEY_CHECKS=0;
SET AUTOCOMMIT = 0;
-- Project Step 3 Draft
-- Aileen Tang and Jennifer Hoang
--
-- Host: mysql.eecs.oregonstate.edu    Database: `cs340_hoangje`

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
-- Dumping data for table `Users`
--

INSERT INTO Users (name, email)
VALUES 
    ( "Momo", "babygirlmomo@gmail.com"),
    ("Aileen", "tangai@oregonstate.edu"),
    ("Catherine", "catherine@hello.com"),
    ("Jeff", "jeff@hello.com"),
    ("Tammy", "tammy@gmail.com"),
    ("Jennifer", "jennifer@gmail.com");

--
-- Table structure for table `Tasks`
--

CREATE OR REPLACE TABLE Tasks(
    taskID INT(20) NOT NULL AUTO_INCREMENT,
    userID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    deadline TIMESTAMP(6) NOT NULL,
    priorityLevel ENUM("Optional", "Low", "Medium", "High", "Critical"),
    FOREIGN KEY (userID) REFERENCES Users(userID)
    ON DELETE CASCADE,
    constraint UNIQUE(taskID),
    PRIMARY KEY (taskID)
);

--
-- Dumping data for table `Tasks`
--

INSERT INTO Tasks (userID, name, description, deadline, priorityLevel)
VALUES 
    (2, "Project Draft 1", "Step 1 draft", "2023-03-07 11:59:59", "Low" ),
    (2, "Quiz 1", "Relational DB and design", "2023-02-13 11:59:59", "Low" ),
    (2, "Assignment 1", "Set up database", "2023/03/19 11:59:59", "Medium" ),
    (1, "Beach Walk", "Get some sandy paws", "2023/03/20 11:59:59", "Low" ),
    (1, "Eat Treats", "Enjoy my life", "2023/03/30 11:59:59", NULL ),
    (3, "Chase Sapphire Bill", "Pay credit card bill", "2023/02/15 11:59:59", NULL ),
    (3, "American Express Bill", "Pay credit card bill", "2023/02/20 11:59:59", NULL ),
    (6, "Send Email to Patrick", "Provide resources for troubleshooting", "2023/02/10 11:59:59", NULL ),
    (6, "Call Back Amy", "Ask what she needs help with", "2023/02/09 11:59:59", NULL ),
    (4, "Buy Groceries", "Supplies for burgers", "2023/02/12 11:59:59", NULL ), 
    (4, "Pick Up Tables", "Four tables", "2023/02/13 11:59:59", NULL ), 
    (5, "Look Up Hotels", "Find affordable prices", "2023/02/18 11:59:59", NULL ), 
    (5, "Research Food to Eat", "Ask friends what they recommend", "2023/02/22 11:59:59", NULL );
--
-- Table structure for table `Categories`
--

CREATE OR REPLACE TABLE Categories(
    categoryID INT(20) NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    constraint UNIQUE(categoryID),
    PRIMARY KEY (categoryID)
);

--
-- Dumping data for table `Categories`
--

INSERT INTO Categories ( name, description ) 
VALUES 
    ( "project", "Group project for class" ), 
    ( "quiz", "Graded quizzes" ), 
    ( "assignment", "Assignments for class" );

--
-- Table structure for table `Subtasks`
--

CREATE OR REPLACE TABLE Subtasks(
    subtaskID INT(20) NOT NULL AUTO_INCREMENT,
    taskID INT(20) NOT NULL,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    deadline TIMESTAMP(6) NOT NULL,
    priorityLevel ENUM("Optional", "Low", "Medium", "High", "Critical"),
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    constraint UNIQUE(subtaskID),
    PRIMARY KEY (subtaskID)
);

--
-- Dumping data for table `Subtasks`
--
INSERT INTO Subtasks ( taskID, name, description, priorityLevel, deadline ) 
VALUES 
    (2, "Read Lecture", "Three lectures to read", "Medium", "2023/03/05 11:59:59" ), 
    (4, "Buy New Clothes", "clothes need to match", NULL, "2023/03/15 11:59:59" ), 
    (6, "Check Statement", "Make sure purchases are correct", NULL, "2023/02/10 11:59:59" ), 
    (8, "Find Resources", "Find links to resources", NULL, "2023/02/09 11:59:59" ), 
    (10, "Make List", "Write down items needed for burgers", NULL, "2023/02/10 11:59:59" ), 
    (12, "Check Location of Where to Stay", "Pick central location", NULL, "2023/02/16 11:59:59" );


--
-- Table structure for table `Teammates`
--

CREATE OR REPLACE TABLE Teammates(
    teammateID INT(20) NOT NULL AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100),
    phone VARCHAR(12),
    constraint UNIQUE(teammateID),
    PRIMARY KEY (teammateID)
);

--
-- Dumping data for table `Teammates`
--

INSERT INTO Teammates ( name, email, phone ) 
VALUES 
    ( "Jacob", "jacob@gmail.com", "3104356709" ), 
    ( "John", "john@gmail.com", "6267809120" ), 
    ( "Ashley", "ashley@gmail.com", "6577083415" ), 
    ( "Denise", "denise@gmail.com", "7542105639" ), 
    ( "Jennifer", "jennifer@gmail.com", "6344504000" );

--
-- Table structure for table `taskAndTeammates`
--

CREATE OR REPLACE TABLE taskAndTeammates(
    taskID int,
    teammateID int,
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    FOREIGN KEY (teammateID) REFERENCES Teammates(teammateID)
    ON DELETE CASCADE,
    PRIMARY KEY (taskID, teammateID)
);

--
-- Dumping data for table `taskAndTeammates`
--

INSERT INTO taskAndTeammates ( taskID, teammateID ) 
VALUES 
    (1, 5), 
    (2, 2), 
    (2, 3), 
    (2, 5);

--
-- Table structure for table `subtaskAndTeammates`
--

CREATE OR REPLACE TABLE subtaskAndTeammates(
    subtaskID int,
    teammateID int,
    FOREIGN KEY (subtaskID) REFERENCES Subtasks(subtaskID)
    ON DELETE CASCADE,
    FOREIGN KEY (teammateID) REFERENCES Teammates(teammateID)
    ON DELETE CASCADE,
    PRIMARY KEY (subtaskID, teammateID)
);

--
-- Dumping data for table `subtaskAndTeammates`
--

INSERT INTO subtaskAndTeammates ( subtaskID, teammateID ) 
VALUES 
    (1, 1), 
    (2, 1), 
    (3, 1), 
    (3, 2);

--
-- Table structure for table `taskAndCategories`
--

CREATE OR REPLACE TABLE taskAndCategories(
    taskID int,
    categoryID int,
    FOREIGN KEY (taskID) REFERENCES Tasks(taskID)
    ON DELETE CASCADE,
    FOREIGN KEY (categoryID) REFERENCES Categories(categoryID)
    ON DELETE CASCADE,
    PRIMARY KEY (taskID, categoryID)
);

--
-- Dumping data for table `taskAndCategories`
--

INSERT INTO taskAndCategories ( taskID, categoryID ) 
VALUES 
    (1, 1), 
    (1, 2), 
    (2, 2), 
    (3, 2);

--
-- Table structure for table `subtaskAndCategories`
--

CREATE OR REPLACE TABLE subtaskAndCategories(
    subtaskID int,
    categoryID int,
    FOREIGN KEY (subtaskID) REFERENCES Subtasks(subtaskID)
    ON DELETE CASCADE,
    FOREIGN KEY (categoryID) REFERENCES Categories(categoryID)
    ON DELETE CASCADE,
    PRIMARY KEY (subtaskID, categoryID)
);

--
-- Dumping data for table `subtaskAndCategories`
--

INSERT INTO subtaskAndCategories ( subtaskID, categoryID ) 
VALUES 
    (1, 1), 
    (1, 2), 
    (2, 2), 
    (3, 2);

SELECT * FROM Users;
SELECT * FROM Tasks;
SELECT * FROM Categories;
SELECT * FROM Subtasks;
SELECT * FROM Teammates;
SELECT * FROM taskAndTeammates;
SELECT * FROM subtaskAndTeammates;
SELECT * FROM taskAndCategories;
SELECT * FROM subtaskAndCategories;

SET FOREIGN_KEY_CHECKS=1;
COMMIT;
