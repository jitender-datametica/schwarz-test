CREATE TABLE P_LEW_CORE.T_MDM_COMPETITOR (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   competitor_sid                      NUMBER(38,0)    NOT NULL COMMENT 'surrogate key Competitor
            CBX: CNT_ITEM.LDL_COMPETITOR,LDL_COMPETITOR2',
   src_competitor_cd                   VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'unified abbreviation of the competitor
            CBX: CNT_ITEM.LDL_COMPETITOR,LDL_COMPETITOR2',
   competitor_name                     VARCHAR(100)    COLLATE 'en-ci' COMMENT 'Competitor name;
            CBX: CTM_CODELIST.CUST_TEXT1 (code list ''LIDL_COMPET'')',
   competitor_short_name               VARCHAR(100)    COMMENT 'abbreveated Competitor name;
            CBX: CNT_CODELIST.NAME (code list ''LIDL_COMPET'')',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_COMPETITOR PRIMARY KEY (competitor_sid) NOT ENFORCED 
)  COMMENT = 'list of retail companies regarded as competitors
             CBX: Codelist LIDL_COMPET';