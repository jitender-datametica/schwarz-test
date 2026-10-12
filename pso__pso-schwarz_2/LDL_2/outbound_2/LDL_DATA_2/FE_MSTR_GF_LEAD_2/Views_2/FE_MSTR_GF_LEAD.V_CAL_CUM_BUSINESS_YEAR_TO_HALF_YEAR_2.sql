CREATE OR REPLACE VIEW ldl_data_fe_mstr_gf_lead.v_cal_cum_business_year_to_half_year_2 (bus_half_year
OPTIONS(description='The business half year for which the business-year-to-half-year interval is defined.'),
incl_bus_half_year
OPTIONS(description='The business half year that needs to be included in the business-year-to-half-year interval.'),
dwh_created_tmsp OPTIONS(description='The point in time when this record was created in the data warehouse.'),
dwh_updated_tmsp OPTIONS(description='The point in time when this record was created or last updated.'))
OPTIONS(DESCRIPTION = `THIS TABLE RELATES A BUSINESS HALF YEAR TO ALL BUSINESS HALF YEARS THAT FORM THE BUSINESS-HALF-YEAR-TO-YEAR INTERVAL OF THIS BUSINESS HALF YEAR. E.G. FOR THE20211 THIS IS 20211 AND 20212.`)
AS SELECT bus_half_year,
 incl_bus_half_year,
 dwh_created_tmsp,
 dwh_updated_tmsp
FROM ldl_data_core_rel.t_cal_cum_business_year_to_half_year_2 AS MAIN;