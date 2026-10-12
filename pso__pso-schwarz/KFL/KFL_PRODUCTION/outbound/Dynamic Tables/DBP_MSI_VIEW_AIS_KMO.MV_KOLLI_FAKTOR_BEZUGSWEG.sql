CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_kolli_faktor_bezugsweg
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v02.mandant_id AS mandant_id,
  v02.art_id AS art_id,
  COALESCE(v03.umrech_faktor, 1) AS kolli_faktor,
  v02.bezugsweg_id AS bezugsweg_id
FROM (
  SELECT
    art_id,
    mandant_id,
    best_menge_einh_id AS menge_einh_id,
    1 AS bezugsweg_id
  FROM kfl_production_dbp_view.v_art
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id <> 1
  UNION ALL
  SELECT
    art_id,
    mandant_id,
    ausg_menge_einh_id AS menge_einh_id,
    4 AS bezugsweg_id
  FROM kfl_production_dbp_view.v_art_vorschlagswert_per
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id <> 1
) AS v02
LEFT JOIN (
  SELECT
    art_id,
    mandant_id,
    altnv_menge_einh_id,
    umrech_faktor
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE) AND mandant_id <> 1
) AS v03
  ON v02.art_id = v03.art_id
  AND v02.mandant_id = v03.mandant_id
  AND v02.menge_einh_id = v03.altnv_menge_einh_id
WHERE
  v02.mandant_id <> 1;
