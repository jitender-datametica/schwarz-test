CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_supplier_coneg_country_hist_1 (client_id, sup_sid, country_sid_conegot,
country_cd_conegot, deleted_fg, dwh_valid_from, dwh_valid_to, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id
 ,
 sup_sid,
 country_sid_conegot,
 country_cd_conegot,
 deleted_fg,
 dwh_valid_from,
 dwh_valid_to,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_supplier_coneg_country_hist_1;