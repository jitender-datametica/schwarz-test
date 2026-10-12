BEGIN TRANSACTION;


TRUNCATE TABLE szd_production_core.${TST_PREFIX}t_dim_charging_station_owner_1;


INSERT INTO szd_production_core.${TST_PREFIX}t_dim_charging_station_owner_1 (party_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
 dwh_valid_fg, charging_station_owner_name, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, dwh_src_1_tmsp)
(SELECT *
 FROM szd_production_core_rel.t_charging_station_owner_1);


COMMIT