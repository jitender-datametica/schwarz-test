CREATE TABLE CORE_REL.T_METRIC_TYPE_1 (
   metric_type_cd                      VARCHAR(20)     NOT NULL COMMENT 'The code identifying the type of metric which is collected for internal companies.',
   metric_type_descr                   VARCHAR(250)    NOT NULL COMMENT 'A textual description for the type of metric.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   CONSTRAINT PK_T_METRIC_TYPE PRIMARY KEY (metric_type_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the kind of measure which is collected for internal companies.';
