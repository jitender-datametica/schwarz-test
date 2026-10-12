/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_REF_PRICE_LABEL_STATUS_TYPE_1
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_ref_price_label_status_type_1 (price_label_status_type_cd,
price_label_status_type_descr) AS SELECT price_label_status_type_cd,
 price_label_status_type_descr
FROM ldl_p_lew_core_ac.v_esl_ref_price_label_status_type_1;