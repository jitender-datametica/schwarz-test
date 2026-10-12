CREATE TABLE core_rel.T_CAL_CUM_CALENDAR_YEAR_TO_QUARTER_2 (
   cal_year_qtr                        NUMBER(38, 0)   NOT NULL COMMENT 'The calendar_2 year quarter for which the calendar_2-year-to-quarter interval is defined.',
   incl_cal_year_qtr                   NUMBER(38, 0)   NOT NULL COMMENT 'The calendar_2 year quarter that needs to be included in the calendar_2-year-to-quarter interval.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created or last updated.',
   dwh_load_id                         NUMBER(38, 0)   NOT NULL COMMENT 'The unique identifier of the batch load which has done the last update to this record. (Closing a record in history without updating any payload columns does not trigger an update of the dwh_load_id.)',
   dwh_node_cd                         VARCHAR(20)     NOT NULL COMMENT 'The code for the source system (or slice of source system) from which this record was loaded.',
   CONSTRAINT PK_T_CAL_CUM_CALENDAR_YEAR_TO_QUARTER PRIMARY KEY (cal_year_qtr, incl_cal_year_qtr) NOT ENFORCED
 )  COMMENT= 'This table relates a calendar_2 year quarter to all calendar_2 year quarters that form the calendar_2-year-to-quarter interval of this quarter. E.g. for Q3/2021 this is Q1/2021, Q2/2021 and Q3/2021.';
