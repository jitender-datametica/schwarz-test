/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_ITEM_ASSIGNMENT_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_price_label_item_assignment_1 (event_tmsp, price_label_sid,
price_label_event_type_cd, price_label_event_display_type_cd, item_sid, next_event_tmsp) AS SELECT event_tmsp,
 price_label_sid,
 price_label_event_type_cd,
 price_label_event_display_type_cd,
 item_sid,
 next_event_tmsp
FROM ldl_p_lew_mart_lead.v_esl_price_label_item_assignment_1;