CREATE OR REPLACE VIEW FE_MSTR_SCM.V_CAL_MONTH_CUM_1(
	BUSYEAR
	,CAL_MONTH
	,MONTH_BYR_CUM
	,MONTH_PREV_BYR_CUM
	,MONTH_PPREV_BYR_CUM
) AS
SELECT 
	a.busyear
	,a.cy_month AS cal_month
	,b.cy_month AS month_byr_cum
	,b.cy_month - 100 AS month_prev_byr_cum
	,b.cy_month - 200 AS month_pprev_byr_cum
FROM core_rel.v_cal_calendarday_1 a
INNER JOIN core_rel.v_cal_calendarday_1 b
ON a.busyear = b.busyear
AND a.cy_month >= b.cy_month
GROUP BY ALL
ORDER BY a.cy_month
;