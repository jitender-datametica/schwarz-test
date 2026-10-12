CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_l_einkaeufer_grp_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
einkaeufer_grp_id STRING(3) COLLATE 'und:ci' NOT NULL,
aktiv_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);