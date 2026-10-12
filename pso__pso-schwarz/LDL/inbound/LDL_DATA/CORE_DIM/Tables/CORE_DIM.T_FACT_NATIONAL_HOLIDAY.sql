CREATE TABLE core_dim.T_FACT_NATIONAL_HOLIDAY (
   cal_dt                              DATE            NOT NULL COMMENT 'The day represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
   iso_country_cd                      VARCHAR(2)      NOT NULL COMMENT 'The code identifying the country according to ISO 3166.',
   holiday_name                        VARCHAR(100)    NOT NULL COMMENT 'A name for the holiday in group language, i.e. German.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_FACT_NATIONAL_HOLIDAY PRIMARY KEY (cal_dt, iso_country_cd, holiday_name) NOT ENFORCED
 )  COMMENT= 'Public holidays which are defined on country level. (This relation does not include regional holidays!)';
