CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_kolli_faktor_bezugsweg
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  bw.mandant_id AS mandant_id,
  bw.art_id AS art_id,
  COALESCE(kolli.umrech_faktor, 1) AS kolli_faktor,
  bw.bezugsweg_id AS bezugsweg_id
FROM (
  SELECT
    art_id,
    mandant_id,
    best_menge_einh_id AS menge_einh_id,
    1 AS bezugsweg_id
  FROM kfl_production_dbp_view.v_art
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
  UNION ALL
  SELECT
    art_id,
    mandant_id,
    ausg_menge_einh_id AS menge_einh_id,
    4 AS bezugsweg_id
  FROM kfl_production_dbp_view.v_art_vorschlagswert_per
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
) AS bw
LEFT JOIN (
  SELECT
    art_id,
    mandant_id,
    altnv_menge_einh_id,
    umrech_faktor
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
) AS kolli
  ON bw.art_id = kolli.art_id
  AND bw.mandant_id = kolli.mandant_id
  AND bw.menge_einh_id = kolli.altnv_menge_einh_id
WHERE
  bw.mandant_id = 1;
