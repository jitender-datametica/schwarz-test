/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_PRICE_LABEL
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.10.2023    Chetana Dyamangouda Patil           Initial DDL - ESL Dashboard 
#  1.1  27.12.2023    Stephane Tonga                      ELECTRONIC_PRICE_LABEL_TYPE_CD_FE was added
#  1.2  07.02.2023    Simeon Nikolaev                     Removed CLIENT_ID,DWH_LOAD_ID,DWH_CREATED,DWH_UPDATED
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_PRICE_LABEL
(
	  PRICE_LABEL_SID
	, PRICE_LABEL_NR
	, ELECTRONIC_PRICE_LABEL_TYPE_CD
    , ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	, PRICE_LABEL_PRODUCER_NAME
) AS
SELECT
	  PRICE_LABEL_SID
	, PRICE_LABEL_NR
	, ELECTRONIC_PRICE_LABEL_TYPE_CD
    , ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	, PRICE_LABEL_PRODUCER_NAME
FROM 
    P_LEW_MART_LEAD.V_PRICE_LABEL
;