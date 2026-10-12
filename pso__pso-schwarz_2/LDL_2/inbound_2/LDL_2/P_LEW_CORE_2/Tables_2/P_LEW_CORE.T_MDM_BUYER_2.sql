CREATE TABLE P_LEW_CORE.T_MDM_BUYER_2 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   buyer_sid                           NUMBER(38,0)    NOT NULL COMMENT 'surrogate key to represent the NFPO source system user
            CBX: CNT_USER.REF_NO',
   src_user_doc_ref                    VARCHAR(100)     COLLATE 'en-ci' NOT NULL COMMENT 'NFPO source system user reference
            CBX: CNT_USER.REF_NO',
   cbx_user_version_nr                 NUMBER(38,0)    NOT NULL COMMENT 'technical version of the NFPO source system user
            CBX: CNT_USER.VERSION',
   buyer_cd                            VARCHAR(20)     COMMENT 'Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems
            CBX: CNT_USER.SHORT_CODE',
   buyer_forename                      VARCHAR(100)    COLLATE 'en-ci' COMMENT 'forename of the NFPO source system user
            CBX: CNT_USER.FIRST_NAME',
   buyer_surname                       VARCHAR(100)    COLLATE 'en-ci' COMMENT 'surname of the NFPO source system user
            CBX: CNT_USER.LAST_NAME',
   buyer_email                         VARCHAR(100)    COLLATE 'en-ci' COMMENT 'email of the NFPO source system user
            CBX: CNT_USER.EMAIL',
   sso_name                            VARCHAR(100)    COLLATE 'en-ci' COMMENT 'sso_name of the NFPO source system user in the NFPO reporting UI
            CBX: CNT_PROJECT.THEME_OWNER
            ',
   buyer_notes                         VARCHAR(100)    COLLATE 'en-ci' COMMENT 'description or role comment of the NFPO source system user
            CBX: CNT_USER.DESCRIPTION',
   buyer_manager_abbr_name             VARCHAR(100)    COMMENT 'coded name of the manager of the NFPO source system user
            CBX: CTM_USER.CUST_TEXT2
            ',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_BUYER PRIMARY KEY (buyer_sid) NOT ENFORCED 
)  COMMENT = 'NFPO user, mainly covering the role buyer
             CBX: CNT_USER, CTM_USER';