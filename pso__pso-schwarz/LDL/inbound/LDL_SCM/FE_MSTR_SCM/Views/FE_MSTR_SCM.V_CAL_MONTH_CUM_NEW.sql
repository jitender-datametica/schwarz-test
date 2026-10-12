CREATE OR REPLACE VIEW FE_MSTR_SCM.V_CAL_MONTH_CUM_NEW(
	CLIENT_ID COMMENT 'Identification of country',
	IAN COMMENT 'International Article Number',
	BUSYEAR COMMENT 'Business year - dependent on country and product',
	CAL_MONTH COMMENT 'calendar month',
	MONTH_BYR_CUM COMMENT 'cumulative month of current business year',
	MONTH_PREV_BYR_CUM COMMENT 'cumulative month of previous business year',
	MONTH_PPREV_BYR_CUM COMMENT 'cumulative month of previous previous year'
) COMMENT='new cumulative month view to cover different business year logic based on country and product'
 AS
SELECT 
	 cou.client_id
	,a.ian
	,a.busyear
	,a.cy_month
	,b.cy_month AS month_byr_cum
	,b.cy_month - 100 AS month_prev_byr_cum
	,b.cy_month - 200 AS month_pprev_byr_cum
FROM core_rel.v_busyear_month_week a
INNER JOIN core_rel.v_busyear_month_week b
ON a.busyear = b.busyear
AND a.cy_month >= b.cy_month
INNER JOIN core_rel.t_client cou
ON cou.country_cd = a.land
WHERE 1=1 
GROUP BY ALL
ORDER BY 
	cou.client_id
   ,a.ian
   ,a.cy_month
   ,month_byr_cum
;