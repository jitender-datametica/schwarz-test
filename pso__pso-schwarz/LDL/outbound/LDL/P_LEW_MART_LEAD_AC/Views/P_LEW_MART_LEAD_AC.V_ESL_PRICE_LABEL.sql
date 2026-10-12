/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_price_label (price_label_sid, price_label_nr,
electronic_price_label_type_cd, electronic_price_label_type_cd_fe, price_label_producer_name) AS SELECT *
FROM ldl_p_lew_mart_lead.v_esl_price_label;