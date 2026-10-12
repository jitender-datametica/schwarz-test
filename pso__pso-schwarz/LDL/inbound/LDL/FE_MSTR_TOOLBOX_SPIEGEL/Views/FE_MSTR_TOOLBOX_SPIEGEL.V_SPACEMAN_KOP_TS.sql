 /*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_KOP_TS
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  22.11.2024	SIMEON NIKOLAEV	INITIAL SETUP
#  1.1  05.12.2024	SIMEON NIKOLAEV	Removed Store and listing
#  1.2  25.02.2025	SIMEON NIKOLAEV	Removed Unnecessary fields
#
#----------------------------------------------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_KOP_TS(
  INT_ORG_SID
, SPACEMAN_ITEM_SID
, HEAVY_SORT
, CENTER_PULL
, EASY_IDENT
, REASON
) AS
SELECT DISTINCT

  ASK.INT_ORG_SID
, ASK.SPACEMAN_ITEM_SID
, SKT.HEAVY_SORT
, SKT.CENTER_PULL
, SKT.EASY_IDENT
, SKT.REASON
FROM FE_MSTR_TOOLBOX_SPIEGEL.V_AGG_SPACEMAN_KOP ASK
LEFT JOIN FE_MSTR_TOOLBOX_SPIEGEL.T_SPACEMAN_KOP_TS SKT
ON ASK.INT_ORG_SID = SKT.INT_ORG_SID
AND ASK.SPACEMAN_ITEM_SID = SKT.SPACEMAN_ITEM_SID
;