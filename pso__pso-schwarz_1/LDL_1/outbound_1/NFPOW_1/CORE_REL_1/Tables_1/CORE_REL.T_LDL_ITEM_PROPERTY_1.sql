CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_item_property_1 (
ldl_item_property_sid BIGNUMERIC(38,0) NOT NULL,
ldl_item_property_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_item_property_sid) NOT ENFORCED
) OPTIONS(description='');