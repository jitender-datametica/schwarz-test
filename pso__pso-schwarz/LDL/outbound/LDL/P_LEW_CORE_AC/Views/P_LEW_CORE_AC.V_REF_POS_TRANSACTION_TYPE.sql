CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_ref_pos_transaction_type (client_id, transaction_type_cd,
transaction_type_descr, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 transaction_type_cd,
 transaction_type_descr,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_ref_pos_transaction_type;