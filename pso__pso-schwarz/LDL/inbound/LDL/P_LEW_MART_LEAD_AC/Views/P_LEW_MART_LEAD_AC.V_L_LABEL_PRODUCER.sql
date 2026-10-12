/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_L_LABEL_PRODUCER
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  31.01.2024    Simeon Nikolaev           Initial DDL - ESL Dashboard
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_L_LABEL_PRODUCER
(
	PRICE_LABEL_PRODUCER_NAME
	,DWH_LOAD_ID
	,DWH_CREATED
	,DWH_UPDATED
) AS
SELECT
    PRICE_LABEL_PRODUCER_NAME 
    ,DWH_LOAD_ID 
    ,DWH_CREATED 
    ,DWH_UPDATED
FROM 
    P_LEW_MART_LEAD.V_REF_PRICE_LABEL_PRODUCER
;