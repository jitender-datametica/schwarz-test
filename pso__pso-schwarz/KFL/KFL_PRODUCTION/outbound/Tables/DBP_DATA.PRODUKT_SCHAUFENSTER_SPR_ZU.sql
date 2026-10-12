CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.produkt_schaufenster_spr_zu (
mandant_id BIGNUMERIC(38,0) NOT NULL,
psf_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
psf_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);