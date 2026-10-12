CREATE TABLE CORE_REL.T_NFPO_INCOTERM DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_market_sid                     NUMBER(38,0)     NOT NULL COMMENT 'surrogate key market
            CBX: derived from the type of code list',
   nfpo_incoterm_cd                    VARCHAR(100)     NOT NULL COMMENT 'NFPO incoterm codes similar to the terms defined by the International Chamber of Commerce
            CBX:CNT_CODELIST.CODE (code list ''INCOTERM'' and ''LIDL_INCOTERM_US'')',
   nfpo_incoterm_name                  VARCHAR(100)     NOT NULL COMMENT 'NFPO incoterm names similar to the terms defined by the International Chamber of Commerce
            CBX:CNT_CODELIST.NAME (code list ''INCOTERM'' and ''LIDL_INCOTERM_US'')',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_INCOTERM PRIMARY KEY (nfpo_market_sid, nfpo_incoterm_cd) NOT ENFORCED 
)  COMMENT = 'NFPO set of codes for commercial terms in the contracts, different codes are used for different markets
             CBX: CNT_CODELIST, code lists ''INCOTERM'', ''LIDL_INCOTERM_US''';
