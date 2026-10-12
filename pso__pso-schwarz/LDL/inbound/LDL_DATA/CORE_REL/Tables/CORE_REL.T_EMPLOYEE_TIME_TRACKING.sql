/* --------------------------------------------------------------------------------
   DDL for table: t_employee_time_tracking
   generated from Powerdesigner on Dienstag, 29. Oktober 2024 11:20:16
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_EMPLOYEE_TIME_TRACKING (
   int_org_sid                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier (surrogate key) for the internal organization to which the time booking is accrued.',
   emp_hash                            VARCHAR(32)     NOT NULL COMMENT 'The encrypted employee number.',
   bus_dt                              DATE            NOT NULL COMMENT 'The business date to which the time record relates.',
   emp_tm_tracking_nr                  NUMBER(38, 0)   NOT NULL COMMENT 'A number identifying the time booking record in the operational system.',
   emp_tm_tracking_type_cd             VARCHAR(20)     NOT NULL COMMENT 'The code identifying the subtype discriminator for administrative events.',
   emp_tm_tracking_method_cd           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how employees track their time. Time records can be recorded by a terminal or can be entered manually.',
   emp_tm_tracking_status_type_cd      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the lifecycle status for employee time tracking records. A record may be active or cancelled.',
   emp_tm_event_type_cd                VARCHAR(20)     COMMENT 'The code identifying the kind time recording event which is booked for an employee. This includes start of work, end of work, start of break and end of break.',
   tm_tracking_tmsp                    TIMESTAMP_TZ(9) COMMENT 'The point in time when the time tracking record was created.',
   emp_tm_period_type_sid              NUMBER(38, 0)   COMMENT 'The unique identifier (surrogate key) for the type of time which is booked for an employee, e.g. work time, holidays, training, etc.',
   period_start_tmsp                   TIMESTAMP_TZ(9) COMMENT 'The start timestamp of the time period which is tracked.',
   period_end_tmsp                     TIMESTAMP_TZ(9) COMMENT 'The end timestamp of the time period which is tracked.',
   hr_cnt                              NUMBER(38, 2)   COMMENT 'The number of hours which are booked. This time does not include breaks',
   break_min_cnt                       NUMBER(38, 0)   COMMENT 'Break time in minutes.',
   booking_dt                          DATE            COMMENT 'The date when the time booking was recorded in the operational system.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_EMPLOYEE_TIME_TRACKING PRIMARY KEY (int_org_sid, emp_hash, bus_dt, emp_tm_tracking_nr) NOT ENFORCED
 )  COMMENT= 'Employees track their work times, as well as their absences and other activities, such as training.';
