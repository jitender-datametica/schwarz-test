/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_REF_PRICE_LABEL_EVENT_TYPE_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_esl_ref_price_label_event_type_1 (price_label_event_type_cd,
price_label_event_type_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT price_label_event_type_cd,
 price_label_event_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_price_label_event_type_1;