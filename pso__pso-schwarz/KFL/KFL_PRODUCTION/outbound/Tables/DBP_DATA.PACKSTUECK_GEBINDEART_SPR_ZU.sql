CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.packstueck_gebindeart_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
packstueck_gebindeart_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
packstueck_gebindeart_bez STRING(40) COLLATE 'und:ci',
td_insert TIMESTAMP,
td_update TIMESTAMP
);