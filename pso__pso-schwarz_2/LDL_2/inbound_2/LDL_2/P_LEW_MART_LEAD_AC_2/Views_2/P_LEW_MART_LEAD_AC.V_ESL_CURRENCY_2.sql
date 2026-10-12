/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_CURRENCY_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_ESL_CURRENCY_2
(CURRENCY_ISO_CD)
AS
SELECT CURRENCY_ISO_CD
FROM P_LEW_MART_LEAD.V_ESL_CURRENCY_2
;