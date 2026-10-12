CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_supplier_ldl_supplier_2 (
nfpo_sup_sid BIGNUMERIC(38,0) NOT NULL,
ldl_sup_sid BIGNUMERIC(38,0) NOT NULL,
ldl_client_id BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (ldl_sup_sid, nfpo_sup_sid) NOT ENFORCED
) OPTIONS(description='');