CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_wwc.mv_art_palmenge_zu_2 (mandant_id, art_id, palettenmenge) AS SELECT
 V01.mandant_id,
 V01.art_id,
 COALESCE(v02.palettenmenge, 1) AS palettenmenge
FROM kfl_production_dbp_view.v_art_2 AS V01
 LEFT JOIN (SELECT mandant_id,
   art_id,
   CAST(ROUND(CAST(TRUNC(CAST(1 / umrech_faktor AS BIGNUMERIC)) AS NUMERIC), 0) AS BIGNUMERIC) AS palettenmenge
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_2
  WHERE altnv_menge_einh_id = 'PAL'
   AND dat_bis = DATE '9999-12-31') AS v02 ON V01.mandant_id = v02.mandant_id AND V01.art_id = v02.art_id;