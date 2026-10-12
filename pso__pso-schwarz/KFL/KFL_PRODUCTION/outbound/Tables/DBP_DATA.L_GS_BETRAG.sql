CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_gs_betrag (
mandant_id BIGNUMERIC(38,0) NOT NULL,
ausgeber_typ_id STRING(3) COLLATE 'und:ci' NOT NULL,
betrag_von NUMERIC(9,2) NOT NULL,
betrag_bis NUMERIC(9,2) NOT NULL,
wrg_id STRING(3) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);