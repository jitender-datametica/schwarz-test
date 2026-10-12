CREATE TABLE CORE_REL.T_NFPO_COMPETITOR_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_competitor_sid                 NUMBER(38,0)     NOT NULL,
   nfpo_competitor_cd                  VARCHAR(100)     NOT NULL,
   nfpo_competitor_name                VARCHAR(100),
   nfpo_competitor_abbr_name           VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_COMPETITOR PRIMARY KEY (nfpo_competitor_sid) NOT ENFORCED 
)  COMMENT = 'list of retail companies regarded as competitors
             CBX: Codelist LIDL_COMPET';
