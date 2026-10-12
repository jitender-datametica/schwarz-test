CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.besch_faktura_kondit_columnar_2 (
mandant_id BIGNUMERIC(38,0) NOT NULL,
faktura_beleg_id INTEGER NOT NULL,
faktura_beleg_pos_id BIGNUMERIC(38,0) NOT NULL,
beleg_kondition_id INTEGER NOT NULL,
kondition_schl_id STRING(4) COLLATE 'und:ci' NOT NULL,
kondition_wert NUMERIC(18,2) NOT NULL,
kappl STRING(2) COLLATE 'und:ci' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
) CLUSTER BY mandant_id;