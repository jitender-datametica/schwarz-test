CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_quality_class_2 (
nfpo_item_quality_class_cd STRING(100) NOT NULL
OPTIONS(description='item_2 quality classification code (good, better, best)            CBX:Item_2/ldlArticleClass/code            ESB:cbxItem/articleClass'),
nfpo_item_quality_class_descr STRING(250) NOT NULL
OPTIONS(description='description for item_2 quality classification code (good, better, best)            CBX:Item_2/ldlArticleClass/code            ESB:cbxItem/articleClass'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_quality_class_cd) NOT ENFORCED
)
OPTIONS(description='NFPO item_2 classification related to item_2 quality compared to the overall market             CBX:  CNT_CODELIST_2, code list\'LDL_Article_Class\'');