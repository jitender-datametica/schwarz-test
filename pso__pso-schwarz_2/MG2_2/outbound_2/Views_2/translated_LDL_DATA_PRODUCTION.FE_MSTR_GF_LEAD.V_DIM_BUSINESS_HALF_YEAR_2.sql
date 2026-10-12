CREATE OR REPLACE VIEW ldl_data_production_fe_mstr_gf_lead.v_dim_business_half_year_2 (bus_half_year, bus_year,
bus_half_year_name, bus_half_year_name_de, bus_half_year_name_en, half_of_bus_year, bus_half_year_begin_month,
bus_half_year_end_month, bus_half_year_begin_part_week, bus_half_year_end_part_week, bus_half_year_begin_dt,
bus_half_year_end_dt, bus_half_year_week_cnt, bus_half_year_part_week_cnt, bus_half_year_day_cnt, prev_1y_bus_half_year
, prev_2y_bus_half_year, prev_3y_bus_half_year, prev_4y_bus_half_year, prev_5y_bus_half_year, curr_bus_half_year_fg,
bus_half_year_offset, bus_year_offset, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
OPTIONS(DESCRIPTION = `A HALF OF A BUSINESS YEAR. THE FIRST HALF YEAR IN THE LIDL BUSINESS YEAR IS FROM MARCH TO AUGUST, THE SECOND HALF YEAR FROM SEPTEMBER TO FEBRUARY. E.G. 20211 FOR THE FIRST HALF OF  THE BUSINESS YEAR 2021.`)
AS SELECT *
FROM ldl_data_production_core_dim.t_dim_business_half_year_2 AS main
WHERE bus_year_offset BETWEEN - 20 AND 2;