CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_ldl_currency (
curr_cd STRING(3) NOT NULL,
ldl_curr_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (curr_cd) NOT ENFORCED
) OPTIONS(description='');