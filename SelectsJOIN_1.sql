USE ex2
GO
SELECT*FROM users
SELECT*FROM projects
SELECT*FROM users_has_projects

--Selects com Join
--a) Adicionar user 
DBCC CHECKIDENT ('users', RESEED, 0);
INSERT INTO users (name, username, email) VALUES ('Joao','Ti_joao','joao@empresa.com')

--b) Adicionar project
DBCC CHECKIDENT ('projects', RESEED, 10003);
INSERT INTO projects (name, description, date) VALUES 
('Atualizaçã de Sistemas','Modificação nos Sistemas Operaionais nos PC´s','2014-09-12')

--c) Consultar:
--1) Id, Name e Email de Users, Id, Name, Description e Data de Projects, dos usuários que
--participaram do projeto Name Re-folha
SELECT us.id AS users_id, us.name AS username, us.email, 
       p.id AS project_id, p.name AS project_name, p.description AS project_description,
	   (CONVERT(CHAR(10),p.date,103)) AS project_date
FROM users us, projects p, users_has_projects ushp
WHERE us.id = ushp.users_id
	  AND p.id = ushp.projects_id
      AND p.name = 'Re-folha'

--2) Name dos Projects que não tem Users
SELECT p.id AS project_id, p.name AS project_name
FROM projects p LEFT OUTER JOIN users_has_projects ushp
ON p.id = ushp.projects_id
WHERE ushp.users_id IS NULL

--3) Name dos Users que não tem Projects
SELECT us.id AS users_id, us.name AS username
FROM users us LEFT OUTER JOIN users_has_projects ushp
ON us.id = ushp.users_id
WHERE ushp.projects_id IS NULL