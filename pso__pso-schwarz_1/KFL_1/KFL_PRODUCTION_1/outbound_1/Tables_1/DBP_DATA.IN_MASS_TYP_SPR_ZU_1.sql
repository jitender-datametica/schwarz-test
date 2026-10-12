CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_mass_typ_spr_zu_1 (
in_massnahme_typ_id STRING(3) COLLATE 'und:ci' NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
in_massnahme_typ_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);