CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_brand_type (
nfpo_brand_type_cd STRING(100) NOT NULL,
nfpo_brand_type_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_brand_type_cd) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $ Brand Type;             Static data:             M: Marke             EM: Eigenmarke');