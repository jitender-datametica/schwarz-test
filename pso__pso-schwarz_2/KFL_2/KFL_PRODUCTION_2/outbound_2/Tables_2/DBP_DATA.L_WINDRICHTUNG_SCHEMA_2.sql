CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.l_windrichtung_schema_2 (
windrichtung_schema_id BIGNUMERIC(38,0) NOT NULL,
windrichtung_schema_bez STRING(30) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);