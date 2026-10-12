--==============================================================
-- Table: T_FACT_ALERTS_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: T_FACT_ALERTS_2
   generated from Powerdesigner on Donnerstag, 18. März 2021 15:36:18
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE.T_FACT_ALERTS_2 (
   ALERTS_PRIORITY_ID                  NUMBER          NOT NULL COMMENT 'The unique identifier for the alarm priorities (also containing inactive components)',
   ALERTS_MESSAGE_ID                   NUMBER          NOT NULL COMMENT 'The unique identifier for the alarm message which contains the information about the root cause ',
   ALERTS_TYPE_ID                      NUMBER          NOT NULL COMMENT 'The unique identifiier for the alarm type which can be either manual or system',
   CAL_DT                              DATE            NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   ALERTS_DAY_SHIFT_ID                 NUMBER          NOT NULL COMMENT 'Concatenated ID (YYYYMMDDshiftID) as integer',
   ALERTS_LOCATION_ID                  NUMBER          NOT NULL COMMENT 'The unique identifier for the alarm location_2 on which the alarm occured and where the station is located at.',
   ALERTS_TM                           TIME            NOT NULL COMMENT 'The time represents the alarm time during a day (hh:mm_2:ss)',
   ALERTS_DURATION_DIFF                NUMBER          NOT NULL COMMENT 'Precalculated duration of an alarm calculated the source system. Only populated on the "off" message of an alarm.',
   ALERTS_PRODUCTION_STOP_FG           BOOLEAN         COMMENT 'Flag for an alarm dataset pair, when this particular alarm caused an production stop. Will be filled by MSTR transaction service.',
   ALERTS_DELETED_FG                   BOOLEAN         COMMENT 'Flag for an manual alarm dataset pair, when it has been deleted by an user.',
   DWH_CREATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   DWH_UPDATED_TMSP                    TIMESTAMP_LTZ   NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   DWH_LOAD_ID                         VARCHAR()       NOT NULL COMMENT 'The unique identifier of the batch load that has done the last modification to this record. (This can either be the initial insert, or an update operation at a later point in time.)'
   ,TD_UPDATE 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
   ,TD_INSERT 	TIMESTAMP_LTZ(9) COMMENT 'Technical fields for synchronisation framework. Will be delted after last product migration'
)COMMENT = 'Transactional facts, capturing the system generated alarm messages.';
