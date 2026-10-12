CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_country (
nfpo_country_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_country_cd STRING(100),
nfpo_country_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_country_sid) NOT ENFORCED
) OPTIONS(description='$Revision: 0000 $. Politische Laender');