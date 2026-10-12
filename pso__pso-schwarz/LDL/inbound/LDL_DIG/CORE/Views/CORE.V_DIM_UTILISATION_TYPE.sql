CREATE OR REPLACE VIEW CORE.V_DIM_UTILISATION_TYPE(
	UTIL_ACTION_CD
) COMMENT='A view that contains all distinct values for utilisation action codes from t_fact_product_utilisation'
 AS
SELECT DISTINCT UTIL_ACTION_CD
FROM CORE.T_FACT_PRODUCT_UTILISATION ;