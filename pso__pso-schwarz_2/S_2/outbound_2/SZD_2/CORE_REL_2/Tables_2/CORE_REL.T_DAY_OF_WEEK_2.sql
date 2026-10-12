/* --------------------------------------------------------------------------------
   DDL for table: T_DAY_OF_WEEK_2
   generated from Powerdesigner on Dienstag, 16. April 2024 15:34:12
*/ --------------------------------------------------------------------------------


CREATE TABLE IF NOT EXISTS szd_core_rel.t_day_of_week_2 (
day_of_week_id BIGNUMERIC(38,0) NOT NULL
OPTIONS(description='The day of the week as a number using the convention Mon=1 ... Sun=7. I.e. the sequence of the weekday within the week starting on a Monday.'),
lang_cd STRING(2) NOT NULL OPTIONS(description='The code identifying the language.'),
day_of_week_short_name STRING(250) NOT NULL OPTIONS(description='The abbreviation for the weekday, e.g. Mon'),
day_of_week_name STRING(100) NOT NULL OPTIONS(description='The full name for the weekday, e.g. Monday.'),
dwh_created_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was inserted into the table.'),
dwh_updated_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The point in time when this record was last modified. (In case the record has not been modified since its creation, dwh_updated is identical to dwh_created.)'),
dwh_src_file_name STRING(500)
OPTIONS(description='Contains the name(s) of the input file(s) that delivered the record. It can be either the full path of the BYTES storage or the shortened file path'),
dwh_src_1_tmsp TIMESTAMP NOT NULL
OPTIONS(description='The extraction timestamp of the record from the source'),
PRIMARY KEY (day_of_week_id, lang_cd) NOT ENFORCED
)
OPTIONS(description='Minor Entity - This minor entity defines the seven days of the week, i.e. Monday, Tuesday, Wednesday, ...');