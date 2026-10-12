CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.windrichtung_map_2 (
windrichtung_schema_id_source BIGNUMERIC(38,0) NOT NULL,
windrichtung_id_source BIGNUMERIC(38,0) NOT NULL,
windrichtung_schema_id_dest BIGNUMERIC(38,0) NOT NULL,
windrichtung_id_dest BIGNUMERIC(38,0) NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);