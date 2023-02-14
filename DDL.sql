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
