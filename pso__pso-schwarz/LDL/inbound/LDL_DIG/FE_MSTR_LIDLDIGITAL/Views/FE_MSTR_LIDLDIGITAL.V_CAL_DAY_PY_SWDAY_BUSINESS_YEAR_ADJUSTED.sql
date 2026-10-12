CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_CAL_DAY_PY_SWDAY_BUSINESS_YEAR_ADJUSTED

/**************************************************************************
* CREATED MANUALLY BY SACHIT VINOD
* ON 24.11.2021
* LAST UPDATE  - 24.11.2021

**************************************************************************/
(
CAL_DT
,INCL_CAL_DT
)
AS
SELECT
CAL_DT
,INCL_CAL_DT
FROM
lec_share.v_cal_day_py_swday_business_year_adjusted
WHERE BUS_YEAR_DIFF =1;