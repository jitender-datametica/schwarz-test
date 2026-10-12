CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_tech_measurements_state_stats_details_invalid_novalue (cal_dt,
sample_rate, from_tmsp, to_tmsp, key, state, value, unit) AS SELECT TMPL.measurement_dt AS cal_dt,
 TMPL.measurement_delivery_sample_rate AS sample_rate,
 MIN(TMPL.measurement_tmsp) AS from_tmsp,
 MAX(TMPL.measurement_tmsp) AS to_tmsp,
 TPLP.production_line_parameter_cd AS key,
 TMPL.measurement_delivery_state_txt AS state,
 TMPL.value_qty AS value,
 TUNT.unit_code AS unit
FROM produktion_core_rel.t_measurement_production_line AS TMPL
 INNER JOIN produktion_core_rel.t_production_line_parameter AS TPLP ON TMPL.production_line_parameter_resource_item_sid
  = TPLP.resource_item_sid
 INNER JOIN produktion_core_rel.t_unit AS TUNT ON TMPL.unit_id = TUNT.unit_id
WHERE TMPL.measurement_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 6 DAY) AND (CURRENT_DATE)
 AND UPPER(TMPL.measurement_delivery_state_txt) NOT LIKE 'VALID'
GROUP BY cal_dt,
 sample_rate,
 key,
 state,
 value,
 unit;