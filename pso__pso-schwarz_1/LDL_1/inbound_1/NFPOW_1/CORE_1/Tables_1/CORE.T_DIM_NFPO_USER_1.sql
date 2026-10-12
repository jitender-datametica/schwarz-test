/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_user_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_USER_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_user_sid                       NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key to represent the NFPO source system user.
            CBX: CNT_ITEM.LDL_BUYER_REF, LDL_SE_REF, LDL_RESPONSIBLE_PERSON_REF, LDL_CONTRACT_APPROVAL_EMP_REF
            LDL: P_LEW_CORE.T_MDM_ITEM_BUYER_ROLE_HIST.BUYER_SID',
   nfpo_user_acct_name                 VARCHAR(100)     NOT NULL COMMENT 'NFPO source system user reference.
            CBX: CNT_USER.REF_NO
            LDL: P_LEW_CORE.T_MDM_BUYER.SRC_USER_DOC_REF',
   nfpo_user_first_name                VARCHAR(100)     COMMENT 'Forename of the NFPO source system user.
            CBX: CNT_USER.FIRST_NAME
            LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_FORENAME',
   nfpo_user_last_name                 VARCHAR(100)     COMMENT 'Surname of the NFPO source system user.
            CBX: CNT_USER.LAST_NAME
            LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_SURNAME',
   nfpo_user_abbr_name                 VARCHAR(100)     COMMENT 'Buyer code (derived from name) of the NFPO source system user if he is a responsible buyer, common across systems.
            CBX: CNT_USER.SHORT_CODE
            LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_CD',
   nfpo_user_mgr_abbr_name             VARCHAR(100)     COMMENT 'Coded name of the manager of the NFPO source system user.
            CBX: CTM_USER.CUST_TEXT2
            LDL: P_LEW_CORE.T_MDM_BUYER.BUYER_MANAGER_ABBR_NAME',
   is_ekl_user_fg                      BOOLEAN          COMMENT 'Iindicates whether this user acts as EKL for any item_1',
   is_se_user_fg                       BOOLEAN          COMMENT 'Iindicates whether this user acts as SE for any item_1',
   is_theme_resp_user_fg               BOOLEAN          COMMENT 'Iindicates whether this user acts as theme responsible user for any advertise theme',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_BUYER.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_USER PRIMARY KEY (nfpo_user_sid) NOT ENFORCED 
)  COMMENT = 'Comment 2Do';

