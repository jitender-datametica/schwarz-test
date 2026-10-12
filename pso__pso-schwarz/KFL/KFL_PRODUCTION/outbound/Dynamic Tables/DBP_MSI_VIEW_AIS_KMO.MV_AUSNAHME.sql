CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_ausnahme
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90,
  max_staleness=INTERVAL '90' MINUTE,
  allow_non_incremental_definition=TRUE
) AS
SELECT
  v01.art_id,
  v01.wup_id,
  v01.nb_id,
  v01.mandant_id,
  v01.dat_plan,
  v01.pruef_id
FROM kfl_production_dbp_view.v_ausnahme AS v01
INNER JOIN kfl_production_dbp_view.v_tag AS t
  ON v01.dat_plan = t.dat AND t.akt_kj >= -2
INNER JOIN kfl_production_dbp_view.v_art_wup_status_per AS v02
  ON v01.mandant_id = v02.mandant_id
  AND v01.wup_id = v02.wup_id
  AND v01.art_id = v02.art_id
  AND v01.dat_plan BETWEEN v02.dat_von AND v02.dat_bis
  AND v02.dispomerkmal IN ('S2', '10', '12', '14')
  AND v02.kdis = 0
WHERE
  (
    v01.pruef_id IN (202, 203, 205, 206, 207, 209, 210, 214, 216, 218, 223, 225, 231, 700)
    AND v01.mandant_id <> 1
    AND v01.z_arbeitsgebiet_id = 1
    AND v01.wup_id <> 0
    OR v01.mandant_id <> 1
    AND v01.nb_id <> -111
    AND v01.pruef_id IN (250, 252, 1, 5, 2, 253, 254)
    AND v01.z_arbeitsgebiet_id = 0
    AND v01.wup_id <> 0
  )
  AND EXISTS(
    SELECT
      1
    FROM kfl_production_dbp_view.v_art_list_wup_zu_per AS v03
    WHERE
      v01.mandant_id = mandant_id
      AND v01.wup_id = wup_id
      AND v01.art_id = art_id
      AND v01.dat_plan BETWEEN dat_von AND dat_bis
  );