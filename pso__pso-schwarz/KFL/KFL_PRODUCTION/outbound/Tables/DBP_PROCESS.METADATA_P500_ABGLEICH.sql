CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.metadata_p500_abgleich (
quell_db STRING(40) NOT NULL,
ziel_db STRING(40) NOT NULL,
tabelle STRING(40) NOT NULL,
check_fg BIGNUMERIC(38,0),
refresh_fg BIGNUMERIC(38,0),
td_update TIMESTAMP,
td_insert TIMESTAMP
);