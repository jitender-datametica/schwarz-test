CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_FISCAL_PERIOD_KER(
	BUS_YEAR
	,MONTH_OF_YEAR
	,MONTH_OF_BUS_YEAR
	,MONTH_OF_YEAR_SHORT_NAME
	,CAL_YEAR
	,CY_MONTH_OFFSET
	,CY_MONTH
	,BUS_YEAR_OFFSET
	,BUS_YEAR_PREV_1Y
) AS
SELECT 
 	CM.BUS_YEAR
 	,CM.MONTH_OF_YEAR
 	,CM.MONTH_OF_BUS_YEAR
 	,CM.MONTH_OF_YEAR_SHORT_NAME
    ,CM.CY 							AS CAL_YEAR
 	,CM.CY_MONTH_OFFSET
	,CM.CY_MONTH
    ,CM.BUS_YEAR_OFFSET
    ,CBY.BUS_YEAR_PREV_1Y
FROM 
	lec_share.v_dim_cal_month CM
JOIN 
	lec_share.v_dim_cal_business_year CBY
	ON CM.bus_year = CBY.bus_year
WHERE cy_month!= '-1'
 
UNION ALL
 
SELECT DISTINCT
 	CM.BUS_YEAR
 	,13 							AS MONTH_OF_YEAR
 	,13 							AS MONTH_OF_BUS_YEAR
 	,'P13' 							AS MONTH_OF_YEAR_SHORT_NAME
    ,CM.BUS_YEAR 					AS CAL_YEAR
 	,CM.BUS_YEAR 					AS CY_MONTH_OFFSET
    ,13                             AS CY_MONTH
    ,CM.BUS_YEAR_OFFSET 			AS BUS_YEAR_OFFSET
    ,CBY.BUS_YEAR_PREV_1Y 			AS BUS_YEAR_PREV_1Y
 FROM 
 	lec_share.v_dim_cal_month CM
JOIN 
	lec_share.v_dim_cal_business_year CBY
	ON CM.bus_year = CBY.bus_year
 WHERE cy_month!= '-1'
 
 UNION ALL
 
 SELECT
 	'-1'
 	,'-1'
 	,'-1'
 	,''
 	,'-1'
	,'-1'
 	,'0'
 	,'0'
 	,'-1'
 ;