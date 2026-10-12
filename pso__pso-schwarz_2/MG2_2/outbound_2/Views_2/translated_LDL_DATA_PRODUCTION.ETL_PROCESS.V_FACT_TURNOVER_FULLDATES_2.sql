CREATE OR REPLACE VIEW ldl_data_production_etl_process.v_fact_turnover_fulldates_2 (cal_dt, bus_year, int_org_sid,
int_org_type_cd, country_org_cd, curr_cd) AS SELECT d.cal_dt,
 d.bus_year,
 f.int_org_sid,
 f.int_org_type_cd,
 f.country_org_cd,
 f.curr_cd
FROM ldl_data_production_core_dim.t_dim_calendar_date_2 AS d
 INNER JOIN ldl_data_production_etl_process.v_fact_turnover_dates_2 AS f ON d.bus_year = f.bus_year AND d.cal_dt BETWEEN f
   .begin_bus_dt AND f.to_bus_dt;