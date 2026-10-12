CREATE TABLE IF NOT EXISTS ldl_p_lew_process.t_sap_migration_wh (
client_id BIGNUMERIC(38,0) NOT NULL,
loc_sid_wh BIGNUMERIC(38,0) NOT NULL,
wawi_dwh_client_id BIGNUMERIC(38,0) NOT NULL,
wawi_dwh_wh_id BIGNUMERIC(38,0) NOT NULL,
migrated_start_dt DATE NOT NULL,
migrated_end_dt DATE NOT NULL,
migrated_fg BIGNUMERIC(38,0) NOT NULL,
car_migrated_start_dt DATE NOT NULL,
car_migrated_end_dt DATE NOT NULL,
car_migrated_fg BIGNUMERIC(38,0) NOT NULL,
dwh_load_id BIGNUMERIC(38,0) NOT NULL,
dwh_created DATETIME NOT NULL,
dwh_updated DATETIME NOT NULL
);