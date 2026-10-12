CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_CAL_WEEK_T11 AS
SELECT 
 a.cy_week AS cy_week 
,b.cy_week AS cy_week_t
FROM p_lew_mart_msi.v_cal_week AS a
LEFT JOIN p_lew_mart_msi.v_cal_week AS b
ON
b.cy_week_sequence > a.cy_week_sequence-12 
AND b.cy_week_sequence <= a.cy_week_sequence
WHERE a.cy_week_sequence BETWEEN -30 AND 0
;
