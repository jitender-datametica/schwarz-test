CREATE TABLE CORE.t_fact_rvm_maintenance_overdue_2 (
   rvm_sid              NUMBER     NOT NULL COMMENT 'The unique identifier (surrogate key) for the despotie machine which is located in a store',
   cal_dt               DATE       NOT NULL COMMENT 'The day represented as a calendar_2 date of the form YYYY-MM_2-DD. YYYY is the calendar_2 year, MM_2 (between 1 and 12) the calendar_2 month and DD the day of the calendar_2 month (between 1 and 31). ',
   prev_action_dt       DATE       NOT NULL COMMENT 'The date when preventive maintenance was carried out on the deposit machine.',
   due_dt_from          DATE       NOT NULL COMMENT 'the start of the maintenance due date ',
   due_dt_to            DATE       NOT NULL COMMENT 'the end of the maintenance due date ',
   overdue_day_cnt      NUMBER     NOT NULL COMMENT 'The count of days the maintenance is overdue',
   overdue_cnt          NUMBER     NOT NULL COMMENT 'The count of rvms with maintenance overdue as constant 1',
   dwh_created_tmsp     TIMESTAMP_LTZ NOT NULL COMMENT 'The point in time when this record was inserted into the table.',
   dwh_updated_tmsp     TIMESTAMP_LTZ NOT NULL COMMENT 'The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)',
   CONSTRAINT PK_T_FACT_RVM_MAINTENANCE_OVERDUE PRIMARY KEY (rvm_sid, cal_dt) NOT ENFORCED
) COMMENT = 'Transactional facts capturing the maintenance overdue of RVMs';
