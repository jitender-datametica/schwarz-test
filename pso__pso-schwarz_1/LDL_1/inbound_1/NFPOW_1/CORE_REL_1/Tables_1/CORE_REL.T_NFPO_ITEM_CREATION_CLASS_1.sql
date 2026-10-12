CREATE TABLE CORE_REL.T_NFPO_ITEM_CREATION_CLASS_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_creation_class_cd         VARCHAR(100)     NOT NULL COMMENT 'PK Item_1 class;
            CBX: Item.ldlArticleType.code;
            ESB: cbxItem.itemType.code;',
   nfpo_item_creation_class_name       VARCHAR(100)     COMMENT 'Item_1 class description;
            CBX: Item.ldlArticleType.custText1;
            ESB: cbxItem.itemType.description;',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_CREATION_CLASS PRIMARY KEY (nfpo_item_creation_class_cd) NOT ENFORCED 
)  COMMENT = 'NFPO item_1 classification related to item_1 creation and usage over time
             CBX:  CNT_CODELIST_1, code list ''LIDL_ARTICLETYPE''';
