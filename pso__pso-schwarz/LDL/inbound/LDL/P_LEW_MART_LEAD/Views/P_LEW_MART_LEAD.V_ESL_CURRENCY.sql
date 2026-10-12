 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_CURRENCY
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ESL_CURRENCY
(CURRENCY_ISO_CD)
AS
SELECT DISTINCT CUR1.CURR_CD_FROM AS CURRENCY_ISO_CD
FROM P_LEW_CORE_AC.V_EXCHANGE_RATE_KNOWN_HIST CUR1
    INNER JOIN P_LEW_CORE_AC.V_EXCHANGE_RATE_TYPE AS CY1
     ON  CY1.CLIENT_ID       = CUR1.CLIENT_ID
     AND CY1.X_RATE_TYPE_SID = CUR1.X_RATE_TYPE_SID
     AND CY1.SRC_KURST       = '@BEWE'
     AND CURRENT_DATE BETWEEN CUR1.ACTIVE_FROM_DT AND CUR1.ACTIVE_TO_DT
     AND CURRENT_DATE BETWEEN CUR1.DWH_VALID_FROM AND CUR1.DWH_VALID_TO
;