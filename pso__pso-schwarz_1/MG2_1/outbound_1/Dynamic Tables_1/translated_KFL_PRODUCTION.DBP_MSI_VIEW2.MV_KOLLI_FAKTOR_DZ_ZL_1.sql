CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_kolli_faktor_dz_zl_1
OPTIONS (
  enable_refresh=TRUE,
  refresh_interval_minutes=90,
  max_staleness=INTERVAL '1:30:0' HOUR TO SECOND,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  bw.mandant_id,
  bw.art_id,
  SUM(CASE WHEN bw.bezugsweg_id = 1 THEN COALESCE(kolli.umrech_faktor, 1) ELSE 0 END)as menge_einh_id,
  SUM(CASE WHEN bw.bezugsweg_id = 4 THEN COALESCE(kolli.umrech_faktor, 1) ELSE 0 END)as  bezugsweg_id
FROM (
  SELECT
    art_id,
    mandant_id,
    menge_einh_id,
    bezugsweg_id
  FROM (
    SELECT
      art_id,
      mandant_id,
      best_menge_einh_id AS menge_einh_id,
      1 AS bezugsweg_id
    FROM kfl_production_dbp_view.v_art_1
    WHERE
      dat_bis = CAST('9999-12-31' AS DATE)
    UNION ALL
    SELECT
      art_id,
      mandant_id,
      ausg_menge_einh_id AS menge_einh_id,
      4 AS bezugsweg_id
    FROM kfl_production_dbp_view.v_art_vorschlagswert_per_1
    WHERE
      dat_bis = CAST('9999-12-31' AS DATE)
  ) AS subs
) AS bw
LEFT JOIN (
  SELECT
    art_id,
    mandant_id,
    altnv_menge_einh_id,
    umrech_faktor
  FROM kfl_production_dbp_view.v_art_umrechnung_faktor_per_1
  WHERE
    dat_bis = CAST('9999-12-31' AS DATE)
) AS kolli
  ON bw.art_id = kolli.art_id
  AND bw.mandant_id = kolli.mandant_id
  AND bw.menge_einh_id = kolli.altnv_menge_einh_id
WHERE
  bw.mandant_id = 1
GROUP BY
  bw.mandant_id,
  bw.art_id;