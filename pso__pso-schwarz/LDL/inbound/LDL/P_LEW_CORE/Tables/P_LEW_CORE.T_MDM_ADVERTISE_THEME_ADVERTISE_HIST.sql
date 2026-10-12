CREATE TABLE P_LEW_CORE.T_MDM_ADVERTISE_THEME_ADVERTISE_HIST (
  client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_ad_theme_sid                    NUMBER(38,0)    NOT NULL COMMENT 'foreign key NFPO advertising theme
            CBX: CNT_PROJECT.REF_NO',
   item_adv_seq                        NUMBER(38,0)    NOT NULL COMMENT 'sequence of advertising weeks derived from source column name',
   cy_week_theme_adv                   NUMBER(38,0)    COMMENT 'planned advertising weeks for NFPO advertising themes
            CBX: CTM_PROJECT.CUST_CODELIST2_NAME, CUST_CODELIST7_NAME, CUST_CODELIST10_NAME',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',

   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ADVERTISE_THEME_ADVERTISE_HIST PRIMARY KEY (mdm_ad_theme_sid, item_adv_seq, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'planned advertising weeks for NFPO advertising themes
             CBX: CTM_PROJECT';