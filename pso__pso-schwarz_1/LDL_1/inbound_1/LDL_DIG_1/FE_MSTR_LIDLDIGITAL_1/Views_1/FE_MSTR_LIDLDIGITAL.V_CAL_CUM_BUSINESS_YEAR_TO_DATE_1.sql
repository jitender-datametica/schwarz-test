CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_CAL_CUM_BUSINESS_YEAR_TO_DATE_1
/**************************************************************************
* CREATED MANUALLY BY SACHIT VINOD
* ON 12.11.2021
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
lec_share.v_cal_cum_business_year_to_date_1
;