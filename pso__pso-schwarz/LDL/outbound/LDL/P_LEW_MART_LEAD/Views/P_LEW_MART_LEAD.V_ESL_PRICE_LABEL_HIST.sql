/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_PRICE_LABEL_HIST
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#  1.1  22.10.2024	SIMEON NIKOLAEV	PRICE_LABEL_CONNECT_STATUS_CD
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_price_label_hist (client_id, price_label_sid,
price_label_lifecycle_status_cd, damaged_fg, price_label_damage_reason_id, last_register_tmsp, last_update_tmsp,
price_label_create_tmsp, price_label_delete_tmsp, last_display_refresh_tmsp, last_item_link_tmsp,
display_update_status_name, loc_sid_store, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created,
dwh_updated, last_online_tmsp, last_tech_display_refresh_tmsp, price_label_connect_status_cd) AS SELECT *
FROM ldl_p_lew_core_ac.v_esl_price_label_hist;