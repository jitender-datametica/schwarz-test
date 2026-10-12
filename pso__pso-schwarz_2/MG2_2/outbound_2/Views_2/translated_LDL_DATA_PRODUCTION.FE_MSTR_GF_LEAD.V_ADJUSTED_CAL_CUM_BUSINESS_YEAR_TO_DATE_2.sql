CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_adjusted_cal_cum_business_year_to_date_2 (cal_dt
OPTIONS(description='The date for which the business-year-to-date interval is defined.'), incl_cal_dt
OPTIONS(description='The date that needs to be included in the business-year-to-date interval.'), prev_year_cal_dt
OPTIONS(description='The date that needs to be included in the previous-business-year-to-date interval.'), bus_year_diff
OPTIONS(description='The business year difference between cal_dt and included data'), incl_cal_dat
OPTIONS(description='The date that needs to be included in the business difference business-year-to-date interval.'))
OPTIONS(DESCRIPTION = `THE TRANSFORMATION TABLE FOR THE ADJUSTED BUSINESS YEAR TO DATE`) AS SELECT bytd.cal_dt,
 bytd.incl_cal_dt,
 ar.cal_dt AS prev_year_cal_dt,
 ar.bus_year_diff,
 ar.incl_cal_dt AS incl_cal_dat
FROM ldl_data_production_core_rel.t_cal_cum_business_year_to_date_2 AS bytd
 INNER JOIN ldl_data_production_core_rel.t_cal_date_adjusted_relation_2 AS ar ON bytd.incl_cal_dt = ar.cal_dt
WHERE ar.bus_year_diff = 1;