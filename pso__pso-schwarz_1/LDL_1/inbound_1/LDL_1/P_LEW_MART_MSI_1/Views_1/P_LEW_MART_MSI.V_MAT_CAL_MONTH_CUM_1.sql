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

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_MONTH_CUM_1 	
(	
 cy_month	
 , month_byr_cum	
 , month_prev_byr_cum	
 , month_pprev_byr_cum	
 )	
AS	
SELECT
  cal1.cy_month        AS cy_month
, cal2.cy_month        AS month_byr_cum
, cal2.cy_month - 100  AS month_prev_byr_cum
, cal2.cy_month - 200  AS month_pprev_byr_cum
FROM P_LEW_BIL_AC.V_DIM_CAL_MONTH_1 AS cal1
INNER JOIN P_LEW_BIL_AC.V_DIM_CAL_MONTH_1 AS cal2
ON cal1.bus_year = cal2.bus_year
AND cal2.cy_month <= cal1.cy_month
WHERE cal1.cy_month  <> -1
;