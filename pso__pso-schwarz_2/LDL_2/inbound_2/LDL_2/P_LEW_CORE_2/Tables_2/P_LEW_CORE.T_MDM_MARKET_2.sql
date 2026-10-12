CREATE TABLE P_LEW_CORE.T_MDM_MARKET_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   market_sid                          NUMBER(38,0)    NOT NULL COMMENT 'surrogate key NFPO market
            CBX: CNT_CODELIST.CODE codelist ''LIDL_CONTINENT_TYPE''',
   market_cd                           VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'NFPO market code
            CBX: CNT_CODELIST.CODE codelist ''LIDL_CONTINENT_TYPE''',
   market                              VARCHAR(100)    COLLATE 'en-ci' NOT NULL COMMENT 'NFPO market name
            CBX: CNT_CODELIST.NAME codelist ''LIDL_CONTINENT_TYPE''',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_MARKET PRIMARY KEY (market_sid) NOT ENFORCED 
)  COMMENT = 'NFPO target markets_2
             CBX: codelist LIDL_CONTINENT_TYPE';