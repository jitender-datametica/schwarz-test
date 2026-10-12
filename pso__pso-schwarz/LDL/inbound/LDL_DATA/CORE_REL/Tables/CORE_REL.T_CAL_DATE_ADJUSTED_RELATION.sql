CREATE TABLE core_rel.T_CAL_DATE_ADJUSTED_RELATION (
   cal_dt                              DATE            NOT NULL COMMENT 'The day being mapped back to previous (business) years, represented as a calendar date of the form YYYY-MM-DD. YYYY is the calendar year, MM (between 1 and 12) the calendar month and DD the day of the calendar month (between 1 and 31). ',
   bus_year_diff                       NUMBER(38, 0)   NOT NULL COMMENT 'The difference in years between the current business year and the business year we are mapping back to. I.e. 1 for the previous year, 2 for 2 years ago etc.',
   incl_cal_dt                         DATE            NOT NULL COMMENT 'The date that needs to be included for the previous year''s equivalent of the current day being mapped.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CAL_DATE_ADJUSTED_RELATION PRIMARY KEY (cal_dt, bus_year_diff, incl_cal_dt) NOT ENFORCED
 )  COMMENT= 'This table maps a calendar date to its equivalent day(s) of previous business years maintaining the same weekday. Mappings for days at the end of the business year are adjusted, so that all mapped days belong to the same business year. In case of leap years this is a many-to-many relation.';
