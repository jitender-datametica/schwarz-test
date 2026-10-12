/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_REF_ELECTRONIC_PRICE_LABEL_TYPE_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_esl_ref_electronic_price_label_type_2 (electronic_price_label_type_cd,
price_label_producer_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT electronic_price_label_type_cd,
 price_label_producer_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_electronic_price_label_type_2;