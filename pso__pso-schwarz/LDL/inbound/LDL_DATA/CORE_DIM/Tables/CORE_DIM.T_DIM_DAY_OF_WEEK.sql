CREATE TABLE core_dim.T_DIM_DAY_OF_WEEK (
   day_of_week                         NUMBER(38, 0)   NOT NULL COMMENT 'The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.',
   day_of_week_short_name              VARCHAR(100)    NOT NULL COMMENT 'The abbreviation for the weekday in group language, i.e. in German, ',
   day_of_week_short_name_de           VARCHAR(100)    COMMENT 'The abbreviation for the weekday in German, ',
   day_of_week_short_name_en           VARCHAR(100)    COMMENT 'The abbreviation for the weekday in English',
   day_of_week_name                    VARCHAR(100)    NOT NULL COMMENT 'The full name for day of the week in group language, i.e. in German.',
   day_of_week_name_de                 VARCHAR(100)    COMMENT 'The full name for day of the week in German.',
   day_of_week_name_en                 VARCHAR(100)    COMMENT 'The full name for day of the week in English',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_DIM_DAY_OF_WEEK PRIMARY KEY (day_of_week) NOT ENFORCED
 )  COMMENT= 'This minor dimension defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...';
