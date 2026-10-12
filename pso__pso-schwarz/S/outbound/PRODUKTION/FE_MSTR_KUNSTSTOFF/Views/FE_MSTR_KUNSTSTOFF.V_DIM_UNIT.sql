CREATE OR REPLACE VIEW produktion_fe_mstr_kunststoff.v_dim_unit (unit_id, unit_code, unit_name) AS SELECT unit_id,
 unit_code,
 unit_name
FROM produktion_core.t_dim_unit;