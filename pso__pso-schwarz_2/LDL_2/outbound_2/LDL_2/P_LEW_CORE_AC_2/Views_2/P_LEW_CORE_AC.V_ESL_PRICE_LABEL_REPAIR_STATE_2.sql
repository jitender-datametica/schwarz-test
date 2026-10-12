/*
#----------------------------------------------------------------------------------------------------------------
# Interface: DDL for P_LEW_CORE_AC.V_ESL_PRICE_LABEL_REPAIR_STATE_REPAIR_STATE
#----------------------------------------------------------------------------------------------------------------
# History:
#  1.0  30.08.2024	SIMEON NIKOLAEV	INITIAL SETUP
#  1.1  22.10.2024	SIMEON NIKOLAEV	PRICE_LABEL_CLIENT_ID
#
#----------------------------------------------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_esl_price_label_repair_state_2 (price_label_sid, price_label_producer_name,
repair_start_dt, repair_end_dt, price_label_warranty_status_cd, price_label_repair_result_cd,
price_label_repair_batch_nr, price_label_repair_origin_name, defect_txt, repair_process_name, dwh_load_id, dwh_created,
dwh_updated, price_label_client_id) AS SELECT price_label_sid,
 price_label_producer_name,
 repair_start_dt,
 repair_end_dt,
 price_label_warranty_status_cd,
 price_label_repair_result_cd,
 price_label_repair_batch_nr,
 price_label_repair_origin_name,
 defect_txt,
 repair_process_name,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 price_label_client_id
FROM ldl_p_lew_core.t_price_label_repair_state_2;