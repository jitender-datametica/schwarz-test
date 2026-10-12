CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.in_lieferant_int_2 (
in_lief_id_int BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
lief_name STRING(40) COLLATE 'und:ci',
td_update TIMESTAMP,
td_insert TIMESTAMP
);