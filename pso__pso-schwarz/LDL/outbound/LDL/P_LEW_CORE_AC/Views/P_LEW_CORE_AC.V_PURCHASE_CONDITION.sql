CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_purchase_condition (client_id, pur_cond_sid, src_knumh, application_cd,
condition_type_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 pur_cond_sid,
 src_knumh,
 application_cd,
 condition_type_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_purchase_condition;