CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_sap_migration_client (
client_id INTEGER NOT NULL,
wawi_dwh_client_id INTEGER,
elwis_dwh_ec_cd INTEGER,
migrated_start_dt DATE NOT NULL,
migrated_end_dt DATE NOT NULL,
migrated_fg INTEGER NOT NULL,
car_migrated_start_dt DATE NOT NULL,
car_migrated_end_dt DATE NOT NULL,
car_migrated_fg INTEGER NOT NULL,
dwh_load_id INTEGER NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);