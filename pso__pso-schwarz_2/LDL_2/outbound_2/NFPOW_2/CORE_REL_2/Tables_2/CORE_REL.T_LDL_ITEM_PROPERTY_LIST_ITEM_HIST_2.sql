CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_ldl_item_property_list_item_hist_2 (
ldl_item_sid BIGNUMERIC(38,0) NOT NULL,
ldl_item_property_list_nr BIGNUMERIC(38,0) NOT NULL,
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
dwh_valid_from_tmsp TIMESTAMP NOT NULL,
dwh_valid_to_tmsp TIMESTAMP NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_item_sid, ldl_item_property_list_nr) NOT ENFORCED
) OPTIONS(description='');