CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_variant (client_id, mdm_item_variant_sid, src_item_doc_ref,
src_variant_cd, variant_name, mdm_item_sid, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_item_variant_sid,
 src_item_doc_ref,
 src_variant_cd,
 variant_name,
 mdm_item_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_variant;