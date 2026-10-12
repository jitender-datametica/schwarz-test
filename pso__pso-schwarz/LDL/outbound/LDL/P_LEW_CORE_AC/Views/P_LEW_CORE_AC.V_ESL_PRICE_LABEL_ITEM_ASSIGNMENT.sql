/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_PRICE_LABEL_ITEM_ASSIGNMENT
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_esl_price_label_item_assignment (event_tmsp, price_label_sid,
price_label_event_type_cd, price_label_event_display_type_cd, item_sid, next_event_tmsp, dwh_load_id, dwh_created,
dwh_updated) AS SELECT event_tmsp,
 price_label_sid,
 price_label_event_type_cd,
 price_label_event_display_type_cd,
 item_sid,
 next_event_tmsp,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_price_label_item_assignment;