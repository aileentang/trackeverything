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
