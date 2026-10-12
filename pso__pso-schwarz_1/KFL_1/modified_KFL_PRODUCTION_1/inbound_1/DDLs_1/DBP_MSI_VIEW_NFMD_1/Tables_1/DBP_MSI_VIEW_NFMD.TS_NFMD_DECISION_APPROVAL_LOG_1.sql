--==============================================================
-- Table: ts_nfmd_decision_approval_log_1
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: ts_nfmd_decision_approval_log_1
   generated from Powerdesigner on Montag, 4. Juli 2022 13:42:46
*/ --------------------------------------------------------------------------------

CREATE TABLE DBP_MSI_VIEW_NFMD.TS_NFMD_DECISION_APPROVAL_LOG_1 (
   mandant_id                          INTEGER    NOT NULL COMMENT 'Mandant_1 im DWH',
   dwh_created_tmsp                    TIMESTAMP_NTZ(9) NOT NULL COMMENT 'timestamp when the record was created',
   kjwo_ww                             INTEGER    COMMENT 'Calendar_1 year-week when the promotion campaign started. Format JJJJWW',
   user_id                             VARCHAR(255)    COMMENT 'AD name of the user who created the record',
   TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration',
   CONSTRAINT PK_TS_NFMD_DECISION_APPROVAL_LOG PRIMARY KEY (mandant_id, dwh_created_tmsp) NOT ENFORCED
)  COMMENT = 'Log table for approval of the price reduction decision per calendar_1 week, client - populated by Frontend';
