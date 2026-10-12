/* --------------------------------------------------------------------------------
   DDL for table: t_nfpo_range_selection_hist
   generated from Powerdesigner on Dienstag, 13. Mai 2025 10:17:28
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_NFPO_RANGE_SELECTION_HIST DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_range_sel_sid                  NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO RANGE SELECTION.
            CBX: CNT_PROGRAM.REF_NO
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.MDM_RANGE_SEL_SID',
   nfpo_range_sel_version_nr           NUMBER(38,0)     NOT NULL COMMENT 'Technical version of the NFPO range selection in the source system.
            CBX: CNT_PROGRAM.VERSION
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CBX_PROG_VERSION_NR',
   nfpo_range_sel_status_cd            VARCHAR(100)     COMMENT 'Technical status of the NFPO range selection in the source system (active, inactive, cancelled).
            CBX: CNT_PROGRAM.DOC_STATUS
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CBX_PROG_DOC_STATUS',
   nfpo_range_sel_change_tmsp          TIMESTAMP_NTZ(9) NOT NULL COMMENT 'Change timestamp of NFPO range selection record in the source system.
            CBX: CNT_PROGRAM.UPDATED_ON
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CBX_PROG_CHANGE_TMSP',
   active_fg                           BOOLEAN          COMMENT 'Flag to mark the currently active range selection. Only one logical range selection can be active.
            CBX: CTM_PROGRAM.CUST_CODELIST5
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.RANGE_SELECTION_ACTIVE_FG',
   nfpo_range_sel_cal_month            NUMBER(38,0)     COMMENT 'Range selection month.
            CBX: CNT_PROGRAM.YEAR, PERIOD
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_MONTH_RANGE_SELECTION',
   nfpo_range_sel_end_dt               DATE             COMMENT 'End date of the range selection.
            CBX: CNT_PROGRAM.END_DATE
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.RANGE_SELECTION_END_DT',
   nfpo_range_sel_deliv_from_cal_week  NUMBER(38,0)     COMMENT 'Range selection deliver-from calendar week.
            CBX: CTM_PROGRAM.CUST_CODELIST1
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_DELIVER_FROM',
   nfpo_range_sel_deliv_to_cal_week    NUMBER(38,0)     COMMENT 'Range selection deliver-to calendar week.
            CBX: CTM_PROGRAM.CUST_CODELIST2
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_DELIVER_TO',
   nfpo_range_sel_adv_from_cal_week    NUMBER(38,0)     COMMENT 'Range selection advertise-from calendar week.
            CBX: CTM_PROGRAM.CUST_CODELIST3
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_ADVERTISE_FROM',
   nfpo_range_sel_adv_to_cal_week      NUMBER(38,0)     COMMENT 'Range selection advertise-to calendar week.
            CBX: CTM_PROGRAM.CUST_CODELIST4
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_ADVERTISE_TO',
   dwh_deleted_fg                      BOOLEAN          NOT NULL COMMENT 'If deleted_fg = 1, it means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to.
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.DELETED_FG',
   dwh_valid_from_tmsp                 TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Beginning of the validity interval of the record, oldest record of the history starts with 1900-01-01 00:00:00 (minus infinity).
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.DWH_VALID_FROM',
   dwh_valid_to_tmsp                   TIMESTAMP_LTZ(9) NOT NULL COMMENT 'End of the validity interval of the record, newest record of the history ends with 9999-12-30 23:59:59 (plus infinity).
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.DWH_VALID_TO',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the initial insertion of the data record into the DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last change to the data record in the DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_NFPO_RANGE_SELECTION_HIST PRIMARY KEY (nfpo_range_sel_sid, dwh_valid_from_tmsp) NOT ENFORCED 
)  COMMENT = 'NFPO quarterly waves to define and order items.
             CBX: CNT_PROGRAM
             LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST';
