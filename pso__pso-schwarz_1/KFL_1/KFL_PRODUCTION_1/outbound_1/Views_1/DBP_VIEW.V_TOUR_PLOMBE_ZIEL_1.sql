CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tour_plombe_ziel_1 AS SELECT mandant_id,
 nb_id,
 wup_id,
 tour_id,
 plombe_id,
 plombe_prozess_id,
 plombe_aktivitaet,
 dat_scan,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_scan AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_scan,
 info_code
FROM kfl_production_dbp_data.tour_plombe_ziel_1;