CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_warranty_duration_2 (
nfpo_warranty_dur_cd STRING(100) NOT NULL
OPTIONS(description='PK Guarantee type;            CBX: Item.ldlGuarantee.code;            ESB: cbxItem.displayType.code;'),
nfpo_warranty_dur_name STRING(100)
OPTIONS(description='Guarantee description;            CBX: Item.ldlGuarantee.name;            ESB: cbxItem.guarantee.name;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_warranty_dur_cd) NOT ENFORCED
) OPTIONS(description='NFPO warranty length types of items             CBX:  CNT_CODELIST_2, code list\'LIDL_WARRANTY\'');