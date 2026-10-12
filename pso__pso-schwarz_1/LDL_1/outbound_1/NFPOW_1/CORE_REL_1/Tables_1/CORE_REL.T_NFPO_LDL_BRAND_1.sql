CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_ldl_brand_1 (
nfpo_ldl_brand_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_ldl_brand_nr STRING(100),
nfpo_ldl_brand_name STRING(100),
nfpo_brand_type_cd STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_ldl_brand_sid) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. BRND; Marken; ');