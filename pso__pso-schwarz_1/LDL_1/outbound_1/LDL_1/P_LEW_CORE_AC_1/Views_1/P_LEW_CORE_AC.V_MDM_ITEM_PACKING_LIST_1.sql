CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_item_packing_list_1 (client_id, mdm_pack_list_sid, src_item_doc_ref,
src_pack_method_cd, mdm_item_sid, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 mdm_pack_list_sid,
 src_item_doc_ref,
 src_pack_method_cd,
 mdm_item_sid,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_item_packing_list_1;