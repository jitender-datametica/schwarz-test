CREATE TABLE CORE_REL.T_NFPO_ITEM_QUALITY_CLASS DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_quality_class_cd          VARCHAR(100)     NOT NULL COMMENT 'item quality classification code (good, better, best)
            CBX:Item/ldlArticleClass/code
            ESB:cbxItem/articleClass',
   nfpo_item_quality_class_descr       VARCHAR(250)     NOT NULL COMMENT 'description for item quality classification code (good, better, best)
            CBX:Item/ldlArticleClass/code
            ESB:cbxItem/articleClass',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_QUALITY_CLASS PRIMARY KEY (nfpo_item_quality_class_cd) NOT ENFORCED 
)  COMMENT = 'NFPO item classification related to item quality compared to the overall market
             CBX:  CNT_CODELIST, code list ''LDL_Article_Class''';
