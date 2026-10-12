CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.massnahmentyp_spr_zu_2 (
massnahmentyp_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
massnahmentyp_bez STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);