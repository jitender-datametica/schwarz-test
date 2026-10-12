CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_TRANSFORMATION_PREV_CY_DAT_CALENDAR_SAMEWDAY_1

/**************************************************************************
* CREATED MANUALLY BY SACHIT VINOD
* ON 15.09.2021
* TEMP VIEW TILL T_CAL_DAY_PY_SWDAY_BUSINESS_YEAR_ADJUSTED_1 TABLE BUILD IS COMPLETE
* LAST UPDATE  - 12.11.2021

**************************************************************************/
(
CAL_DT
,CAL_DT_SWDAY_PREV_1Y
)
AS
SELECT
CAL_DT
,CAL_DT_SWDAY_PREV_1Y
FROM
lec_share.v_dim_cal_day_1;

