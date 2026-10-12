/* --------------------------------------------------------------------------------
   DDL for table: t_employee_time_tracking_type_2
   generated from Powerdesigner on Dienstag, 29. Oktober 2024 11:14:02
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_EMPLOYEE_TIME_TRACKING_TYPE_2 (
   emp_tm_tracking_type_cd             VARCHAR(20)     NOT NULL COMMENT 'The code identifying the subtype discriminator for employee_2 time tracking events.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   emp_tm_tracking_type_descr          VARCHAR(250)    NOT NULL COMMENT 'A textual description for the subtype discriminator for employee_2 time tracking events.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_EMPLOYEE_TIME_TRACKING_TYPE PRIMARY KEY (emp_tm_tracking_type_cd, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the subtye discriminators for employee_2 time tracking events. It distinguishes between timestamp based and period based time tracking ';
