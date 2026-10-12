CREATE TABLE CORE_REL.T_NFPO_CASE_COMPOSITION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_case_composition_cd            VARCHAR(100)     NOT NULL COMMENT 'code ofoptions to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.CODE, code list ''LIDL_NUMBEROFSET''
            ',
   nfpo_case_composition_txt           VARCHAR(1000)    NOT NULL COMMENT 'text of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME, code list ''LIDL_NUMBEROFSET''',
   nfpo_subcase_size_qty               NUMBER(38,5)     COMMENT 'predefined number of items in the text of options to put items in the case when the case will be filled by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME, code list ''LIDL_NUMBEROFSET''',
   nfpo_case_composition_name          VARCHAR(100)     COMMENT 'text of options to put items in the case whithout the predefined number of items in  possible sub cases , indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
            CBX:  CNT_CODELIST.NAME, code list ''LIDL_NUMBEROFSET''',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_CASE_COMPOSITION PRIMARY KEY (nfpo_case_composition_cd) NOT ENFORCED 
)  COMMENT = 'list of options to put items in the case, indicates whether the case will be filled by items directly or by subcases which contain a predefined number of items.
             CBX:  CNT_CODELIST_1, code list ''LIDL_NUMBEROFSET''';