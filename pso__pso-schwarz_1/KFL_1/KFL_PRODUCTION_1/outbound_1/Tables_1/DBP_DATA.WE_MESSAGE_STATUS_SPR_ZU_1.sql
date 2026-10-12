CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.we_message_status_spr_zu_1 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
we_message_status_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
we_message_status_bez STRING(40) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);