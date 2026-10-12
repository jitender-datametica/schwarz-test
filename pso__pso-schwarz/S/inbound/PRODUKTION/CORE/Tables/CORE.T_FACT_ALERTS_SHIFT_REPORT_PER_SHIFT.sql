--==============================================================
-- DBMS name:      Snowflake
-- Created on:     17.03.2021 15:26:08
--==============================================================


--==============================================================
-- Table: T_FACT_ALERTS_SHIFT_REPORT_PER_SHIFT
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_ALERTS_SHIFT_REPORT_PER_SHIFT
   generated from Powerdesigner on Donnerstag, 25. März 2021 11:11:50
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_ALERTS_SHIFT_REPORT_PER_SHIFT (
   ALERTS_DAY_SHIFT_ID                 NUMBER          NOT NULL COMMENT 'The unique identifier for a specific shift.',
   ALERTS_SHIFT_REPORT_AGREEMENT_TXT   VARCHAR()       COMMENT 'A textual field for input our of the MSTR transaction service regarding agreements in a specific shift.',
   ALERTS_SHIFT_REPORT_NEXT_SHIFT_TXT  VARCHAR()       COMMENT 'A textual field for input our of the MSTR transaction service regarding topics for the next shift.',
   ALERTS_SHIFT_REPORT_OUT_OF_ORDER_TXT VARCHAR()       COMMENT 'A textual field for input our of the MSTR transaction service regarding production unit components which are out of order in a specific shift.',
   ALERTS_SHIFT_REPORT_SECURITY_ISSUES VARCHAR()       COMMENT 'The unique identifier for the alarm priorities (also containing inactive components)',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Fact table which captures the transactional input from Microstrategy frontend regarind the shift reports per shift.';

