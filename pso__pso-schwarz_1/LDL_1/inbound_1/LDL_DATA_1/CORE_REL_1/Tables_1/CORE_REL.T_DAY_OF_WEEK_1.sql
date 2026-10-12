CREATE TABLE core_rel.T_DAY_OF_WEEK_1 (
   day_of_week                         NUMBER(38,0)    NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
   lang_cd                             VARCHAR(2)      NOT NULL COMMENT 'The code identifying the language.',
   day_of_week_short_name              VARCHAR(100)    NOT NULL COMMENT 'The abbreviation for the weekday, e.g. Mon',
   day_of_week_name                    VARCHAR(100)    NOT NULL COMMENT 'The full name for the weekday, e.g. Monday.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38,0)    NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DAY_OF_WEEK PRIMARY KEY (day_of_week, lang_cd) NOT ENFORCED
 )  COMMENT= 'This minor entity defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...';
