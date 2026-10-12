/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_CAL_ROLLING_YEAR_2
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

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_ROLLING_YEAR_2
(
 month_until_id
 , month_until_sequence
 , rolling_year_type_id
 , rolling_month_id
 )
 AS 
 ( 
 SELECT 
 m.cy_month                 AS month_until_id 
 , m2.cy_month_offset     AS month_until_sequence 
 , CAST(1 AS BYTEINT)       AS rolling_year_type_id 
 , m.cy_month_year_cum      AS rolling_month_id 
 FROM P_LEW_BIL_AC.V_CAL_MONTH_YEAR_CUM_2 AS m 
 INNER JOIN P_LEW_BIL_AC.V_DIM_CAL_MONTH_2 AS m2 
  ON m.cy_month = m2.cy_month 
  
 UNION ALL 
  
 SELECT 
 m.cy_month                 AS month_until_id 
 , m2.cy_month_offset     AS month_until_sequence 
 , CAST(2 AS BYTEINT)       AS rolling_year_type_id 
 , m.cy_month_year_cum_py   AS rolling_month_id 
 FROM P_LEW_BIL_AC.V_CAL_MONTH_YEAR_CUM_2 AS m 
 INNER JOIN P_LEW_BIL_AC.v_dim_cal_month_2 AS m2 
  ON m.cy_month = m2.cy_month 
  
 UNION ALL 
  
 SELECT 
 m.cy_month                 AS month_until_id 
 , m2.cy_month_offset     AS month_until_sequence 
 , CAST(3 AS BYTEINT)       AS rolling_year_type_id 
 , m.cy_month_year_cum_ppy  AS rolling_month_id 
 FROM P_LEW_BIL_AC.V_CAL_MONTH_YEAR_CUM_2 AS m 
 INNER JOIN P_LEW_BIL_AC.V_DIM_CAL_MONTH_2 AS m2 
  ON m.cy_month = m2.cy_month 
 )
  
;
