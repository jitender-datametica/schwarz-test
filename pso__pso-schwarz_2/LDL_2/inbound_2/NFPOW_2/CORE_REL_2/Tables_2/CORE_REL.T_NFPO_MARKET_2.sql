CREATE TABLE CORE_REL.T_NFPO_MARKET_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_market_sid                     NUMBER(38,0)     NOT NULL,
   nfpo_market_cd                      VARCHAR(100)     NOT NULL,
   nfpo_market_name                    VARCHAR(100)     NOT NULL,
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_MARKET PRIMARY KEY (nfpo_market_sid) NOT ENFORCED 
)  COMMENT = 'NFPO target markets_2
             CBX: codelist LIDL_CONTINENT_TYPE';
