--CREATE VIEW Faturamendo_loja AS
SELECT
st.SquareMeters AS Metros_quadrados,
st.StoreKey as Codigo,
 AVG(sales.UnitPrice) AS Media_preco,
 SUM(Quantity * UnitPrice) AS Faturamento
FROM sales
LEFT JOIN dbo.store as st
	on sales.StoreKey = st.StoreKey
GROUP BY 
st.SquareMeters ,
st.StoreKey
ORDER BY st.StoreKey