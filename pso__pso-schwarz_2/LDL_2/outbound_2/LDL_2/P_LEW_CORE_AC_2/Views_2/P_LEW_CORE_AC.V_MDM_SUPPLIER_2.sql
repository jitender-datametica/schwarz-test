CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_supplier_2 (client_id, mdm_sup_sid, src_vendor_doc_ref, sup_nr, sup_name,
dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_sup_sid,
 src_vendor_doc_ref,
 sup_nr,
 sup_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_supplier_2;