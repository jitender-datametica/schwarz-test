/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_CAL_FIVE_PREV_WEEKS_PY_1 
#----------------------------------------------------------------------------
# History:
#  1.0  19.11.2019    Ulrich Meister           Patch 20191113_2286_DM_t_pos_store_vat_avg_DWH20 (IDMO-2460, DWH-4137)
#  1.1  16.09.2021    Jaroslaw Syrokosz        Change from v_wawi_cal_week_1 to v_cal_week_1
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_CAL_FIVE_PREV_WEEKS_PY_1 	
(	
 cy_week	COMMENT 'Iso Week number in form YYYYWW. Iso week number uses the calendar_1 year in which the Thursday of the week lies and the count of Thursdays so far in that calendar_1 year (inclusive).'
 , prev_week	COMMENT 'Iso Week number for the Nth previous week. N is specified in the field diff_week_sequence.'
 , prev_week_py	COMMENT 'Iso Week number for the Nth previous week relative to the same week number (WW) for the previous year. N is specified in the field diff_week_sequence.'
 , diff_week_sequence	COMMENT 'Number of previous weeks backwards, ie. number of weeks backwards relative to cy_week.'
  )	
AS	
 SELECT 
   A.cy_week
 , A.prev_week
 , B.prev_week_py
 , A.diff_week_sequence 
 FROM ( SELECT w1.cy_week, 
 w2.cy_week prev_week, 
 RANK() OVER ( PARTITION BY w1.cy_week ORDER BY w2.cy_week DESC ) AS diff_week_sequence 
 FROM P_LEW_CORE_AC.V_CAL_WEEK_1 AS w1 
 INNER JOIN P_LEW_CORE_AC.V_CAL_WEEK_1 AS w2 
  ON w1.cy_week > w2.cy_week 
  QUALIFY diff_week_sequence <= 5 
 ) AS A 
 INNER JOIN 
 ( SELECT 
     w1.cy_week
   , w2.cy_week prev_week_py
   , RANK() OVER ( PARTITION BY w1.cy_week ORDER BY w2.cy_week DESC ) AS diff_week_sequence 
 FROM P_LEW_CORE_AC.V_CAL_WEEK_1 AS w1 
 INNER JOIN P_LEW_CORE_AC.V_CAL_WEEK_1 AS w2 
  ON w1.cy_week_prev_1y > w2.cy_week 
  QUALIFY diff_week_sequence <= 5 
 ) AS B 
 ON     A.cy_week = B.cy_week 
 AND A.diff_week_sequence = B.diff_week_sequence
;