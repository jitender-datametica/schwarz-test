CREATE OR REPLACE VIEW FE_MSTR_GF_LEAD.V_CAL_CUM_BUSINESS_HALF_YEAR_TO_MONTH (
cal_month COMMENT 'The calendar month for which the business-half-year-to-month interval is defined.'
,incl_cal_month COMMENT 'The calendar month that needs to be included in the business-half-year-to-month interval.'
,dwh_created_tmsp COMMENT 'The point in time when this record was created in the data warehouse.'
,dwh_updated_tmsp COMMENT 'The point in time when this record was created or last updated.'
) COMMENT = 'This table relates a month to all months that form the business-half-year-to-month interval of this month. E.g. for May 2019 this is March, April and May 2019.' AS SELECT
main.cal_month AS cal_month
,main.incl_cal_month AS incl_cal_month
,main.dwh_created_tmsp AS dwh_created_tmsp
,main.dwh_updated_tmsp AS dwh_updated_tmsp 
FROM CORE_REL.T_CAL_CUM_BUSINESS_HALF_YEAR_TO_MONTH main;