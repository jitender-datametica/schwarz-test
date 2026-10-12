 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_INT
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_ESL_INT(
  INT_ID
 ,CLIENT_ID
 )
AS
SELECT
'1' AS INT_ID
,CLIENT_ID
FROM P_LEW_CORE_AC.V_CLIENT WHERE CLIENT_ONLINE_FG = 0 AND client_id < 1000
;