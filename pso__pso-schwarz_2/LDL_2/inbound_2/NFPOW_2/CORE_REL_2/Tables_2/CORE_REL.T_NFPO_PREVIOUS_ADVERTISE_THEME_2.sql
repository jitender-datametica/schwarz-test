/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_previous_advertise_theme_2
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 13:10:42
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_PREVIOUS_ADVERTISE_THEME_2 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_adv_theme_sid                  NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ADVERTISING THEME.
            CBX: CNT_PROJECT.REF_NO
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_AD_THEME_SID',
   nfpo_prev_adv_theme_lvl_nr          NUMBER(38,0)     NOT NULL,
   nfpo_prev_adv_theme_sid             NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ADVERTISING THEME.
            CBX: CNT_PROJECT.REF_NO
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_AD_THEME_SID',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_ITEM.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_PREVIOUS_ADVERTISE_THEME PRIMARY KEY (nfpo_adv_theme_sid, nfpo_prev_adv_theme_lvl_nr) NOT ENFORCED 
)  COMMENT = 'NFPO previous (predecessor) advertise themes, all levels available.';
