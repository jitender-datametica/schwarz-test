/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_REF_PRICE_LABEL_EVENT_DISPLAY_TYPE
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_ref_price_label_event_display_type (price_label_event_display_type_cd,
price_label_event_display_type_descr) AS SELECT price_label_event_display_type_cd,
 price_label_event_display_type_descr
FROM ldl_p_lew_core_ac.v_esl_ref_price_label_event_display_type;