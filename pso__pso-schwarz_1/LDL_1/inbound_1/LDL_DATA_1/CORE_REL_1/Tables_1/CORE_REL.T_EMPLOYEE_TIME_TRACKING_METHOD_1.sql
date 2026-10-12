/* --------------------------------------------------------------------------------
   DDL for table: t_employee_time_tracking_method_1
   generated from Powerdesigner on Dienstag, 29. Oktober 2024 11:17:40
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_EMPLOYEE_TIME_TRACKING_METHOD_1 (
   emp_tm_tracking_method_cd           VARCHAR(20)     NOT NULL COMMENT 'The code identifying the way, how employees track their time. Time records can be recorded by a terminal or can be entered manually.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   emp_tm_tracking_method_descr        VARCHAR(250)    NOT NULL COMMENT 'A textual description for the way, how employees track their time. Time records can be recorded by a terminal or can be entered manually.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_EMPLOYEE_TIME_TRACKING_METHOD PRIMARY KEY (emp_tm_tracking_method_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the ways, how employees track their time. Time records can be recorded by a terminal or can be entered manually.';
