CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_cal_cum_business_year_to_quarter_2 (bus_year_qtr
OPTIONS(description='The business year quarter for which the business-year-to-quarter interval is defined.'),
incl_bus_year_qtr
OPTIONS(description='The business year quarter that needs to be included in the business-year-to-quarter interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A BUSINESS YEAR QUARTER TO ALL BUSINESS YEAR QUARTERS THAT FORM THE BUSINESS-YEAR-TO-QUARTER INTERVAL OF THIS QUARTER. E.G. FOR Q3/2021 THIS IS Q1/2021, Q2/2021 AND Q3/2021.`)
AS SELECT bus_year_qtr,
 incl_bus_year_qtr,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_business_year_to_quarter_2 AS MAIN;