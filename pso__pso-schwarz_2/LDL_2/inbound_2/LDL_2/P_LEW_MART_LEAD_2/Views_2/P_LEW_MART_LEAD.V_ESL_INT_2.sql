 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_INT_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ESL_INT_2(
  INT_ID
 ,CLIENT_ID
 )
AS
SELECT
'1' AS INT_ID
,CLIENT_ID
FROM P_LEW_CORE_AC.V_CLIENT_2 WHERE CLIENT_ONLINE_FG = 0 AND client_id < 1000
;