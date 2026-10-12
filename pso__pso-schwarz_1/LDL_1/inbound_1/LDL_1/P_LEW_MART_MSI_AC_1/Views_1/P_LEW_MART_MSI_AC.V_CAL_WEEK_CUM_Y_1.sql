/*
 * Change Management:
 * 2024-07-01: Workaround to add prev_cy_week to add transformation for VJ aufgelaufen at LOG
 */
CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_CAL_WEEK_CUM_Y_1(
	 CY_WEEK
	,CY_WEEK_CBYR
	,PREV_CY_WEEK
) AS
 SELECT
       cum.cy_week
      ,cum.cy_week_cbyr
      ,sig.prev_cy_week
 FROM p_lew_mart_msi.v_cal_week_cum_y_1 cum
 INNER JOIN p_lew_mart_msi.v_cal_week_1 sig
 ON cum.cy_week_cbyr = sig.cy_week
 ;