CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mat_org_store_skey_2 AS SELECT client_id,
 loc_sid_store AS store_id,
 src_wh_id AS wh_id,
 src_orig_store_nr AS orig_store_nr
FROM ldl_p_lew_bil_ac.v_store_to_warehouse_lastknown_2;