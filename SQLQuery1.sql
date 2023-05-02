CREATE DATABASE ex2
GO
USE ex2
GO

CREATE TABLE users (
id			          INT				NOT NULL	IDENTITY(1, 1),
name		          VARCHAR(45)   	NOT NULL,
username         	  VARCHAR(45)   	NOT NULL    UNIQUE,
password        	  VARCHAR(45)		NOT NULL	DEFAULT('123mudar'),
email                 VARCHAR(45)       NOT NULL
PRIMARY KEY(id)
)
GO

CREATE TABLE projects (
id  	        	  INT				NOT NULL	IDENTITY(10001, 1),
name        		  VARCHAR(45)   	NOT NULL	UNIQUE,
description           VARCHAR(45)   	NULL,
date		          DATE			    NOT NULL	CHECK(date > '2014-09-01')
PRIMARY KEY(id)
)
GO

CREATE TABLE users_has_projects (
users_id          	  INT	        	NOT NULL,
projects_id 		  INT       		NOT NULL
PRIMARY KEY (users_id, projects_id)
FOREIGN KEY (users_id) REFERENCES users(id),
FOREIGN KEY (projects_id) REFERENCES projects(id)
)
GO

ALTER TABLE users
DROP CONSTRAINT UQ__users__F3DBC57248F89E5F
GO
ALTER TABLE users
ALTER COLUMN username VARCHAR(10) NOT NULL
GO
ALTER TABLE users 
ADD UNIQUE (username)
GO
EXEC sp_rename 'dbo.users.passwword', 'password', 'COLUMN'
ALTER TABLE users
ALTER COLUMN password VARCHAR(8)
GO

EXEC sp_help users
EXEC sp_help projects
EXEC sp_help users_has-projects
 
INSERT INTO users (name, username, email) VALUES ('Maria','Rh_maria','maria@empresa.com')
INSERT INTO users (name, username, password, email) VALUES ('Paulo','Ti_paulo','123@456','paulo@empresa.com')
INSERT INTO users (name, username, email) VALUES ('Ana','Rh_ana','ana@empresa.com')
INSERT INTO users (name, username, email) VALUES ('Clara','Ti_clara','clara@empresa.com')
INSERT INTO users (name, username, password, email) VALUES ('Aparecido','Rh_apareci','55@!cido','aparecido@empresa.com')
GO

INSERT INTO projects (name, description, date) VALUES
('Re-folha','Refatoração das Folhas','2014-09-05'),
('Manutenção PC´s','Manutenção PC´s','2014-09-06'),
('Auditoria',NULL,'2014-09-07')
GO

INSERT INTO users_has_projects VALUES
(1,10001),
(5,10001),
(3,10003),
(4,10002),
(2,10002)
GO

UPDATE projects
SET date = '2014-09-12'
WHERE name LIKE 'Manutenção%'
GO

UPDATE users
SET username = 'Rh_cido'
WHERE name = 'Aparecido'
GO

UPDATE users
SET password = '888@*'
WHERE username = 'Rh_maria' AND password = '123mudar'
GO

DELETE users_has_projects
WHERE users_id = 2 AND projects_id = 10002

 
SELECT * FROM users
SELECT * FROM projects 
SELECT * FROM users_has_projects
