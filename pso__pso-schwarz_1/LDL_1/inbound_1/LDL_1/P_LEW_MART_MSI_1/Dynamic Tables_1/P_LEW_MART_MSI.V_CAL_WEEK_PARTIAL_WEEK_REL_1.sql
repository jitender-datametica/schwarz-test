
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_CAL_WEEK_PARTIAL_WEEK_REL_1 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/* 
 #DescStart# 
 #$Revision: 17091 $, $LastChangedBy: mrekovsky $ 
 #SubjectAreas#: Kalender 
 #DescEnd# 
 */
SELECT
    cal_dt AS dat_calendar,
    cy_week AS cy_week_partial_week_id1,
    week_part_seq AS cy_week_partial_week_id2,
    cy_week_part AS cy_week_partial_week_id,
    cal_dt_offset AS cy_day_sequence
FROM
    p_lew_bil_ac.v_dim_cal_day_1
UNION
ALL
SELECT
    cal_dt AS dat_calendar,
    cy_week AS cy_week_partial_week_id1,
    9 AS cy_week_partial_week_id2,
    cy_week * 10 + 9 AS cy_week_partial_week_id,
    cal_dt_offset AS cy_day_sequence
FROM
    p_lew_bil_ac.v_dim_cal_day_1;
