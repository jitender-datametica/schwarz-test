CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_item_origin_type_2 (
item_origin_type_cd STRING(100) NOT NULL,
item_origin_type_name STRING(100) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (item_origin_type_cd) NOT ENFORCED
) OPTIONS(description='');