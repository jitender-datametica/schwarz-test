CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_kostenstelle_per_2 (mandant_id, kostenstelle_id,
kostenstelle_bez, dat) AS (SELECT v_kostenstelle_per.mandant_id,
  v_kostenstelle_per.kostenstelle_id,
  v_kostenstelle_per.kostenstelle_bez,
  v_tag.dat
 FROM kfl_production_dbp_view.v_kostenstelle_per_2
  INNER JOIN kfl_production_dbp_view.v_tag_2 ON v_tag.dat BETWEEN v_kostenstelle_per.dat_von AND v_kostenstelle_per.dat_bis
   
 UNION DISTINCT
 SELECT v_mandant.mandant_id,
  '0',
  'manuell erfasst',
  v_tag0.dat
 FROM kfl_production_dbp_view.v_tag_2 AS v_tag0
  INNER JOIN kfl_production_dbp_view.v_mandant_2 ON v_tag0.akt_kj >= - 2)
UNION DISTINCT
SELECT H_TAG.mandant_id,
 H_TAG.kostenstelle_id,
 K_P.kostenstelle_bez,
 H_TAG.dat
FROM kfl_production_dbp_view.v_hydra_taetigkeit_tag_2 AS H_TAG
 LEFT JOIN kfl_production_dbp_view.v_kostenstelle_per_2 AS K_P ON H_TAG.dat BETWEEN K_P.dat_von AND K_P.dat_bis AND H_TAG
    .mandant_id = K_P.mandant_id AND H_TAG.kostenstelle_id = K_P.kostenstelle_id
WHERE K_P.kostenstelle_bez IS NULL
 AND H_TAG.kostenstelle_id <> '';