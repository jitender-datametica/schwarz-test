CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_split_method (
nfpo_item_split_method_cd STRING(100) NOT NULL OPTIONS(description='code of the split method in the split process'),
nfpo_item_split_method_name STRING(100) OPTIONS(description='name of the split method in the split process'),
nfpo_item_split_method_descr STRING(250) OPTIONS(description='description of the split method in the split process'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_split_method_cd) NOT ENFORCED
)
OPTIONS(description='NFPO codes for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item granularity requirements in Kaufland compared to Lidl (\'Vereinzelung\')             CBX:  CNT_CODELIST, code list\'LIDL_STYLE_SPLITTING\'');