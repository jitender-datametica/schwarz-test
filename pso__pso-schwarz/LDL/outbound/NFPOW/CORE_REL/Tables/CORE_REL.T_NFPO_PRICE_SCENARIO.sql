CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_price_scenario (
nfpo_price_scenario_nr BIGNUMERIC(38,0) NOT NULL,
nfpo_price_type_cd STRING(100),
lob_cd STRING(100),
nfpo_market_sid BIGNUMERIC(38,0),
nfpo_incoterm_cd STRING(100),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_price_scenario_nr) NOT ENFORCED
)
OPTIONS(description='price scenarios used in the non food product development and ordering process drived from price types and the used additional dimentsion lob, market             prices which are differenciated by targeted intenal organisation are not included here');