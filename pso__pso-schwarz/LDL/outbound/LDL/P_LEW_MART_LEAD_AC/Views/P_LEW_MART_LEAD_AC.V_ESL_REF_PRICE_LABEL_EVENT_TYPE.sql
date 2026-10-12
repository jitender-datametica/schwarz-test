/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_REF_PRICE_LABEL_EVENT_TYPE
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_ref_price_label_event_type (price_label_event_type_cd,
price_label_event_type_descr) AS SELECT *
FROM ldl_p_lew_mart_lead.v_esl_ref_price_label_event_type;