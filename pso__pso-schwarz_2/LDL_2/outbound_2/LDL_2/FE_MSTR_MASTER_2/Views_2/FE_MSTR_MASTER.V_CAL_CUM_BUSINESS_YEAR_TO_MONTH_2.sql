CREATE OR REPLACE VIEW fe_mstr_master.v_cal_cum_business_year_to_month_2 (cal_month
OPTIONS(description='The calendar_2 month for which the business-year-to-month interval is defined.'), incl_cal_month
OPTIONS(description='The calendar_2 month that needs to be included in the business-year-to-month interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A MONTH TO ALL MONTHS THAT FORM THE BUSINESS-YEAR-TO-MONTH INTERVAL OF THIS MONTH. E.G. FOR MAY 2019 THIS IS MARCH, APRIL AND MAY 2019.`)
AS SELECT cal_month,
 incl_cal_month,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_business_year_to_month_2 AS MAIN;