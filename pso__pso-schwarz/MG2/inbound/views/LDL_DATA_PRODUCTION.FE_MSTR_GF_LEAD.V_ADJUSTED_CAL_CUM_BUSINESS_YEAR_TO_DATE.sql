create or replace view LDL_DATA_PRODUCTION.FE_MSTR_GF_LEAD.V_ADJUSTED_CAL_CUM_BUSINESS_YEAR_TO_DATE(
	CAL_DT COMMENT 'The date for which the business-year-to-date interval is defined.',
	INCL_CAL_DT COMMENT 'The date that needs to be included in the business-year-to-date interval.',
	PREV_YEAR_CAL_DT COMMENT 'The date that needs to be included in the previous-business-year-to-date interval.',
	BUS_YEAR_DIFF COMMENT 'The business year difference between cal_dt and included data',
	INCL_CAL_DAT COMMENT 'The date that needs to be included in the business difference business-year-to-date interval.'
) COMMENT='The transformation table for the adjusted business year to date'
 as SELECT
bytd.cal_dt AS cal_dt,
bytd.incl_cal_dt AS incl_cal_dt,
ar.cal_dt AS prev_year_cal_dt,
ar.bus_year_diff AS bus_year_diff,
ar.incl_cal_dt AS incl_cal_dat
FROM CORE_REL.T_CAL_CUM_BUSINESS_YEAR_TO_DATE bytd
INNER JOIN CORE_REL.T_CAL_DATE_ADJUSTED_RELATION ar
ON bytd.incl_cal_dt = ar.cal_dt
WHERE ar.bus_year_diff = 1;