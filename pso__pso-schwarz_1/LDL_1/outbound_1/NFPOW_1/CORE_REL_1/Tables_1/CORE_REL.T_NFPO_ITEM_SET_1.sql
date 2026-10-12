CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_set_1 (
nfpo_item_set_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_item_nr STRING(100) NOT NULL,
nfpo_item_set_style_nr STRING(2000) NOT NULL,
nfpo_item_set_content_qty BIGNUMERIC(38,5) NOT NULL,
nfpo_item_set_multipack_fg BOOL NOT NULL,
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_set_sid) NOT ENFORCED
)
OPTIONS(description='NFPO item_1 variant defining sets of styles             CBX: LDL_ITEM_UNIQUE_STYLE_1, LDL_ITEM_STYLE');