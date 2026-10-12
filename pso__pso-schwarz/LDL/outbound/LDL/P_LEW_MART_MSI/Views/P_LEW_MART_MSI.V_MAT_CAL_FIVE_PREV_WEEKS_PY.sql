/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_MSI.V_MAT_CAL_FIVE_PREV_WEEKS_PY 
#----------------------------------------------------------------------------
# History:
#  1.0  19.11.2019    Ulrich Meister           Patch 20191113_2286_DM_t_pos_store_vat_avg_DWH20 (IDMO-2460, DWH-4137)
#  1.1  16.09.2021    Jaroslaw Syrokosz        Change from v_wawi_cal_week to v_cal_week
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_cal_five_prev_weeks_py (cy_week
OPTIONS(description='Iso Week number in form YYYYWW. Iso week number uses the calendar year in which the Thursday of the week lies and the count of Thursdays so far in that calendar year (inclusive).'),
prev_week
OPTIONS(description='Iso Week number for the Nth previous week. N is specified in the field diff_week_sequence.'),
prev_week_py
OPTIONS(description='Iso Week number for the Nth previous week relative to the same week number (WW) for the previous year. N is specified in the field diff_week_sequence.'),
diff_week_sequence
OPTIONS(description='Number of previous weeks backwards, ie. number of weeks backwards relative to cy_week.')) AS SELECT
 A.cy_week,
 A.prev_week,
 B.prev_week_py,
 A.diff_week_sequence
FROM (SELECT W1.cy_week,
   W2.cy_week AS prev_week,
   RANK() OVER (PARTITION BY CAST(W1.cy_week AS STRING) ORDER BY W2.cy_week IS NULL DESC, W2.cy_week DESC) AS
   diff_week_sequence
  FROM ldl_p_lew_core_ac.v_cal_week AS W1
   INNER JOIN ldl_p_lew_core_ac.v_cal_week AS W2 ON W1.cy_week > W2.cy_week
  QUALIFY (RANK() OVER (PARTITION BY CAST(W1.cy_week AS STRING) ORDER BY W2.cy_week IS NULL DESC, W2.cy_week DESC)) <= 5
    ) AS A
 INNER JOIN (SELECT W10.cy_week,
   W20.cy_week AS prev_week_py,
   RANK() OVER (PARTITION BY CAST(W10.cy_week AS STRING) ORDER BY W20.cy_week IS NULL DESC, W20.cy_week DESC) AS
   diff_week_sequence
  FROM ldl_p_lew_core_ac.v_cal_week AS W10
   INNER JOIN ldl_p_lew_core_ac.v_cal_week AS W20 ON W10.cy_week_prev_1y > W20.cy_week
  QUALIFY (RANK() OVER (PARTITION BY CAST(W10.cy_week AS STRING) ORDER BY W20.cy_week IS NULL DESC, W20.cy_week DESC))
    <= 5) AS B ON A.cy_week = B.cy_week AND A.diff_week_sequence = B.diff_week_sequence;