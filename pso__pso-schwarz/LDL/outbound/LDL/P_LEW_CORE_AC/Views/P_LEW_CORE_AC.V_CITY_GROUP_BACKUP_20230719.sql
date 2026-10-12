CREATE OR REPLACE VIEW ldl_p_lew_core_ac.v_city_group_backup_20230719 (client_id, city_group_sid, src_city_group_id,
city_group_name, dwh_load_id, dwh_created, dwh_updated) AS SELECT client_id,
 city_group_sid,
 src_city_group_id,
 city_group_name,
 dwh_load_id,
 dwh_created,
 dwh_updated
FROM ldl_p_lew_core.t_city_group_backup_20230719;