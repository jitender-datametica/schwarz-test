/*
====================================================================================================
Division		  |	Lidl
Solution		  |	SCORE
DB schema		  |	fe_mstr_score
DB table/view	  |	v_rel_business_year_to_date_2
Description		  | Business-year-to-date interval (E.g. for April 15th 2019 this is all dates from March 1st 2019 to April 15th, inclusively)
Created on        |	18.03.2024
====================================================================================================
*/

CREATE OR REPLACE VIEW FE_MSTR_SCORE.V_REL_BUSINESS_YEAR_TO_DATE_2(
	CAL_DT COMMENT 'The date for which the business-year-to-date interval is defined.',
	INCL_CAL_DT COMMENT 'The date that needs to be included in the business-year-to-date interval.'
) COMMENT='This table relates a calendar_2 date to all dates that form the business-year-to-date interval for this date. E.g. for April 15th 2019 this is all dates from March 1st 2019 to April 15th, inclusively.'
 AS 
SELECT
   cal_dt
  ,incl_cal_dt
FROM CORE.V_REL_BUSINESS_YEAR_TO_DATE_2;