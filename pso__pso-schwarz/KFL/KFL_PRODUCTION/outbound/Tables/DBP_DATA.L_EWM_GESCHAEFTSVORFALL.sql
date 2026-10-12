CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_ewm_geschaeftsvorfall (
mandant_id BIGNUMERIC(38,0) NOT NULL,
lagernummer_id STRING(4) COLLATE 'und:ci' NOT NULL,
ewm_gv_id BIGNUMERIC(38,0) NOT NULL,
ewm_gv_grp_id STRING(4) COLLATE 'und:ci' NOT NULL,
gv_einheit_id STRING(4) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);