CREATE TABLE core_rel.T_CAL_CUM_CALENDAR_HALF_YEAR_TO_MONTH_1 (
   cal_month                           NUMBER(38, 0)   NOT NULL COMMENT 'The calendar_1 month for which the calendar_1-half-year-to-month interval is defined.',
   incl_cal_month                      NUMBER(38, 0)   NOT NULL COMMENT 'The calendar_1 month that needs to be included in the calendar_1-half-year-to-month interval.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CAL_CUM_CALENDAR_HALF_YEAR_TO_MONTH PRIMARY KEY (cal_month, incl_cal_month) NOT ENFORCED
 )  COMMENT= 'This table relates a month to all months that form the calendar_1-half-year-to-month interval of this month. E.g. for May 2019 this is January, February, March, April and May 2019.';
