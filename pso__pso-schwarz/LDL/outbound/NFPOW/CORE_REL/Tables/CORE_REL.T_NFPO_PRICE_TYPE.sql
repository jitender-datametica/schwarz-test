CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_price_type (
nfpo_price_type_cd STRING(100) NOT NULL,
nfpo_price_type_name STRING(100),
nfpo_price_type_descr STRING(250),
lob_fg BOOL,
nfpo_market_fg BOOL,
nfpo_incoterm_fg BOOL,
nfpo_org_fg BOOL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_price_type_cd) NOT ENFORCED
) OPTIONS(description='price types used in the non food product development and ordering process');