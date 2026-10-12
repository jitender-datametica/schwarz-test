CREATE OR REPLACE VIEW idq_production_ldl_apt_results.v_dq_rep_apt_rule_1 (ref_calculation_time, day_id, ref_country_id
, country_code, cnt_items, cnt_items_nf, cnt_items_f, cnt_items_ogbp, calendarweek_number, calendarweek, calendarweek_de
, calendarweek_en) AS SELECT FORMAT_DATETIME('%F %H:%M:%E3S', PARSE_DATETIME('%F %H:%M:%S', SUBSTR(CAST(CAST(cast(day_id as string)AS DATE) AS STRING), 1, 20))) AS ref_calculation_time,
 day_id,
 ref_country_id,
 country_code,
 cnt_items,
 cnt_items_nf,
 cnt_items_f,
 cnt_items_ogbp,
 calendarweek_number,
 calendarweek,
 calendarweek_de,
 calendarweek_en
FROM idq_production_ldl_apt_results.t_dq_rep_apt_rule_1;