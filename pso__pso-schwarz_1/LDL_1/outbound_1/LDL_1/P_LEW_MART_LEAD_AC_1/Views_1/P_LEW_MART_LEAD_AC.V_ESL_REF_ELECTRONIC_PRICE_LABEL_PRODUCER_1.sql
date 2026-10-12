/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_REF_ELECTRONIC_PRICE_LABEL_PRODUCER_1 
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_ref_electronic_price_label_producer_1 (electronic_price_label_type_cd_fe
, price_label_producer_name) AS SELECT DISTINCT *
FROM ldl_p_lew_mart_lead.v_esl_ref_electronic_price_label_type_1;