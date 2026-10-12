/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_CAL_CALENDARYEAR_1 
#----------------------------------------------------------------------------
# History:
#  1.0  2019-11-19    Ulrich Meister           Patch 20191113_2286_DM_t_pos_store_vat_avg_DWH20 (IDMO-2460, DWH-4137)
#  2.0  2021-09-27    Tris Bayliff             Switch source object
#                                              20210921_2939_TransAllCal_updts
#                                              https://jira.schwarz/browse/REP2-10367
#  2.1  2021-09-27    Jaroslaw Syrokosz        Update to use BIL_AC instead of CORE_AC https://jira.schwarz/browse/REP2-10367
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_CALENDARYEAR_1 
(	
cy	
, prev_cy	
, cy_year_sequence	
 )	
AS	
SELECT 
  cal.cy        AS cy 
, cal.cy_prev_1y    AS prev_cy 
, cal.cy_offset      AS cy_year_sequence 
FROM P_LEW_BIL_AC.V_DIM_CAL_CALENDAR_YEAR_1 AS cal
WHERE cy<>-1
;