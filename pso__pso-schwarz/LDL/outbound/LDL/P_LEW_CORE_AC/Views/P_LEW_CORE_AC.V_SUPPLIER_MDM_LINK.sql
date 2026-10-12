CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_supplier_mdm_link (client_id, sup_sid, mdm_sup_sid, dwh_load_id, dwh_created
, dwh_updated) AS SELECT client_id,
 sup_sid,
 mdm_sup_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_supplier_mdm_link;