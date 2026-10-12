CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.windrichtung_spr_zu (
windrichtung_schema_id BIGNUMERIC(38,0) NOT NULL,
windrichtung_id BIGNUMERIC(38,0) NOT NULL,
spr_id BIGNUMERIC(38,0) NOT NULL,
windrichtung_bez_kurz STRING(5) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
windrichtung_bez_lang STRING(50) COLLATE 'und:ci' DEFAULT ' ' NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);