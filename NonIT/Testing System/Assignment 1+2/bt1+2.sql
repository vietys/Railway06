DROP DATABASE IF EXISTS testing_system_assignment_1;
CREATE DATABASE testing_system_assignment_1;
use testing_system_assignment_1;
DROP TABLE IF EXISTS Department;
CREATE TABLE IF NOT EXISTS Department (
department_id  			INT PRIMARY KEY  AUTO_INCREMENT,
department_name			VARCHAR(20) NOT NULL UNIQUE KEY 
); 
DROP TABLE IF EXISTS Position;
CREATE TABLE IF NOT EXISTS Position (
position_id  			INT PRIMARY KEY AUTO_INCREMENT,
Position_name			ENUM('Dev', 'Test', 'Scrum Master', 'PM')
);
DROP TABLE IF EXISTS `Account` ;
CREATE TABLE IF NOT EXISTS`Account` (
Account_id			INT PRIMARY KEY ,
email				VARCHAR(50) NOT NULL UNIQUE ,
username			VARCHAR(20) NOT NULL ,
fullname			VARCHAR(20) NOT NULL ,
Department_id		INT AUTO_INCREMENT,
Position_id			INT ,
date_of_account		DATE,
FOREIGN KEY (Department_id) REFERENCES Department(department_id) ,
FOREIGN KEY (Position_id) REFERENCES `Position`(position_id)
);
DROP TABLE IF EXISTS `Group`;
CREATE TABLE IF NOT EXISTS`Group` (
Group_id			INT PRIMARY KEY AUTO_INCREMENT,
Group_name			VARCHAR(50) NOT NULL ,
Creator_id			INT  ,
date_of_group		DATE 
);
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE IF NOT EXISTS GroupAccount (
Group_id			INT ,
Account_id			INT ,
date_of_join_group	DATE ,
PRIMARY KEY(Group_id,Account_id),
FOREIGN KEY (Account_id) REFERENCES `Account`(Account_id) ,
FOREIGN KEY (Group_id) REFERENCES `Group`(Group_id) 
);
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE IF NOT EXISTS TypeQuestion (
type_id				INT PRIMARY KEY AUTO_INCREMENT,
type_name			ENUM('Essay', 'Multiple-Choice')
);
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE IF NOT EXISTS CategoryQuestion (
Category_id 		INT PRIMARY KEY ,
Category_name		VARCHAR(50) NOT NULL
);
DROP TABLE IF EXISTS Question;
CREATE TABLE IF NOT EXISTS Question (
Question_id			INT PRIMARY KEY ,
content				VARCHAR(1000) NOT NULL ,
category_id			INT ,
type_id				INT,
creator_id			INT ,
date_of_question	DATE ,
FOREIGN KEY (type_id) REFERENCES TypeQuestion (type_id),
FOREIGN KEY (category_id) REFERENCES CategoryQuestion (Category_id)
);
DROP TABLE IF EXISTS Answer;
CREATE TABLE IF NOT EXISTS Answer (
answer_id			INT NOT NULL PRIMARY KEY,
content				VARCHAR(10000) NOT NULL ,
question_id			INT NOT NULL ,
isCorrect			ENUM ( 'yes' , 'no')
);
DROP TABLE IF EXISTS Exam;
CREATE TABLE IF NOT EXISTS Exam (
exam_id				INT NOT NULL PRIMARY KEY ,
code_id				INT NOT NULL ,
title				VARCHAR(100) NOT NULL ,
Category_id			INT NOT NULL ,
Duration			TIME ,
Creator_ID			INT ,
date_of_exam		DATE ,
FOREIGN KEY (Category_id) REFERENCES CategoryQuestion (Category_id)
);
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE IF NOT EXISTS ExamQuestion (
exam_id				INT ,
Question_id			INT ,
PRIMARY KEY(exam_id,Question_id),
FOREIGN KEY (Question_id) REFERENCES Question (Question_id),
FOREIGN KEY (exam_id) REFERENCES Exam (exam_id)
);	


