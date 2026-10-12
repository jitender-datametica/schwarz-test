--==============================================================
-- Table: t_rel_business_year_to_date_2
--==============================================================
/* --------------------------------------------------------------------------------
   DDL for table: t_rel_business_year_to_date_2
   generated from Powerdesigner on Mittwoch, 29. November 2023 20:09:41
*/ --------------------------------------------------------------------------------

CREATE TABLE CORE_REL.T_REL_BUSINESS_YEAR_TO_DATE_2 (
   cal_dt                              DATE            NOT NULL COMMENT 'The date for which the business-year-to-date interval is defined.',
   incl_cal_dt                         DATE            NOT NULL COMMENT 'The date that needs to be included in the business-year-to-date interval.',
   dwh_created_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was created in the data warehouse.',
   dwh_updated_tmsp                    TIMESTAMP_LTZ(9) NOT NULL COMMENT 'The point in time when this record was last updated.',   
   CONSTRAINT PK_T_REL_BUSINESS_YEAR_TO_DATE PRIMARY KEY (cal_dt, incl_cal_dt) NOT ENFORCED 
)  COMMENT = 'This table relates a calendar_2 date to all dates that form the business-year-to-date interval for this date. E.g. for April 15th 2019 this is all dates from March 1st 2019 to April 15th, inclusively.';
