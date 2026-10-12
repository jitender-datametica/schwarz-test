CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tour_plombe_start_1 AS SELECT mandant_id,
 tour_id,
 plombe_id,
 plombe_pos_id,
 nb_id,
 wup_id,
 plombe_vorgang_id,
 dat_erfasst,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_erfasst AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_erfasst,
 storno_fg
FROM kfl_production_dbp_data.tour_plombe_start_1;