CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_art_umrechnung_faktor_per_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
(SELECT mandant_id,
  art_id,
  altnv_menge_einh_id,
  bruttogew,
  umrech_faktor,
  gew_einh_id,
  dat_von,
  dat_bis,
  7 AS system_id
 FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
 WHERE mandant_id = 1
 UNION DISTINCT
 SELECT mandant_id,
   art_id - 1 AS art_id,
  altnv_menge_einh_id,
  bruttogew,
  umrech_faktor,
  gew_einh_id,
  dat_von,
  dat_bis,
  7 AS system_id
 FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
 WHERE mandant_id = 1
  AND art_id BETWEEN -999000 AND (-1000))
UNION DISTINCT
(SELECT mandant_id,
   art_id - 2 AS art_id,
  altnv_menge_einh_id,
  bruttogew,
  umrech_faktor,
  gew_einh_id,
  dat_von,
  dat_bis,
  7 AS system_id
 FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
 WHERE mandant_id = 1
  AND art_id BETWEEN -999000 AND (-1000)
 UNION DISTINCT
 (SELECT mandant_id,
    art_id - 3 AS art_id,
   altnv_menge_einh_id,
   bruttogew,
   umrech_faktor,
   gew_einh_id,
   dat_von,
   dat_bis,
   7 AS system_id
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
  WHERE mandant_id = 1
   AND art_id BETWEEN -999000 AND (-1000)
  UNION DISTINCT
  SELECT mandant_id,
    art_id - 9 AS art_id,
   altnv_menge_einh_id,
   bruttogew,
   umrech_faktor,
   gew_einh_id,
   dat_von,
   dat_bis,
   7 AS system_id
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
  WHERE mandant_id = 1
   AND art_id BETWEEN -999000 AND (-1000)));


