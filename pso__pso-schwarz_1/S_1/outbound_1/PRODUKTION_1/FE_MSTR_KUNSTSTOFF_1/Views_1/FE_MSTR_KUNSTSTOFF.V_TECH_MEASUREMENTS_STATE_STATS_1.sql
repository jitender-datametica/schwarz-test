CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_tech_measurements_state_stats_1 (cal_dt, state, min_tmsp, max_tmsp
, state_row_cnt) AS SELECT measurement_dt AS cal_dt,
 measurement_delivery_state_txt AS state,
 MIN(measurement_tmsp) AS min_tmsp,
 MAX(measurement_tmsp) AS max_tmsp,
 COUNT(*) AS state_row_cnt
FROM produktion_core_rel.t_measurement_production_line_1
WHERE measurement_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY) AND (CURRENT_DATE)
GROUP BY cal_dt,
 state;