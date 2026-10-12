CREATE OR REPLACE  VIEW FE_MSTR_LIDLDIGITAL.V_FACT_NPS_QUOTE_2
/**************************************************************************
* CREATED MANUALLY BY SACHIT VINOD
* ON 14.09.2021
* LAST UPDATE 25.11.2021
**************************************************************************/
(
WSHOP_CD
,CAL_DT
,PERSON_CNT_VAL
,POSITIVE_CNT_VAL
,NEGATIVE_CNT_VAL
)
AS
SELECT
WSHOP_CD
,CAL_DT
,PERSON_CNT_VAL
,POSITIVE_CNT_VAL
,NEGATIVE_CNT_VAL
FROM
lec_share.v_fact_nps_quote_2;