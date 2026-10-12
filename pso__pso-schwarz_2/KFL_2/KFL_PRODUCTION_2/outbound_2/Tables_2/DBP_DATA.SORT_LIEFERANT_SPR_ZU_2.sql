CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.sort_lieferant_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
kjwo_update BIGNUMERIC(38,0) NOT NULL,
akt_lieferant_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
akt_lieferant_bez STRING(200) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);