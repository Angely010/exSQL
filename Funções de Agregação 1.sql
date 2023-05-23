USE ex2
GO

--Fun��es de Agrega��o
--1. Quantos projetos n�o tem usu�rios associados a ele. A coluna deve chamar
--qty_projects_no_users
SELECT COUNT(p.id) AS qty_projects_no_users
FROM projects p LEFT OUTER JOIN users_has_projects ushp
ON p.id = ushp.projects_id
WHERE ushp.projects_id IS NULL
     
--2. Id do projeto, nome do projeto, qty_users_project (quantidade de usu�rios por
--projeto) em ordem alfab�tica crescente pelo nome do projeto
SELECT p.id, p.name, COUNT(us.id) AS qty_users_project
FROM projects p, users us, users_has_projects ushp
WHERE us.id = ushp.users_id
   AND p.id = ushp.projects_id
GROUP BY p.id, p.name
ORDER BY p.name


