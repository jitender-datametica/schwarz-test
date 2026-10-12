CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_TRANSFORMATION_LY_SAME_DAY_2
/**************************************************************************
* CREATED MANUALLY BY SACHIT VINOD
* ON 14.07.2021

**************************************************************************/
(
CAL_DT
,CAL_DT_PREV_1Y
)
AS 
SELECT DISTINCT
CAL_DT
,CAL_DT_PREV_1Y
FROM
lec_share.v_dim_cal_day_2;