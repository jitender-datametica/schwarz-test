CREATE TABLE IF NOT EXISTS nfpow_core.t_dim_ldl_local_item_2 (
lob_cd STRING(100) NOT NULL,
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
ldl_item_nr BIGNUMERIC(38,0) NOT NULL,
active_from_dt DATE NOT NULL,
ldl_item_ian_nr BIGNUMERIC(38,0) NOT NULL,
item_origin_type_cd STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (lob_cd, ldl_client_id, ldl_item_nr, active_from_dt) NOT ENFORCED
) OPTIONS(description='');