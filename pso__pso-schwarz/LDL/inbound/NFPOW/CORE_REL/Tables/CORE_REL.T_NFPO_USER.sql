CREATE TABLE CORE_REL.T_NFPO_USER DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_user_sid                       NUMBER(38,0)     NOT NULL,
   nfpo_user_acct_name                 VARCHAR(100)     NOT NULL,
   nfpo_user_version_nr                NUMBER(38,0)     NOT NULL,
   nfpo_user_abbr_name                 VARCHAR(100),
   nfpo_user_first_name                VARCHAR(100),
   nfpo_user_last_name                 VARCHAR(100),
   nfpo_user_email_addr_txt            VARCHAR(1000),
   sso_name                            VARCHAR(100)     COLLATE 'en-ci',
   nfpo_user_note_txt                  VARCHAR(1000),
   nfpo_user_mgr_abbr_name             VARCHAR(100),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_USER PRIMARY KEY (nfpo_user_sid) NOT ENFORCED 
)  COMMENT = 'NFPO user, mainly covering the role buyer
             CBX: CNT_USER, CTM_USER';
