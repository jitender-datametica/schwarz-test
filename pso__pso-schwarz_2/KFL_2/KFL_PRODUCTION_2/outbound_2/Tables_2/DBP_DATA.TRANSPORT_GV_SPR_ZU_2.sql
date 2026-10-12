CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.transport_gv_spr_zu_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
transport_gv_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
transport_gv_bez STRING(50) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);