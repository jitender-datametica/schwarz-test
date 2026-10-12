CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_size (
nfpo_item_size_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_item_nr STRING(100) NOT NULL,
nfpo_item_size_nr STRING(300) NOT NULL,
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_size_sid) NOT ENFORCED
) OPTIONS(description='NFPO item variant defining sizes             CBX: LDL_ITEM_SIZE');