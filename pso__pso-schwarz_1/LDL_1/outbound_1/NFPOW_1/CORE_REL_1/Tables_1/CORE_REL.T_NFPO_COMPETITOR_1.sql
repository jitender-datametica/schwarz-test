CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_competitor_1 (
nfpo_competitor_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_competitor_cd STRING(100) NOT NULL,
nfpo_competitor_name STRING(100),
nfpo_competitor_abbr_name STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_competitor_sid) NOT ENFORCED
) OPTIONS(description='list of retail companies regarded as competitors             CBX: Codelist LIDL_COMPET');