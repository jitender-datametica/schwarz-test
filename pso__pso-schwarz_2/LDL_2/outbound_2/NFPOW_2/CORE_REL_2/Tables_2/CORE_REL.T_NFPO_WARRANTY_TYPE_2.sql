CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_warranty_type_2 (
nfpo_warranty_type_cd STRING(100) NOT NULL
OPTIONS(description='PK Guarantee Type;            CBX: Item.ldlWarrantyArtType.code;             ESB: cbxItem.guaranteeType.code;'),
nfpo_warranty_type_name STRING(100)
OPTIONS(description=' Guarantee Type description;            CBX: Item.ldlWarrantyArtType.name;             ESB: cbxItem.guaranteeType.name;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_warranty_type_cd) NOT ENFORCED
) OPTIONS(description='NFPO warranty types of items             CBX:  CNT_CODELIST_2, code list\'LIDL_WARRANTY_ART\'');