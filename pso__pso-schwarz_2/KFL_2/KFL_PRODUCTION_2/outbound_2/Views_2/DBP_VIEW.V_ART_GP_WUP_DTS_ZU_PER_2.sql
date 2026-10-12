CREATE OR REPLACE VIEW kfl_production_dbp_view.v_art_gp_wup_dts_zu_per_2 AS SELECT mandant_id,
 wup_id,
 nb_id,
 art_id,
 gp_id,
 loesch_fg,
 dat_von,
 dat_bis,
 verkaufsorganisation_id,
 vw_id,
 auslieferungsgruppe_id,
 dispoteilsortiment_id
FROM kfl_production_dbp_data.art_gp_wup_dts_zu_per_2;