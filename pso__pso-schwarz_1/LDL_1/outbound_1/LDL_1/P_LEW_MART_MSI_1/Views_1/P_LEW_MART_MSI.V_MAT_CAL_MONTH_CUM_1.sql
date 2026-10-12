/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_CAL_MONTH_CUM_1  
# History:
#  1.0  2019-11-19    Ulrich Meister           Patch 20191113_2286_DM_t_pos_store_vat_avg_DWH20 (IDMO-2460, DWH-4137)
#  2.0  2021-09-27    Tris Bayliff             Switch source object
#                                              20210921_2939_TransAllCal_updts
#                                              https://jira.schwarz/browse/REP2-10367
#  2.1  2021-09-27    Jaroslaw Syrokosz        Update to use BIL_AC instead of CORE_AC https://jira.schwarz/browse/REP2-10367
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_cal_month_cum_1 (cy_month, month_byr_cum, month_prev_byr_cum,
month_pprev_byr_cum) AS SELECT CAL1.cy_month,
 CAL2.cy_month AS month_byr_cum,
  CAL2.cy_month - 100 AS month_prev_byr_cum,
  CAL2.cy_month - 200 AS month_pprev_byr_cum
FROM ldl_p_lew_bil_ac.v_dim_cal_month_1 AS CAL1
 INNER JOIN ldl_p_lew_bil_ac.v_dim_cal_month_1 AS CAL2 ON CAL1.bus_year = CAL2.bus_year AND CAL1.cy_month >= CAL2.cy_month
   
WHERE CAL1.cy_month <> - 1;