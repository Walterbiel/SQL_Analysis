
--CREATE VIEW VENDAS_ANUAIS AS
SELECT
	DATEPART(YY,OrderDate) as data_venda,
	sum(Quantity) as quantidade_vendas
	FROM dbo.sales
GROUP BY 
	DATEPART(YY,OrderDate)
