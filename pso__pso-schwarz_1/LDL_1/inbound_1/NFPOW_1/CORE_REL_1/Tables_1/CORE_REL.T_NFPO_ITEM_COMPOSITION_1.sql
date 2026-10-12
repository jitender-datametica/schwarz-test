CREATE TABLE CORE_REL.T_NFPO_ITEM_COMPOSITION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_composition_cd            VARCHAR(100)     NOT NULL COMMENT 'code of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:  CNT_CODELIST.CODE, code list ''LIDL_ASSORTMENT''',
   nfpo_item_composition_txt           VARCHAR(1000)    NOT NULL COMMENT 'text of the indicator in the item_1 planning process: indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
            CBX:  CNT_CODELIST.NAME, code list ''LIDL_ASSORTMENT''',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_COMPOSITION PRIMARY KEY (nfpo_item_composition_cd) NOT ENFORCED 
)  COMMENT = 'list of item_1 composition codes, indicates whether an item_1 has relevant variants or consists of certain sub parts. interpretation depends on the overall composition of the item. assort  or assemble: (x)fach sortiert oder (x)teilig
             CBX:  CNT_CODELIST_1, code list ''LIDL_ASSORTMENT''';
