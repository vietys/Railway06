
DROP DATABASE IF EXISTS Testing_System_Assignment_5;
CREATE DATABASE Testing_System_Assignment_5;
USE Testing_System_Assignment_5;

/*============================== CREATE TABLE=== =======================================*/
/*======================================================================================*/

-- create table 1: Department
DROP TABLE IF EXISTS Department;
CREATE TABLE Department(
	DepartmentID 			TINYINT UNSIGNED PRIMARY KEY,
    DepartmentName 			NVARCHAR(30) NOT NULL UNIQUE KEY
);

-- create table 2: Posittion
DROP TABLE IF EXISTS Position;
CREATE TABLE `Position` (
	PositionID				TINYINT UNSIGNED PRIMARY KEY,
    PositionName			ENUM('Dev','Test','Scrum Master','PM') NOT NULL UNIQUE KEY
);

-- create table 3: Account
DROP TABLE IF EXISTS `Account`;
CREATE TABLE `Account`(
	AccountID				TINYINT UNSIGNED  PRIMARY KEY,
    Email					VARCHAR(50) NOT NULL UNIQUE KEY,
    Username				VARCHAR(50) NOT NULL UNIQUE KEY,
    FullName				NVARCHAR(50) NOT NULL,
    DepartmentID 			TINYINT UNSIGNED NOT NULL,
    PositionID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(DepartmentID) REFERENCES Department(DepartmentID),
    FOREIGN KEY(PositionID) REFERENCES `Position`(PositionID)
);

-- create table 4: Group
DROP TABLE IF EXISTS `Group`;
CREATE TABLE `Group`(
	GroupID					TINYINT UNSIGNED  PRIMARY KEY,
    GroupName				NVARCHAR(50) NOT NULL UNIQUE KEY,
    CreatorID				TINYINT UNSIGNED,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

-- create table 5: GroupAccount
DROP TABLE IF EXISTS GroupAccount;
CREATE TABLE GroupAccount(
	GroupID					TINYINT UNSIGNED NOT NULL,
    AccountID				TINYINT UNSIGNED NOT NULL,
    JoinDate				DATETIME DEFAULT NOW(),
    PRIMARY KEY (GroupID,AccountID),
    FOREIGN KEY(GroupID) 		REFERENCES `Group`(GroupID) 
);

-- create table 6: TypeQuestion
DROP TABLE IF EXISTS TypeQuestion;
CREATE TABLE TypeQuestion (
    TypeID 			TINYINT UNSIGNED  PRIMARY KEY,
    TypeName 		ENUM('Essay','Multiple-Choice') NOT NULL UNIQUE KEY
);

-- create table 7: CategoryQuestion
DROP TABLE IF EXISTS CategoryQuestion;
CREATE TABLE CategoryQuestion(
    CategoryID				TINYINT UNSIGNED  PRIMARY KEY,
    CategoryName			NVARCHAR(50) NOT NULL UNIQUE KEY
);

-- create table 8: Question
DROP TABLE IF EXISTS Question;
CREATE TABLE Question(
    QuestionID				TINYINT UNSIGNED  PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    TypeID					TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) 	REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(TypeID) 		REFERENCES TypeQuestion(TypeID),
    FOREIGN KEY(CreatorID) 		REFERENCES `Account`(AccountId) 
);

-- create table 9: Answer
DROP TABLE IF EXISTS Answer;
CREATE TABLE Answer(
    AnswerID				TINYINT UNSIGNED  PRIMARY KEY,
    Content					NVARCHAR(100) NOT NULL,
    QuestionID				TINYINT UNSIGNED NOT NULL,
    isCorrect				BIT DEFAULT 1,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID)
);

-- create table 10: Exam
DROP TABLE IF EXISTS Exam;
CREATE TABLE Exam(
    ExamID					TINYINT UNSIGNED  PRIMARY KEY,
    `Code`					CHAR(10) NOT NULL,
    Title					NVARCHAR(50) NOT NULL,
    CategoryID				TINYINT UNSIGNED NOT NULL,
    Duration				TINYINT UNSIGNED NOT NULL,
    CreatorID				TINYINT UNSIGNED NOT NULL,
    CreateDate				DATETIME DEFAULT NOW(),
    FOREIGN KEY(CategoryID) REFERENCES CategoryQuestion(CategoryID),
    FOREIGN KEY(CreatorID) 	REFERENCES `Account`(AccountId)
);

-- create table 11: ExamQuestion
DROP TABLE IF EXISTS ExamQuestion;
CREATE TABLE ExamQuestion(
    ExamID				TINYINT UNSIGNED NOT NULL,
	QuestionID			TINYINT UNSIGNED NOT NULL,
    FOREIGN KEY(QuestionID) REFERENCES Question(QuestionID),
    FOREIGN KEY(ExamID) REFERENCES Exam(ExamID) ,
    PRIMARY KEY (ExamID,QuestionID)
);

/*============================== INSERT DATABASE =======================================*/
/*======================================================================================*/
-- Add data Department
INSERT INTO Department(DepartmentID,DepartmentName) 
VALUES
						(1,			N'Marketing'	),
						(2,			N'Sale'			),
						(3,			N'Bảo vệ'		),
						(4,			N'Nhân sự'		),
						(5,			N'Kỹ thuật'		),
						(6,			N'Tài chính'	),
						(7,			N'Phó giám đốc'	),
						(8,			N'Giám đốc'		),
						(9,			N'Thư kí'		),
						(10,		N'Bán hàng'		);
                        
    
-- Add data position
INSERT INTO Position	(PositionID,PositionName) 
VALUES 					(1,		'Dev'			),
						(2,		'Test'			),
						(3,		'Scrum Master'	),
						(4,		'PM'			); 


-- Add data Account
INSERT INTO `Account`(Email								,AccountID, Username			, FullName				, DepartmentID	, PositionID, CreateDate)
VALUES 				('haidang29productions@gmail.com'	,1,			 'dangblack'		,'Nguyễn hải Đăng'		,   '1'			,   '1'		,'2020-03-05'),
					('account1@gmail.com'				,2,			 'quanganh'			,'Nguyen Chien Thang2'	,   '1'			,   '2'		,'2020-03-05'),
                    ('account2@gmail.com'				,3,			 'vanchien'			,'Nguyen Van Chien'		,   '1'			,   '3'		,'2020-03-07'),
                    ('account3@gmail.com'				,4, 		'cocoduongqua'		,'Duong Do'				,   '1'			,   '3'		,'2020-03-08'),
                    ('account4@gmail.com'				,5, 		'doccocaubai'		,'Nguyen Chien Thang1'	,   '4'			,   '4'		,'2020-03-10'),
                    ('dapphatchetngay@gmail.com'		,6, 		'khabanh'			,'Ngo Ba Kha'			,   '2'			,   '3'		,'2020-04-05'),
                    ('songcodaoly@gmail.com'			,7,		 'huanhoahong'			,'Bui Xuan Huan'		,   '7'			,   '2'		, NULL		),
                    ('sontungmtp@gmail.com'				,8, 		'tungnui'			,'Nguyen Thanh Tung'	,   '2'			,   '1'		,'2020-04-07'),
                    ('duongghuu@gmail.com'				,9, 		'duongghuu'			,'Duong Van Huu'		,   '9'			,   '2'		,'2020-04-07'),
                    ('vtiaccademy@gmail.com'			,10, 		'vtiaccademy'		,'Vi Ti Ai'				,   '10'		,   '1'		,'2020-04-09');

-- Add data Group
INSERT INTO `Group`	( GroupID,		 GroupName			, CreatorID		, CreateDate)
VALUES 				(1,		N'Testing System'		,   5			,'2019-03-05'),
					(2,		N'Development'			,   1			,'2020-03-07'),
                    (3,		N'VTI Sale 01'			,   2			,'2020-03-09'),
                    (4,		N'VTI Sale 02'			,   3			,'2020-03-10'),
                    (5,		N'VTI Sale 03'			,   4			,'2020-03-28'),
                    (6,		N'VTI Creator'			,   6			,'2020-04-06'),
                    (7,		N'VTI Marketing 01'		,   7			,'2020-04-07'),
                    (8,		N'Management'			,   8			,'2020-04-08'),
                    (9,		N'Chat with love'		,   9			,'2020-04-09'),
                    (10,		N'Vi Ti Ai'				,   10			,'2020-04-10');

-- Add data GroupAccount
INSERT INTO `GroupAccount`	(  GroupID	, AccountID	, JoinDate	 )
VALUES 						(	1		,    1		,'2019-03-05'),
							(	1		,    2		,'2020-03-07'),
							(	2		,    1		,'2020-03-09'),
							(	4		,    4		,'2020-03-10'),
							(	5		,    5		,'2020-03-28'),
							(	2		,    6		,'2020-04-06'),
							(	7		,    7		,'2020-04-07'),
							(	8		,    8		,'2020-04-08'),
							(	9		,    9		,'2020-04-09'),
							(	10		,    10		,'2020-04-10');


-- Add data TypeQuestion
INSERT INTO TypeQuestion	(typeid, TypeName	) 
VALUES 						(1,'Essay'			), 
							(2,'Multiple-Choice'); 


-- Add data CategoryQuestion
INSERT INTO CategoryQuestion		(Categoryid,CategoryName	)
VALUES 								(1,'Java'			),
									(2,'ASP.NET'		),
									(3,'ADO.NET'		),
									(4,'SQL'			),
									(5,'Postman'		),
									(6,'Ruby'			),
									(7,'Python'		),
									(8,'C++'			),
									(9,'C Sharp'		),
									(10,'PHP'			);
													
-- Add data Question
INSERT INTO Question	(Content			,Questionid, CategoryID, TypeID		, CreatorID	, CreateDate )
VALUES 					(N'Câu hỏi về Java' 	,1,		1		,   '1'			,   '2'		,'2020-04-05'),
						(N'Câu Hỏi về PHP'		,2,		10		,   '2'			,   '2'		,'2020-04-05'),
						(N'Hỏi về C#'			,3,		9		,   '2'			,   '3'		,'2020-04-06'),
						(N'Hỏi về Ruby'			,4,		6		,   '1'			,   '4'		,'2020-04-06'),
						(N'Hỏi về Postman'		,5,		5		,   '1'			,   '5'		,'2020-04-06'),
						(N'Hỏi về ADO.NET'		,6,		3		,   '2'			,   '6'		,'2020-04-06'),
						(N'Hỏi về ASP.NET'		,7,		2		,   '1'			,   '7'		,'2020-04-06'),
						(N'Hỏi về C++'			,8,		8		,   '1'			,   '8'		,'2020-04-07'),
						(N'Hỏi về SQL'			,9,		4		,   '2'			,   '9'		,'2020-04-07'),
						(N'Hỏi về Python'		,10,	7		,   '1'			,   '10'	,'2020-04-07');

-- Add data Answers
INSERT INTO Answer	(  Content		,answerid, QuestionID	, isCorrect	)
VALUES 				(N'Trả lời 01'	,1,			   1			,	0		),
					(N'Trả lời 02'	,2,			   1			,	1		),
                    (N'Trả lời 03'	,3,			   1			,	0		),
                    (N'Trả lời 04'	,4,			   1			,	1		),
                    (N'Trả lời 05'	,5,			   2			,	1		),
                    (N'Trả lời 06'	,6,			   3			,	1		),
                    (N'Trả lời 07'	,7,			   4			,	0		),
                    (N'Trả lời 08'	,8,			   8			,	0		),
                    (N'Trả lời 09'	,10,		   9			,	1		),
                    (N'Trả lời 10'	,9,			   10			,	1		);
	
-- Add data Exam
INSERT INTO Exam	(`Code`			, Title					,examid, CategoryID	, Duration	, CreatorID		, CreateDate )
VALUES 				('VTIQ001'		, N'Đề thi C#'			,1,	1			,	60		,   '5'			,'2019-04-05'),
					('VTIQ002'		, N'Đề thi PHP'			,2,	10			,	60		,   '2'			,'2019-04-05'),
                    ('VTIQ003'		, N'Đề thi C++'			,3,	9			,	120		,   '2'			,'2019-04-07'),
                    ('VTIQ004'		, N'Đề thi Java'		,4,	6			,	60		,   '3'			,'2020-04-08'),
                    ('VTIQ005'		, N'Đề thi Ruby'		,5,	5			,	120		,   '4'			,'2020-04-10'),
                    ('VTIQ006'		, N'Đề thi Postman'		,6,	3			,	60		,   '6'			,'2020-04-05'),
                    ('VTIQ007'		, N'Đề thi SQL'			,7,	2			,	60		,   '7'			,'2020-04-05'),
                    ('VTIQ008'		, N'Đề thi Python'		,8,	8			,	60		,   '8'			,'2020-04-07'),
                    ('VTIQ009'		, N'Đề thi ADO.NET'		,9,	4			,	90		,   '9'			,'2020-04-07'),
                    ('VTIQ010'		, N'Đề thi ASP.NET'		,10,	7			,	90		,   '10'		,'2020-04-08');
                    
                    
-- Add data ExamQuestion
INSERT INTO ExamQuestion(ExamID	, QuestionID	) 
VALUES 					(	1	,		5		),
						(	2	,		10		), 
						(	3	,		4		), 
						(	4	,		3		), 
						(	5	,		7		), 
						(	6	,		10		), 
						(	7	,		2		), 
						(	8	,		10		), 
						(	9	,		9		), 
						(	10	,		8		); 
		








