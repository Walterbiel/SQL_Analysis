-- CTE e window function
create view test2 as

WITH ResumoVendasLoja AS (
    SELECT
        StoreKey as Loja,
        DATEPART(YY, OrderDate) as Ano,
        SUM(Quantity) as quantidade_vendas
    FROM dbo.sales
    GROUP BY
        StoreKey,
        DATEPART(YY, OrderDate)
)
--Reutilizando CTE

SELECT 
Loja,
Ano,
quantidade_vendas,
SUM(quantidade_vendas) OVER(PARTITION BY Loja ORDER BY Ano) AS Acumulado_vendas,
quantidade_vendas - LAG(quantidade_vendas,1,0) OVER(PARTITION BY Loja ORDER BY Ano) AS Diferença_vendas
FROM ResumoVendasLoja;
