/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_CAL_MONTH
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_cs.v_gen_cal_month (cy_month, prev_month, prev_cy_month, preprev_cy_month, cy, byr
, cy_month_sequence, month_id) AS SELECT cy_month,
 cy_month_prev_1m AS prev_month,
 cy_month_prev_1y AS prev_cy_month,
 cy_month_prev_2y AS preprev_cy_month,
 cy,
 busyear AS byr,
 cy_month_seq AS cy_month_sequence,
 month_id
FROM ldl_p_lew_core_ac.v_cal_month AS C1
WHERE cy < (SELECT MAX(cy) - 6
   FROM ldl_p_lew_core_ac.v_cal_month);