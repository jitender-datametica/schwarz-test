/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_CAL_MONTH_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_CAL_MONTH_2
(
cy_month
, prev_month
, prev_cy_month
, preprev_cy_month
, cy
, byr
, cy_month_sequence
, month_id
)
AS
   SELECT
   c1.cy_month AS cy_month,
   c1.cy_month_prev_1m AS prev_month,
   c1.cy_month_prev_1y AS prev_cy_month,
   c1.cy_month_prev_2y AS preprev_cy_month,
   c1.cy           AS cy,
   c1.busyear  AS  byr,
   c1.cy_month_seq AS cy_month_sequence,
   c1.month_id AS month_id
   FROM p_lew_core_ac.v_cal_month_2  c1
   WHERE c1.cy < (SELECT
   Max(cy)-6
   FROM p_lew_core_ac.v_cal_month_2)
;