CREATE TABLE CORE_REL.T_NFPO_COMPLETION_TYPE_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_market_sid                     NUMBER(38,0)     NOT NULL COMMENT 'surrogate key market
            CBX: derived from the type of code list',
   nfpo_completion_type_cd             VARCHAR(100)     NOT NULL COMMENT 'NFPO completion types
            CBX:CNT_CODELIST.CODE (code list ''LIDL_OWIMFH'' and ''LIDL_COMPLTYPE_US'')',
   nfpo_completion_type_name           VARCHAR(100)     NOT NULL COMMENT 'NFPO completion type name
            CBX:CNT_CODELIST.NAME (code list ''LIDL_OWIMFH'' and ''LIDL_COMPLTYPE_US''',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_COMPLETION_TYPE PRIMARY KEY (nfpo_market_sid, nfpo_completion_type_cd) NOT ENFORCED 
)  COMMENT = 'NFPO completion type codes, different codes are used for different markets_2
             CBX: CNT_CODELIST_2, code lists ''LIDL_OWIMFH'', ''LIDL_COMPLTYPE_US''
             ';