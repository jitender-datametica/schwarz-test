CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view2.mv_ausnahme_wup
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.art_id AS art_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.mandant_id AS mandant_id,
  v01.dat_plan AS dat_plan,
  v01.pruef_id AS pruef_id,
  CASE
    WHEN v01.z_arbeitsgebiet_id = 0
    THEN 'Z'
    WHEN v01.z_arbeitsgebiet_id = 1
    THEN 'S'
    ELSE ' '
  END AS z_arbeitsgebiet_id,
  v02.gp_id AS gp_id,
  v01.ausnahme_mutter_id AS ausnahme_mutter_id
FROM kfl_production_dbp_view.v_ausnahme AS v01
INNER JOIN kfl_production_dbp_view.v_art_gp_nm_zu_per AS v02
  ON v01.art_id = v02.art_id
  AND v01.mandant_id = v02.mandant_id
  AND v01.wup_id = v02.wup_id
  AND v01.dat_plan BETWEEN v02.dat_von AND v02.dat_bis
WHERE
  v01.mandant_id = 1
  AND v01.nb_id <> -111
  AND v01.pruef_id IN (
    126,
    203,
    204,
    205,
    206,
    207,
    208,
    209,
    210,
    214,
    216,
    218,
    221,
    223,
    225,
    231,
    700
  )
  AND v01.z_arbeitsgebiet_id = 1
  OR v01.mandant_id = 1
  AND v01.nb_id <> -111
  AND v01.pruef_id IN (250, 252, 1, 5, 2, 253, 254)
  AND v01.z_arbeitsgebiet_id = 0;
