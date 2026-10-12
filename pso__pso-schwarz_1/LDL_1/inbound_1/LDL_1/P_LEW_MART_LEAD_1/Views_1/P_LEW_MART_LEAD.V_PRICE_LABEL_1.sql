/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_PRICE_LABEL_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  31.10.2023    Chetana Dyamangouda Patil           Initial DDL - ESL Dashboard 
#  1.1  27.12.2023    Stephane Tonga                      ELECTRONIC_PRICE_LABEL_TYPE_CD_FE was added
#  1.2  07.02.2023    Simeon Nikolaev                     Removed CLIENT_ID,DWH_LOAD_ID,DWH_CREATED,DWH_UPDATED
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_PRICE_LABEL_1
(
	  PRICE_LABEL_SID
	, PRICE_LABEL_NR
	, ELECTRONIC_PRICE_LABEL_TYPE_CD
    , ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	, PRICE_LABEL_PRODUCER_NAME
) AS
SELECT 
	  P.PRICE_LABEL_SID
	, P.PRICE_LABEL_NR
	, P.ELECTRONIC_PRICE_LABEL_TYPE_CD
    , CASE WHEN P.ELECTRONIC_PRICE_LABEL_TYPE_CD IN ('HF_G1_2.6_BWR', 'NEWTON_GRAPHIC_2_6_RED')
         THEN '02.6'
         WHEN  P.ELECTRONIC_PRICE_LABEL_TYPE_CD IN ('HF_G1_13_BWR', 'NEWTON_GRAPHIC_12_2_RED')
         THEN '12.2'
         WHEN  P.ELECTRONIC_PRICE_LABEL_TYPE_CD IN ('HF_VUSION_5.9_BW_FREEZER', 'NEWTON_GRAPHIC_5_85_FREEZER','NEWTON_GRAPHIC_5_85_NFC_LITE_FREEZER')
         THEN '05.9 F'
         WHEN  P.ELECTRONIC_PRICE_LABEL_TYPE_CD IN ('HF_VUSION_5.9_BWR', 'NEWTON_GRAPHIC_5_85_RED')
         THEN '05.9'
         WHEN  P.ELECTRONIC_PRICE_LABEL_TYPE_CD IN ('HF_VUSION_9.7_BWR', 'NEWTON_GRAPHIC_9_7_RED')
         THEN '09.7'
         ELSE NULL END AS ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	, P.PRICE_LABEL_PRODUCER_NAME

FROM P_LEW_CORE_AC.V_PRICE_LABEL_1 AS P
;
