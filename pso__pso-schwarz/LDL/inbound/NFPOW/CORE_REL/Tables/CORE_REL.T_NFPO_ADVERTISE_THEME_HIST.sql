/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_advertise_theme_hist
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:16:51
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_ADVERTISE_THEME_HIST DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_adv_theme_sid                  NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO ADVERTISING THEME.
            CBX: CNT_PROJECT.REF_NO
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.MDM_AD_THEME_SID',
   nfpo_adv_theme_version_nr           NUMBER(38,0)     NOT NULL COMMENT 'Technical version of the NFPO adv theme in the source system.
            CBX: CNT_PROJECT.VERSION
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.CBX_PROJ_VERSION_NR',
   nfpo_adv_theme_status_cd            VARCHAR(100)     COMMENT 'Technical status of the NFPO adv theme in the source system (active, inactive, cancelled).
            CBX: CNT_PROJECT.DOC_STATUS
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.CBX_PROJ_DOC_STATUS',
   nfpo_adv_theme_change_tmsp          TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Change timestamp of the NFPO theme in the source system.
            CBX: CNT_PROJECT.UPDATED_ON
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.CBX_PROJ_CHANGE_TMSP',
   nfpo_prev_adv_theme_sid             NUMBER(38,0)     COMMENT 'Foreign Key NFPO ADVERTISING THEME for the advertising theme which is referenced as preceeding advertise theme that covered the same or a similar topic and same or similar items.
            CBX: CTM_PROJECT.CUST_TEXT2
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME.MDM_PREV_AD_THEME_SID',
   nfpo_range_sel_sid                  NUMBER(38,0)     NOT NULL COMMENT 'Foreign Key NFPO RANGE SELECTION.
            CBX: CNT_PROJECT.PROGRAM_REF
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.MDM_RANGE_SEL_SID',
   nfpo_adv_theme_approval_status_cd   VARCHAR(100)     COMMENT 'Adv theme approval status.
            CBX: CNT_PROJECT.EDITING_STATUS
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.AD_THEME_APPROVAL_STATUS',
   nfpo_adv_theme_workflow_status_cd   VARCHAR(100)     COMMENT 'NFPO adv theme workflow status.
            CBX: CNT_PROJECT.STATUS (New --> New; customStatus01 --> Selection)
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.AD_THEME_WORKFLOW_STATUS',
   nfpo_adv_theme_sell_from_day_id     NUMBER(38,0)     COMMENT 'Day of the advertising week on which sales start. Usually there are 2 days in an advertising week where actions start, for example Monday and Thursday. This number indicates whether the first or the second is used for the theme.
            CBX: CTM_PROJECT.CUST_CODELIST3
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.AD_THEME_SELL_FROM_DAY',
   nfpo_adv_theme_sell_from_dt         DATE             COMMENT 'Date on which sales start, generally in the advertising week of this theme.
            CBX: CTM_PROJECT.CUST_DATE1
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.AD_THEME_SELL_FROM_DT',
   nfpo_resp_user_sid                  NUMBER(38,0)     COMMENT 'Responsible person for the advertising theme.
            CBX: CNT_PROJECT.THEME_OWNER
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.AD_THEME_RESP_BUYER_SID',
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.DELETED_FG',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Beginning of the validity interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.DWH_VALID_FROM',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).
            LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST.DWH_VALID_TO',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_ADVERTISE_THEME_HIST PRIMARY KEY (nfpo_adv_theme_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'Historized attributes of NFPO advertising themes.
             CBX: CNT_PROJECT, CTM_PROJECT
             LDL: P_LEW_CORE.T_MDM_ADVERTISE_THEME_HIST';
