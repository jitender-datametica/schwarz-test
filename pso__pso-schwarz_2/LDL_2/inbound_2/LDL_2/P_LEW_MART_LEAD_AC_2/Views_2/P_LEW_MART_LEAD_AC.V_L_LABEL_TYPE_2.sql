/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_L_LABEL_TYPE_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  31.01.2024    Simeon Nikolaev           Initial DDL - ESL Dashboard
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_L_LABEL_TYPE_2
(ELECTRONIC_PRICE_LABEL_TYPE_CD_FE)
AS
SELECT DISTINCT
ELECTRONIC_PRICE_LABEL_TYPE_CD_FE
FROM  P_LEW_MART_LEAD_AC.V_PRICE_LABEL_2;