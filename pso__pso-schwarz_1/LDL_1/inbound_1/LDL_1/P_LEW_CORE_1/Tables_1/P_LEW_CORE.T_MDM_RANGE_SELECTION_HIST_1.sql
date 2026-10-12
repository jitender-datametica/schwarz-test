CREATE TABLE P_LEW_CORE.T_MDM_RANGE_SELECTION_HIST_1 (
   client_id                           NUMBER(38,0)    NOT NULL COMMENT 'technical column required by the used ETL framework
            static 7 for all rows',
   mdm_range_sel_sid                   NUMBER(38,0)    NOT NULL COMMENT 'surrogate key NFPO range selection
            CBX: CNT_PROGRAM.REF_NO',
   cbx_prog_version_nr                 NUMBER(38,0)    NOT NULL COMMENT 'technical version of the NFPO range selection in the source system
            CBX: CNT_PROGRAM.VERSION',
   cbx_prog_doc_status                 VARCHAR(100)    COLLATE 'en-ci' COMMENT 'technical status_1 of the NFPO range selection in the source system (active,inactive,cancelled)
            CBX: CNT_PROGRAM.DOC_STATUS',
   cbx_prog_change_tmsp                TIMESTAMP_NTZ(9) NOT NULL COMMENT 'change timestamp of NFPO range selection record in the source system
            CBX: CNT_PROGRAM.UPDATED_ON',
   range_selection_active_fg           NUMBER(38,0)    COMMENT 'flag to mark the currently active range selection. Only one logical range selection can be active.
            CBX: CTM_PROGRAM.CUST_CODELIST5',
   cy_month_range_selection            NUMBER(38,0)    COMMENT 'range selection month
            CBX: CNT_PROGRAM.YEAR, PERIOD',
   range_selection_end_dt              DATE            COMMENT 'end date of the range selection
            CBX: CNT_PROGRAM.END_DATE',
   cy_week_range_deliver_from          NUMBER(38,0)    COMMENT 'range deliver from calendar_1 week
            CBX: CTM_PROGRAM.CUST_CODELIST1',
   cy_week_range_deliver_to            NUMBER(38,0)    COMMENT 'range deliver to calendar_1 week
            CBX: CTM_PROGRAM.CUST_CODELIST2',
   cy_week_range_advertise_from        NUMBER(38,0)    COMMENT 'range advertise from calendar_1 week
            CBX: CTM_PROGRAM.CUST_CODELIST3',
   cy_week_range_advertise_to          NUMBER(38,0)    COMMENT 'range advertise to calendar_1 week
            CBX: CTM_PROGRAM.CUST_CODELIST4',
   deleted_fg                          NUMBER(38,0)    NOT NULL COMMENT 'deleted_fg=1 means that the record is not available in the source system or a delete information is set in the source system between dwh_valid_from and dwh_valid_to ',
   dwh_valid_from                      DATE            NOT NULL COMMENT 'begin of the validity_1 interval of the record, oldest record of the history starts with 1900-01-01 (minus infinity)',
   dwh_valid_to                        DATE            NOT NULL COMMENT 'end of the validity_1 interval of the record, newest record of the history ends with 9999-12-30 (plus infinity)',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'identifier of the last run which inserted or updated the record',
   dwh_created                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'creation timestamp of the record in the DWH',
   dwh_updated                         TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp of the last update of the record in the DWH',   
   CONSTRAINT PK_T_MDM_RANGE_SELECTION_HIST PRIMARY KEY (mdm_range_sel_sid, dwh_valid_from) NOT ENFORCED 
)  COMMENT = 'NFPO quarterly waves to define and order items
             CBX: CNT_PROGRAM';