CREATE OR REPLACE VIEW ldl_production_p_lew_core_ac.v_client_migration_per_2 (client_id, wawi_dwh_client_id,
elwis_dwh_ec_cd, migration_dat_valid_from, migration_dat_valid_to, active_fg, dwh_create, dwh_upd, dwh_load_id) AS
SELECT client_id,
 wawi_dwh_client_id,
 elwis_dwh_ec_cd,
 migration_dat_valid_from,
 migration_dat_valid_to,
 active_fg,
 dwh_create,
 dwh_upd,
 dwh_load_id
FROM ldl_production_p_lew_core.t_client_migration_per_2;