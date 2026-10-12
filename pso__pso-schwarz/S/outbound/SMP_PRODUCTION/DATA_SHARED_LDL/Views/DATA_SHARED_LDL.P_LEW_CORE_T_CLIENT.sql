CREATE OR REPLACE VIEW smp_production_data_shared_ldl.p_lew_core_t_client (client_id, src_client_id, src_country_lidl_cd
, src_country_cbx_cd, client_name, country_sid, country_cd, curr_sid, curr_cd, client_online_fg, dwh_load_id,
dwh_created, dwh_updated, td_insert, td_update, lob_cd) AS SELECT client_id,
 src_client_id,
 src_country_lidl_cd,
 src_country_cbx_cd,
 client_name,
 country_sid,
 country_cd,
 curr_sid,
 curr_cd,
 client_online_fg,
 dwh_load_id,
 dwh_created,
 dwh_updated,
 td_insert,
 td_update,
 lob_cd
FROM ldl_p_lew_core.t_client;