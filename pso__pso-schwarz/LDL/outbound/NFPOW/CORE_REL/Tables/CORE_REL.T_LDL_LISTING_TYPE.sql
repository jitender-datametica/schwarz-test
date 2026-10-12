CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_listing_type (
ldl_list_type_id BIGNUMERIC(38,0) NOT NULL,
ldl_list_type_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_list_type_id) NOT ENFORCED
) OPTIONS(description='');