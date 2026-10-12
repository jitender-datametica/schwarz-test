/* --------------------------------------------------------------------------------
   DDL for table: t_ldl_calendar_week_1
   generated from Powerdesigner on Dienstag, 24. Oktober 2023 10:42:39
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_LDL_CALENDAR_WEEK_1 DATA_RETENTION_TIME_IN_DAYS = 2 (
   cal_week                            NUMBER(38,0)     NOT NULL,
   ldl_prev_1y_cal_week                NUMBER(38,0),
   ldl_cal_week_offset                 NUMBER(38,0),
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der Ersteinfügung des Datensatzes ins DWH.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Zeitstempel der letzten Änderung des Datensatzes im DWH.',
   dwh_src_tmsp                        TIMESTAMP_LTZ(9) NOT NULL COMMENT 'Timestamp of source extraction.',   
   CONSTRAINT PK_T_LDL_CALENDAR_WEEK PRIMARY KEY (cal_week) NOT ENFORCED 
)  COMMENT = 'Comment 2Do
             LDL: P_LEW_CORE.T_CAL_WEEK_1';
