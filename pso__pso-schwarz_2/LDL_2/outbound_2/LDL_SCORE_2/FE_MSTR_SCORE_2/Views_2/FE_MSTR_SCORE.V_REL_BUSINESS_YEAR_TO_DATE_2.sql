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


CREATE OR REPLACE VIEW ldl_score_fe_mstr_score.v_rel_business_year_to_date_2 (cal_dt
OPTIONS(description='The date for which the business-year-to-date interval is defined.'), incl_cal_dt
OPTIONS(description='The date that needs to be included in the business-year-to-date interval.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A CALENDAR_2 DATE TO ALL DATES THAT FORM THE BUSINESS-YEAR-TO-DATE INTERVAL FOR THIS DATE. E.G. FOR APRIL 15TH 2019 THIS IS ALL DATES FROM MARCH 1ST 2019 TO APRIL 15TH, INCLUSIVELY.`)
AS SELECT cal_dt,
 incl_cal_dt
FROM ldl_score_core.v_rel_business_year_to_date_2;