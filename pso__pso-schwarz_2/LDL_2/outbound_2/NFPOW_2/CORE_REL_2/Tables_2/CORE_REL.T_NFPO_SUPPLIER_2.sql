CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_supplier_2 (
nfpo_sup_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_sup_nr STRING(100) NOT NULL,
eks_sup_nr STRING(100),
nfpo_sup_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_sup_sid) NOT ENFORCED
) OPTIONS(description='NFPO related vendor definition             CBX: CNT_VENDOR_2, CTM_VENDOR_2');