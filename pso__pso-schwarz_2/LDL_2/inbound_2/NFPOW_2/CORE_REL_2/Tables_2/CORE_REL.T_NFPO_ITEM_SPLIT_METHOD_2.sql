CREATE TABLE CORE_REL.T_NFPO_ITEM_SPLIT_METHOD_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_item_split_method_cd           VARCHAR(100)     NOT NULL COMMENT 'code of the split method in the split process',
   nfpo_item_split_method_name         VARCHAR(100)     COMMENT 'name of the split method in the split process',
   nfpo_item_split_method_descr        VARCHAR(250)     COMMENT 'description of the split method in the split process',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ITEM_SPLIT_METHOD PRIMARY KEY (nfpo_item_split_method_cd) NOT ENFORCED 
)  COMMENT = 'NFPO codes for the split methods in the split process to create Kaufland specific items from standard NFPO items due to different item_2 granularity requirements in Kaufland compared to Lidl (''Vereinzelung'')
             CBX:  CNT_CODELIST_2, code list ''LIDL_STYLE_SPLITTING''';
