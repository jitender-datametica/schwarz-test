CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_art_gp_wup_zu_per
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
(SELECT mandant_id,
  art_id,
  gp_id,
  wup_id,
  nb_id,
  einkaufsorganisation_id,
  dat_von,
  dat_bis,
  bezugsweg_id,
  wrg_id,
  komponentenmenge,
  7 AS system_id
 FROM kfl_production_dbp_view.v_art_gp_wup_zu_per
 WHERE dat_bis = DATE '9999-12-31'
  AND mandant_id = 1
 UNION DISTINCT
 SELECT mandant_id,
   art_id - 1 AS art_id,
  gp_id,
  wup_id,
  nb_id,
  einkaufsorganisation_id,
  dat_von,
  dat_bis,
  bezugsweg_id,
  wrg_id,
  komponentenmenge,
  7 AS system_id
 FROM kfl_production_dbp_view.v_art_gp_wup_zu_per
 WHERE dat_bis = DATE '9999-12-31'
  AND mandant_id = 1
  AND art_id BETWEEN -999000 AND (-1000))
UNION DISTINCT
(SELECT mandant_id,
   art_id - 2 AS art_id,
  gp_id,
  wup_id,
  nb_id,
  einkaufsorganisation_id,
  dat_von,
  dat_bis,
  bezugsweg_id,
  wrg_id,
  komponentenmenge,
  7 AS system_id
 FROM kfl_production_dbp_view.v_art_gp_wup_zu_per
 WHERE dat_bis = DATE '9999-12-31'
  AND mandant_id = 1
  AND art_id BETWEEN -999000 AND (-1000)
 UNION DISTINCT
 (SELECT mandant_id,
    art_id - 3 AS art_id,
   gp_id,
   wup_id,
   nb_id,
   einkaufsorganisation_id,
   dat_von,
   dat_bis,
   bezugsweg_id,
   wrg_id,
   komponentenmenge,
   7 AS system_id
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per
  WHERE dat_bis = DATE '9999-12-31'
   AND mandant_id = 1
   AND art_id BETWEEN -999000 AND (-1000)
  UNION DISTINCT
  SELECT mandant_id,
    art_id - 9 AS art_id,
   gp_id,
   wup_id,
   nb_id,
   einkaufsorganisation_id,
   dat_von,
   dat_bis,
   bezugsweg_id,
   wrg_id,
   komponentenmenge,
   7 AS system_id
  FROM kfl_production_dbp_view.v_art_gp_wup_zu_per
  WHERE dat_bis = DATE '9999-12-31'
   AND mandant_id = 1
   AND art_id BETWEEN -999000 AND (-1000)));
