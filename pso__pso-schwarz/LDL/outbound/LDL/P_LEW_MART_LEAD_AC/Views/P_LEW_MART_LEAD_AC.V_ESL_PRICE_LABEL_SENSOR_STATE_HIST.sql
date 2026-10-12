/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD_AC.V_ESL_PRICE_LABEL_SENSOR_STATE_HIST
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_esl_price_label_sensor_state_hist (client_id, price_label_sid,
price_label_sensor_name, price_label_metric_meas, deleted_fg, dwh_valid_from, dwh_valid_to) AS SELECT *
FROM ldl_p_lew_mart_lead.v_esl_price_label_sensor_state_hist;