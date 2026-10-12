CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_packing_list (
nfpo_item_pack_list_sid BIGNUMERIC(38,0) NOT NULL,
nfpo_item_nr STRING(100) NOT NULL,
nfpo_item_pack_method_nr STRING(100) NOT NULL,
nfpo_item_sid BIGNUMERIC(38,0) NOT NULL,
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_pack_list_sid) NOT ENFORCED
)
OPTIONS(description='information about packing lists for the sort boxes of NFPO items             CBX: LDL_ITEM_PACKING_METHOD');