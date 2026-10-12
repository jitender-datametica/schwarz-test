CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_ekorg (
einkaufsorganisation_id BIGNUMERIC(38,0) NOT NULL,
mandant_id BIGNUMERIC(38,0) NOT NULL,
buchungskreis_id BIGNUMERIC(38,0) NOT NULL,
sako_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);