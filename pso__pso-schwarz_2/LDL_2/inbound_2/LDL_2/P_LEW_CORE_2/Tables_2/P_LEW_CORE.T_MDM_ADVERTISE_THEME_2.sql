CREATE TABLE P_LEW_CORE.T_MDM_ADVERTISE_THEME_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_ad_theme_sid                    NUMBER(38,0)    NOT NULL COMMENT 'surrogate key NFPO advertising theme
            CBX: CNT_PROJECT.REF_NO',
   src_proj_doc_ref                    VARCHAR(20)     COLLATE 'en-ci' NOT NULL COMMENT 'NFPO ad theme reference
            CBX: CNT_PROJECT.REF_NO',
   ad_theme_name                       VARCHAR(100)    COMMENT 'NFPO Theme name;
            CBX: CNT_PROJECT.SHORT_DESC',
   ad_theme_cd                         VARCHAR(20)     COLLATE 'en-ci' COMMENT 'NFPO Theme number (derived from advertising week): WW.N;
            CBX: CNT_PROJECT.PROJECT_NO',
   ad_theme_id                         NUMBER(38,0)    COMMENT 'NFPO Theme ID (20-digit code);
            CBX: CTM_PROJECT.CUST_TEXT5',
   busyear_ad_theme                    NUMBER(38,0)    COMMENT 'FK busyear: Financial year;
            CBX: CNT_PROJECT.FINANCIAL_YEAR',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_ADVERTISE_THEME PRIMARY KEY (mdm_ad_theme_sid) NOT ENFORCED 
)  COMMENT = 'NFPO advertising themes
             CBX: CNT_PROJECT';