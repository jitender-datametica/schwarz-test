CREATE OR REPLACE VIEW ldl_autodispo_fe_mstr_autodispo.v_oracle_fk_takeover_rate_2 (country_2, wh, storecalculation_id,
arguments, user, date, automatic_entry, mod_date, source_extraction_tmsp, snflk_insert_tmsp, snflk_update_tmsp) AS
SELECT country_2,
 wh,
 storecalculation_id,
 arguments,
 SESSION_USER() AS user,
 calculation_date AS date,
  CASE
  WHEN SESSION_USER() = 'AUTOMATIC'
  THEN 1
  ELSE 0
  END AS automatic_entry,
 mod_date,
 source_extraction_tmsp,
 snflk_insert_tmsp,
 snflk_update_tmsp
FROM ldl_autodispo_core.t_oracle_v_calculation_user_2;