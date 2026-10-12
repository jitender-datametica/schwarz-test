CREATE OR REPLACE VIEW idq_production_ldl_apt_results.v_dq_rep_apt_rule_5 (ref_calculation_time, day_id, ref_country_id
, country_code, aktionsbereich_name, cnt_items_nf, cnt_items_f, cnt_items_ogbp, calendarweek_number, calendarweek,
calendarweek_de, calendarweek_en) AS SELECT CURRENT_DATETIME() AS ref_calculation_time,
 day_id,
 ref_country_id,
 country_code,
 aktionsbereich_name,
 cnt_items_nf,
 cnt_items_f,
 cnt_items_ogbp,
 calendarweek_number,
 calendarweek,
 calendarweek_de,
 calendarweek_en
FROM idq_production_ldl_apt_results.t_dq_rep_apt_rule_5;