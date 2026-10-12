/*
 * Change Management:
 * 2024-07-01: Workaround to add prev_cy_week to add transformation for VJ aufgelaufen at LOG
 */


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_cal_week_cum_y_2 (cy_week, cy_week_cbyr, prev_cy_week) AS SELECT CUM.cy_week
 ,
 CUM.cy_week_cbyr,
 SIG.prev_cy_week
FROM ldl_p_lew_mart_msi.v_cal_week_cum_y_2 AS CUM
 INNER JOIN ldl_p_lew_mart_msi.v_cal_week_2 AS SIG ON CUM.cy_week_cbyr = SIG.cy_week;