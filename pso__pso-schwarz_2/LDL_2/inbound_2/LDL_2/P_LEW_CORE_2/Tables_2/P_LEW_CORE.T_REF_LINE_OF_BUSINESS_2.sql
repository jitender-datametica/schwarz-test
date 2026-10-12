CREATE TABLE P_LEW_CORE.T_REF_LINE_OF_BUSINESS_2 (
   lob_cd                              VARCHAR(5)      COLLATE 'en-ci' NOT NULL COMMENT 'line of business code ''LDL'',''KFL'', distinguishes between Lidl and Kaufland related clients',
   lob_name                            VARCHAR(100)    NOT NULL COMMENT 'name of the line of business, ''Lidl'' or ''Kaufland''',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_REF_LINE_OF_BUSINESS PRIMARY KEY (lob_cd) NOT ENFORCED 
)  COMMENT = 'line of business
             distinguishes between Lidl and Kaufland related clients';

