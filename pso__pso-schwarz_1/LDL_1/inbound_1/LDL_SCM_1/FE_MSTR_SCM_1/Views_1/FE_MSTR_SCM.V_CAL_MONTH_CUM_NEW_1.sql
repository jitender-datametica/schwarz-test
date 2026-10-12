CREATE OR REPLACE VIEW FE_MSTR_SCM.V_CAL_MONTH_CUM_NEW_1(
	CLIENT_ID COMMENT 'Identification of country_1',
	IAN COMMENT 'International Article Number',
	BUSYEAR COMMENT 'Business year - dependent on country_1 and product',
	CAL_MONTH COMMENT 'calendar_1 month',
	MONTH_BYR_CUM COMMENT 'cumulative month of current business year',
	MONTH_PREV_BYR_CUM COMMENT 'cumulative month of previous business year',
	MONTH_PPREV_BYR_CUM COMMENT 'cumulative month of previous previous year'
) COMMENT='new cumulative month view to cover different business year logic based on country_1 and product'
 AS
SELECT 
	 cou.client_id
	,a.ian
	,a.busyear
	,a.cy_month
	,b.cy_month AS month_byr_cum
	,b.cy_month - 100 AS month_prev_byr_cum
	,b.cy_month - 200 AS month_pprev_byr_cum
FROM core_rel.v_busyear_month_week_1 a
INNER JOIN core_rel.v_busyear_month_week_1 b
ON a.busyear = b.busyear
AND a.cy_month >= b.cy_month
INNER JOIN core_rel.t_client_1 cou
ON cou.country_cd = a.land_1
WHERE 1=1 
GROUP BY ALL
ORDER BY 
	cou.client_id
   ,a.ian
   ,a.cy_month
   ,month_byr_cum
;