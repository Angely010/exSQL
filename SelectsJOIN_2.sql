USE ex2_2
GO
--Seleccts com JOIN
--1) Consultar num_cadastro do cliente, nome do cliente, data_locacao (Formato
--dd/mm/aaaa), Qtd_dias_alugado (total de dias que o filme ficou alugado), titulo do
--filme, ano do filme da locação do cliente cujo nome inicia com Matilde
SELECT cli.num_cadastro, cli.nome, (CONVERT(CHAR(10),lc.data_locacao,103)) AS Data_locacao,
       CONVERT(CHAR(10), DATEDIFF(DAY, lc.data_locacao, lc.data_devolucao),103) AS Qtd_dias_alugado,
	   fl.titulo, fl.ano
FROM cliente cli, locacao lc, filme fl, dvd d
WHERE cli.num_cadastro = lc.clientenum_cadastro
      AND lc.dvdnum = d.num
	  AND fl.id = d.filmeid
	  AND cli.nome LIKE 'Matilde%'

--2) Consultar nome da estrela, nome_real da estrela, título do filme dos filmes
--cadastrados do ano de 2015
SELECT es.nome, es.nome_real, fl.titulo
FROM estrela es, filme fl, filme_estrela fle
WHERE es.id = fle.estrelaid
	AND fl.id = fle.filmeid
	AND fl.ano = 2015

--3) Consultar título do filme, data_fabricação do dvd (formato dd/mm/aaaa), caso a
--diferença do ano do filme com o ano atual seja maior que 6, deve aparecer a diferença
--do ano com o ano atual concatenado com a palavra anos (Exemplo: 7 anos), caso
--contrário só a diferença (Exemplo: 4).
SELECT fl.titulo, CONVERT(CHAR(10), d.data_fabricacao, 103) AS data_fab,
	CASE WHEN (YEAR(GETDATE()) - ano > 6)  THEN
			CAST(YEAR(GETDATE()) - ano AS VARCHAR(4)) + ' anos'
		ELSE
			CAST(YEAR(GETDATE()) - ano AS VARCHAR(4))
	END AS tempo
FROM filme fl, dvd d
WHERE fl.id = d.filmeid
