CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_mdm_supplier_hist (client_id, mdm_sup_sid, cbx_vendor_version_nr,
sup_ship_terms_cd, ean_ownership_cd, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS
SELECT client_id,
 mdm_sup_sid,
 cbx_vendor_version_nr,
 sup_ship_terms_cd,
 ean_ownership_cd,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_mdm_supplier_hist;