CREATE OR REPLACE VIEW CORE.V_DIM_UTILISATION_TYPE_1(
	UTIL_ACTION_CD
) COMMENT='A view that contains all distinct values for utilisation action codes from t_fact_product_utilisation_1'
 AS
SELECT DISTINCT UTIL_ACTION_CD
FROM CORE.T_FACT_PRODUCT_UTILISATION_1 ;