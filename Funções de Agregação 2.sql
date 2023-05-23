USE ex2_2
GO 
--Funções de Agregação
--1) Consultar, num_cadastro do cliente, nome do cliente, titulo do filme, data_fabricação
--do dvd, valor da locação, dos dvds que tem a maior data de fabricação dentre todos os
--cadastrados.
SELECT cli.num_cadastro, cli.nome, f.titulo,
   (CONVERT(CHAR(10), d.data_fabricacao,103)) AS data_fab, l.valor
FROM cliente cli, filme f, dvd d, locacao l
WHERE cli.num_cadastro = l.clientenum_cadastro
   AND d.num = l.dvdnum
   AND d.filmeid = f.id
   AND d.data_fabricacao IN (
        SELECT MAX(data_fabricacao) FROM dvd
   )

--2) Consultar, num_cadastro do cliente, nome do cliente, data de locação
--(Formato DD/MM/AAAA) e a quantidade de DVD ́s alugados por cliente (Chamar essa
--coluna de qtd), por data de locação
SELECT cli.num_cadastro, cli.nome, (CONVERT(CHAR(10), l.data_locacao,103)) AS data_locação,
       COUNT(l.dvdnum) AS qtd
FROM cliente cli, locacao l
WHERE cli.num_cadastro = l.clientenum_cadastro
GROUP BY cli.num_cadastro, cli.nome, l.data_locacao
ORDER BY l.data_locacao

--3) Consultar, num_cadastro do cliente, nome do cliente, data de locação
--(Formato DD/MM/AAAA) e a valor total de todos os dvd ́s alugados (Chamar essa
--coluna de valor_total), por data de locação
SELECT cli.num_cadastro, cli.nome, (CONVERT(CHAR(10), l.data_locacao,103)) AS data_locação,
     SUM(l.valor) AS valor_total
FROM cliente cli, locacao l
WHERE cli.num_cadastro = l.clientenum_cadastro
GROUP BY cli.num_cadastro, cli.nome, l.data_locacao
ORDER BY l.data_locacao

--4) Consultar, num_cadastro do cliente, nome do cliente, Endereço
--concatenado de logradouro e numero como Endereco, data de locação (Formato
--DD/MM/AAAA) dos clientes que alugaram mais de 2 filmes simultaneamente
SELECT cli.num_cadastro, cli.nome, cli.logradouro +', '+ CAST(cli.num AS VARCHAR(5)) AS endereco, 
	CONVERT(CHAR(10), l.data_locacao, 103) AS data_locacao
FROM cliente cli, locacao l
WHERE cli.num_cadastro = l.clientenum_cadastro
GROUP BY cli.num_cadastro, cli.nome, cli.logradouro +', '+ CAST(cli.num AS VARCHAR(5)), l.data_locacao
HAVING COUNT(l.dvdnum) > 2