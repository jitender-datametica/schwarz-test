/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_BIL.V_CAL_MONTH_YEAR_CUM_1
#----------------------------------------------------------------------------
# History:
#  1.0  2021-09-27    Jaroslaw Syrokosz        Initial
#                                              20210921_2939_TransAllCal_updts
#                                              https://jira.schwarz/browse/REP2-10367
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_bil.v_cal_month_year_cum_1 (cy_month, cy_month_year_cum, cy_month_year_cum_py,
cy_month_year_cum_ppy) AS SELECT CAL1.cy_month,
 CAL2.cy_month AS cy_month_year_cum,
  CAL2.cy_month - 100 AS cy_month_year_cum_py,
  CAL2.cy_month - 200 AS cy_month_year_cum_ppy
FROM ldl_p_lew_core_ac.v_cal_month_1 AS CAL1
 INNER JOIN ldl_p_lew_core_ac.v_cal_month_1 AS CAL2 ON CAL2.cy_month_seq BETWEEN CAL1.cy_month_seq - 11 AND CAL1.cy_month_seq;