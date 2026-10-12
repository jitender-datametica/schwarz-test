CREATE TABLE IF NOT EXISTS kfl_production_dbp_ods_archiv.ods_talon_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
talon_id BIGNUMERIC(36,0) NOT NULL,
wup_id BIGNUMERIC(38,0) NOT NULL,
talon_dat DATE NOT NULL,
talon_booking DATETIME NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);