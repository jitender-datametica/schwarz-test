CREATE TABLE IF NOT EXISTS kfl_production_dbp_data.vis_l_problemcode (
mandant_id BIGNUMERIC(38,0) NOT NULL,
problemcode_id STRING(4) NOT NULL,
problemcode_bez STRING(40) DEFAULT ' ' NOT NULL,
kopf_fehler_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
pos_fehler_fg BIGNUMERIC(38,0) DEFAULT 0 NOT NULL,
mkcheck STRING(1) DEFAULT ' ' NOT NULL,
faktor NUMERIC(9,2) DEFAULT 0 NOT NULL,
aus_problemcode_id STRING(4) DEFAULT '    ' NOT NULL,
active BIGNUMERIC(38,0) DEFAULT 1 NOT NULL,
td_insert TIMESTAMP,
td_update TIMESTAMP
);