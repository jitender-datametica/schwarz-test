CREATE TABLE CORE_REL.T_NFPO_LIST_TYPE DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_list_type_cd                   VARCHAR(100)     NOT NULL COMMENT 'NFPO codes for list types of items
            CBX:  CNT_CODELIST.CODE, code list ''LIDL_ASSORTMENT_TYPE''',
   nfpo_list_type_name                 VARCHAR(100)     COMMENT 'NFPO names for list types of items
            CBX:  CNT_CODELIST.NAME, code list ''LIDL_ASSORTMENT_TYPE''',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_LIST_TYPE PRIMARY KEY (nfpo_list_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO codes for list types of items
             CBX:  CNT_CODELIST, code list ''LIDL_ASSORTMENT_TYPE''';
