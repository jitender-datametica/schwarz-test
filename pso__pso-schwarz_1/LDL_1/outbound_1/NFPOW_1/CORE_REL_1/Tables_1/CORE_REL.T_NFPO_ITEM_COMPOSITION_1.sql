CREATE TABLE IF NOT EXISTS nfpow_core_rel.t_nfpo_item_composition_1 (
nfpo_item_composition_cd STRING(100) NOT NULL
OPTIONS(description='''code of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:  CNT_CODELIST.CODE, code list \'LIDL_ASSORTMENT\''''),
nfpo_item_composition_txt STRING(1000) NOT NULL
OPTIONS(description='''text of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:  CNT_CODELIST.NAME, code list \'LIDL_ASSORTMENT\''''),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der Ersteinfügung des Datensatzes ins DWH.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='Zeitstempel der letzten Änderung des Datensatzes im DWH.'),
dwh_src_tmsp TIMESTAMP NOT NULL OPTIONS(description='Timestamp of source extraction.'),
PRIMARY KEY (nfpo_item_composition_cd) NOT ENFORCED
)
OPTIONS(description='''list of item_1 composition codes, indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
             CBX:  CNT_CODELIST_1, code list \'LIDL_ASSORTMENT\'''');