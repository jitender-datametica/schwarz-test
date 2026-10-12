CREATE TABLE p_lew_process.t_sap_migration_client_2 (
client_id INTEGER NOT NULL,
wawi_dwh_client_id INTEGER,
elwis_dwh_ec_cd INTEGER,
migrated_start_dt DATE NOT NULL,
migrated_end_dt DATE NOT NULL,
migrated_fg BYTEINT NOT NULL,
car_migrated_start_dt DATE NOT NULL,
car_migrated_end_dt DATE NOT NULL,
car_migrated_fg BYTEINT NOT NULL,
dwh_load_id INTEGER NOT NULL,
DWH_CREATED TIMESTAMP_NTZ(9) NOT NULL,
DWH_UPDATED TIMESTAMP_NTZ(9) NOT NULL,
UNIQUE ( client_id)
);

