/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_CAL_ROLLING_YEAR
#----------------------------------------------------------------------------
# History:
#  1.0  19.11.2019    Ulrich Meister           Patch 20191113_2286_DM_t_pos_store_vat_avg_DWH20 (IDMO-2460, DWH-4137)
#  1.1  18.03.2021    Torsten Bachmann         Transall shutdown, repointing v_wawi_cal -> v_cal
#                                              PatchNo: 2790, REP3-8380
#  1.0  2021-10-04    Jaroslaw Syrokosz        Update source views
#                                              20210921_2939_TransAllCal_updts
#                                              https://jira.schwarz/browse/REP2-10367
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_cal_rolling_year (month_until_id, month_until_sequence,
rolling_year_type_id, rolling_month_id) AS SELECT M.cy_month AS month_until_id,
 M2.cy_month_offset AS month_until_sequence,
 1 AS rolling_year_type_id,
 M.cy_month_year_cum AS rolling_month_id
FROM ldl_p_lew_bil_ac.v_cal_month_year_cum AS M
 INNER JOIN ldl_p_lew_bil_ac.v_dim_cal_month AS M2 ON M.cy_month = M2.cy_month
UNION ALL
SELECT M.cy_month AS month_until_id,
 M2.cy_month_offset AS month_until_sequence,
 2 AS rolling_year_type_id,
 M.cy_month_year_cum_py AS rolling_month_id
FROM ldl_p_lew_bil_ac.v_cal_month_year_cum AS M
 INNER JOIN ldl_p_lew_bil_ac.v_dim_cal_month AS M2 ON M.cy_month = M2.cy_month
UNION ALL
SELECT M.cy_month AS month_until_id,
 M2.cy_month_offset AS month_until_sequence,
 3 AS rolling_year_type_id,
 M.cy_month_year_cum_ppy AS rolling_month_id
FROM ldl_p_lew_bil_ac.v_cal_month_year_cum AS M
 INNER JOIN ldl_p_lew_bil_ac.v_dim_cal_month AS M2 ON M.cy_month = M2.cy_month;