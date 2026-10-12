CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_split_role_1 (
nfpo_item_split_role_cd STRING(100) NOT NULL OPTIONS(description='code of the item_1 role in the split process'),
nfpo_item_split_role_name STRING(100) OPTIONS(description='name of the item_1 role in the split process'),
nfpo_item_split_role_descr STRING(250) OPTIONS(description='description of the item_1 role in the split process'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_split_role_cd) NOT ENFORCED
)
OPTIONS(description='NFPO codes for the roles items can have in the split process to create Kaufland specific items from standard NFPO items due to different item_1 granularity requirements in Kaufland compared to Lidl (\'Vereinzelung\')             CBX: CNT_CODELIST_1, code list\'LIDL_PARENT_CHILD\'');