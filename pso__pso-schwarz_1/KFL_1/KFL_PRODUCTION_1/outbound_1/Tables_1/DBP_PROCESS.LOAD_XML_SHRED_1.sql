CREATE TABLE IF NOT EXISTS kfl_production_dbp_process.load_xml_shred_1 (
cycle_id BIGNUMERIC(38,0) NOT NULL,
landkz STRING(3) COLLATE 'und:ci' NOT NULL,
file_groesse BIGNUMERIC(38,0) NOT NULL,
xml_file_name STRING(250) COLLATE 'und:ci' NOT NULL,
td_update TIMESTAMP,
td_insert TIMESTAMP
);