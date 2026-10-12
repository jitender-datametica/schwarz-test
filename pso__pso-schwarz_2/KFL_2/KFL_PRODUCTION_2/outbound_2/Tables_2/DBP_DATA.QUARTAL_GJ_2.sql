CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.quartal_gj_2 (
gjqu BIGNUMERIC(38,0) NOT NULL,
akt_gjqu BIGNUMERIC(38,0),
akt_gjqu_komplett BIGNUMERIC(38,0),
gj BIGNUMERIC(38,0),
akt_gj BIGNUMERIC(38,0),
akt_gj_komplett BIGNUMERIC(38,0),
gjhj BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);