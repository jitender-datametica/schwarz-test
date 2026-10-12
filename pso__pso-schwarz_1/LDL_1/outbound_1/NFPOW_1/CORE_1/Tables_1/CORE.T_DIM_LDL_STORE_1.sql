CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_ldl_store_1 (
lob_cd STRING(100) NOT NULL,
ldl_store_sid BIGNUMERIC(38,0) NOT NULL,
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
ldl_store_nr STRING(100),
ldl_store_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, ldl_store_sid) NOT ENFORCED
) OPTIONS(description='');