CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.tourart_subtyp_spr_zu_2 (
tourart_subtyp_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
tourart_subtyp_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);