CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_app_store_2 (client_id, app_store_sid, app_store_nr, app_store_name,
sales_channel_sid, country_sid, country_cd, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 app_store_sid,
 app_store_nr,
 app_store_name,
 sales_channel_sid,
 country_sid,
 country_cd,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_app_store_2;