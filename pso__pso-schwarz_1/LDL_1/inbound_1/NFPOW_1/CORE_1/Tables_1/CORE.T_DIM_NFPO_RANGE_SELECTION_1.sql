/* --------------------------------------------------------------------------------
   DDL for table: t_dim_nfpo_range_selection_1
   generated from Powerdesigner on Donnerstag, 7. Dezember 2023 13:49:26
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_DIM_NFPO_RANGE_SELECTION_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   nfpo_range_sel_sid                  NUMBER(38,0)     NOT NULL COMMENT 'Surrogate Key NFPO RANGE SELECTION.
            CBX: CNT_PROGRAM.REF_NO
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.MDM_RANGE_SEL_SID',
   nfpo_range_sel_nr                   VARCHAR(100)     NOT NULL COMMENT 'Identifier of the NFPO range selection.
            CBX: CNT_PROGRAM.REF_NO
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.SRC_PROG_DOC_REF',
   nfpo_range_plan_nr                  VARCHAR(100)     COMMENT 'Logical identifier of the NFPO range selection: sometimes technically 2 records for a logical range selection exist, but only one is active.
            CBX: CNT_PROGRAM.PROGRAM_NO
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.RANGE_PLAN_CD',
   nfpo_range_sel_cal_month            NUMBER(38,0)     COMMENT 'Range selection month.
            CBX: CNT_PROGRAM.YEAR, PERIOD
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_MONTH_RANGE_SELECTION',
   nfpo_range_sel_cal_year             NUMBER(38,0),
   nfpo_range_sel_deliv_from_cal_week  NUMBER(38,0)     COMMENT 'Range selection deliver-from calendar_1 week.
            CBX: CTM_PROGRAM.CUST_CODELIST1
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_DELIVER_FROM',
   nfpo_range_sel_deliv_to_cal_week    NUMBER(38,0)     COMMENT 'Range selection deliver-to calendar_1 week.
            CBX: CTM_PROGRAM.CUST_CODELIST2
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_DELIVER_TO',
   nfpo_range_sel_adv_from_cal_week    NUMBER(38,0)     COMMENT 'Range selection advertise-from calendar_1 week.
            CBX: CTM_PROGRAM.CUST_CODELIST3
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_ADVERTISE_FROM',
   nfpo_range_sel_adv_to_cal_week      NUMBER(38,0)     COMMENT 'Range selection advertise-to calendar_1 week.
            CBX: CTM_PROGRAM.CUST_CODELIST4
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST.CY_WEEK_RANGE_ADVERTISE_TO',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Creation timestamp of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.DWH_CREATED',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of the last update of the record in the DWH.
            LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION.DWH_UPDATED',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_DIM_NFPO_RANGE_SELECTION PRIMARY KEY (nfpo_range_sel_sid) NOT ENFORCED 
)  COMMENT = 'NFPO quarterly waves to define and order items.
             CBX: CNT_PROGRAM
             LDL: P_LEW_CORE.T_MDM_RANGE_SELECTION_1';

