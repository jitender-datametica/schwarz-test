/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_PRICE_LABEL_STORE
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.10.2023    Chetana Dyamangouda Patil           Initial DDL - ESL Dashboard 
#  1.1  27.12.2023    Stephane Tonga                      ELECTRONIC_PRICE_LABEL_TYPE_CD_FE was added
#  1.2  13.02.2024    Simeon Nikolaev					  RMA_LABEL - CLIENT/WH/INT AGGREGATION
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_PRICE_LABEL_STORE
(
	  CLIENT_ID
	, PRICE_LABEL_SID
    , DAT_FORMDATE
	, MOVE_TO_STORE_ID
    , WH_ID 
	, ASPECT_ID
    , ELECTRONIC_PRICE_LABEL_TYPE_CD
    , ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	, PRICE_LABEL_PRODUCER_NAME
	, DAMAGED_FG
    , RMA_LABEL
    , DWH_VALID_FROM
    , DWH_VALID_TO
    , WH_RMA_LABEL
	, CLIENT_RMA_LABEL
	, INT_RMA_LABEL
    , WH_LABEL_CNT
    , CLIENT_LABEL_CNT
    , INT_LABEL_CNT
) AS
SELECT 
      CLIENT_ID
	, PRICE_LABEL_SID
    , DAT_FORMDATE
	, MOVE_TO_STORE_ID
    , WH_ID 
	, ASPECT_ID
    , ELECTRONIC_PRICE_LABEL_TYPE_CD
    , ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
	, PRICE_LABEL_PRODUCER_NAME
	, DAMAGED_FG
	, RMA_LABEL
    , DWH_VALID_FROM
    , DWH_VALID_TO
    , WH_RMA_LABEL
	, CLIENT_RMA_LABEL
	, INT_RMA_LABEL
    , WH_LABEL_CNT
    , CLIENT_LABEL_CNT
    , INT_LABEL_CNT
FROM 
    P_LEW_MART_LEAD.V_PRICE_LABEL_STORE
;