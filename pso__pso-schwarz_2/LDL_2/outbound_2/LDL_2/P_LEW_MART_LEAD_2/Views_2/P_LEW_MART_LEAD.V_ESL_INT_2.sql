/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_INT_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_int_2 (int_id, client_id) AS SELECT '1' AS int_id,
 client_id
FROM ldl_p_lew_core_ac.v_client_2
WHERE client_online_fg = 0
 AND client_id < 1000;