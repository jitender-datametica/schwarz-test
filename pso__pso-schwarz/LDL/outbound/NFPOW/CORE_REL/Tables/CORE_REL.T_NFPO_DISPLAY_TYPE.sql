CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_display_type (
nfpo_display_type_cd STRING(100) NOT NULL
OPTIONS(description='PK Display type;            CBX: Item.ldlDisplayType.code;            ESB: cbxItem.displayType.code;'),
nfpo_display_type_name STRING(100)
OPTIONS(description='Display type description;            CBX: Item.ldlDisplayType.name;            ESB: cbxItem.displayType.name;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_display_type_cd) NOT ENFORCED
) OPTIONS(description='NFPO display types of items             CBX:  CNT_CODELIST, code list\'LIDL_DISPLAYTYPE\'');