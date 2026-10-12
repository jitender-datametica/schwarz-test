/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_ESL_CURRENCY_2
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_esl_currency_2 (currency_iso_cd) AS SELECT DISTINCT CUR1.curr_cd_from AS
 currency_iso_cd
FROM ldl_p_lew_core_ac.v_exchange_rate_known_hist_2 AS CUR1
 INNER JOIN ldl_p_lew_core_ac.v_exchange_rate_type_2 AS CY1 ON CUR1.client_id = CY1.client_id AND CUR1.x_rate_type_sid =
      CY1.x_rate_type_sid AND CY1.src_kurst = '@BEWE' AND CURRENT_DATE BETWEEN CUR1.active_from_dt AND CUR1.active_to_dt
     AND CURRENT_DATE BETWEEN CUR1.dwh_valid_from AND CUR1.dwh_valid_to;