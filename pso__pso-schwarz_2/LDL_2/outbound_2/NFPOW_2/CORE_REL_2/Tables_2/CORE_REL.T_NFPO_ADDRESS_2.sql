CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_address_2 (
nfpo_addr_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_sup_nr STRING(100),
nfpo_country_sid BIGNUMERIC(38,0),
nfpo_country_cd STRING(100),
street_name STRING(100),
city_name STRING(100),
zip STRING(15),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_addr_sid) NOT ENFORCED
)
OPTIONS(description='$Revision: 0000 $. Addresses related primarily to Buildings, but also to Suppliers or any other feasible entity');