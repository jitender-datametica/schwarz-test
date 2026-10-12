CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.mitbewerber_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
mitbewerber_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
mitbewerber_bez STRING(20) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);