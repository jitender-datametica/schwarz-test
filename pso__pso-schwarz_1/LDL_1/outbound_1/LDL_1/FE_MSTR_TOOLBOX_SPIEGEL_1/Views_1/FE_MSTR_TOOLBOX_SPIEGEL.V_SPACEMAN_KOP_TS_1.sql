/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for FE_MSTR_TOOLBOX_SPIEGEL.V_SPACEMAN_KOP_TS_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  22.11.2024	SIMEON NIKOLAEV	INITIAL SETUP
#  1.1  05.12.2024	SIMEON NIKOLAEV	Removed Store and listing
#  1.2  25.02.2025	SIMEON NIKOLAEV	Removed Unnecessary fields
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_fe_mstr_toolbox_spiegel.v_spaceman_kop_ts_1 (int_org_sid, spaceman_item_sid, heavy_sort,
center_pull, easy_ident, reason) AS SELECT DISTINCT ASK.int_org_sid,
 ASK.spaceman_item_sid,
 SKT.heavy_sort,
 SKT.center_pull,
 SKT.easy_ident,
 SKT.reason
FROM ldl_fe_mstr_toolbox_spiegel.v_agg_spaceman_kop_1 AS ASK
 LEFT JOIN ldl_fe_mstr_toolbox_spiegel.t_spaceman_kop_ts_1 AS SKT ON ASK.int_org_sid = SKT.int_org_sid AND ASK.spaceman_item_sid
    = SKT.spaceman_item_sid;