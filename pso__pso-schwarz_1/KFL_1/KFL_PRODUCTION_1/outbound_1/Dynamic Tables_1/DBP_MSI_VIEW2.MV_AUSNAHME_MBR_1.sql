CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_ausnahme_mbr_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.art_id AS art_id,
  COALESCE(v02.wup_id, v01.wup_id) AS wup_id,
  COALESCE(v02.nb_id, v01.nb_id) AS nb_id,
  v01.mandant_id AS mandant_id,
  v01.dat_plan AS dat_plan,
  v01.pruef_id AS pruef_id,
  CASE WHEN v01.pruef_id IN (210, 220) THEN '210 / 220' ELSE NULL END AS pseudoanzeige,
  CASE
    WHEN v01.z_arbeitsgebiet_id = 0
    THEN 'Z'
    WHEN v01.z_arbeitsgebiet_id = 1
    THEN 'S'
    ELSE ' '
  END AS z_arbeitsgebiet_id,
  COALESCE(v02.gp_id, v01.gp_id) AS gp_id,
  v01.ausnahme_mutter_id AS ausnahme_mutter_id,
  v01.ausnahme_menge_bme AS ausnahme_menge_bme,
  v01.ausnahme_menge_kolli AS ausnahme_menge_kolli
FROM kfl_production_dbp_view.v_ausnahme_1 AS v01
INNER JOIN (
  SELECT
    ausnahme_id,
    mandant_id,
    wup_id,
    nb_id,
    dat_plan,
    gp_id
  FROM kfl_production_dbp_view.v_ausnahme_1
  WHERE
    pruef_id = 220
) AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.ausnahme_mutter_id = v02.ausnahme_id
  AND v01.dat_plan = v02.dat_plan
WHERE
  v01.mandant_id = 1 AND v01.pruef_id IN (210) AND v01.z_arbeitsgebiet_id = 0;
