/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_REF_PRICE_LABEL_REPAIR_RESULT_1 
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_ref_price_label_repair_result_1 (price_label_repair_result_cd,
price_label_repair_result_descr, price_label_producer_name) AS SELECT *
FROM ldl_p_lew_mart_lead.v_esl_ref_price_label_repair_result_1;