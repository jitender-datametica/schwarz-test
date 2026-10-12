CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_creation_class_1 (
nfpo_item_creation_class_cd STRING(100) NOT NULL
OPTIONS(description='PK Item_1 class;            CBX: Item.ldlArticleType.code;            ESB: cbxItem.itemType.code;'),
nfpo_item_creation_class_name STRING(100)
OPTIONS(description='Item_1 class description;            CBX: Item.ldlArticleType.custText1;            ESB: cbxItem.itemType.description;'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_creation_class_cd) NOT ENFORCED
)
OPTIONS(description='NFPO item_1 classification related to item_1 creation and usage over time             CBX:  CNT_CODELIST_1, code list\'LIDL_ARTICLETYPE\'');