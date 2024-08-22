--CTE

;WITH CurvaABC1 as(
SELECT
sales.ProductKey AS Chave_produto,
sum(sales.UnitPrice * sales.Quantity) AS Faturamento,
product.ProductName as Nome_produto
FROM sales
	LEFT JOIN [dbo].[product]
		ON product.ProductKey = sales.ProductKey
GROUP BY 
	sales.ProductKey,
	product.ProductName
),
CurvaABC2 AS (
    SELECT
        Nome_produto,
        Faturamento,
        SUM(Faturamento) OVER () AS Total,
        Faturamento / SUM(Faturamento) OVER () AS Porcentagem
    FROM CurvaABC1
),

CurvaABC3 AS (
SELECT
    Nome_produto,
    Faturamento,
    Total,
    Porcentagem,
	SUM(Porcentagem) OVER(ORDER BY Faturamento DESC) * 100 AS Acumulado_vendas
FROM CurvaABC2
)
	SELECT
    Nome_produto,
    Faturamento,
    Total,
    Porcentagem,
	Acumulado_vendas,
	CASE WHEN 
		Acumulado_vendas <= 70 THEN 'A'
		WHEN Acumulado_vendas <= 95 THEN 'B'
		ELSE 'C'
	END AS CurvaABC
FROM CurvaABC3
ORDER BY
	Porcentagem DESC
;