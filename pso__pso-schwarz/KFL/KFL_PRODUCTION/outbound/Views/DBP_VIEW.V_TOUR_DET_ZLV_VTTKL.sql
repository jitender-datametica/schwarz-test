CREATE OR REPLACE VIEW kfl_production_dbp_view.v_tour_det_zlv_vttkl AS SELECT mandant_id,
 nb_id,
 wup_id,
 tour_id,
 kl_tour_pos_id,
 lagernummer_id,
 kunde_id,
 mandant_id_kunde,
 status_tour,
 rundlauf_markt_fg,
  (SAFE.PARSE_TIME('%H%M%S', CAST(MOD(CAST(zeit_plan_ankunft AS BIGNUMERIC), CAST('240000' AS NUMERIC)) AS STRING FORMAT '000000')
   )) AS zeit_plan_ankunft,
 menge_stp_geraeumt,
 cd_fg,
 wgvgrp_id,
 dat_tour,
 zeit_relevant_fg,
 oug_tour_fg
FROM kfl_production_dbp_data.tour_det_zlv_vttkl;