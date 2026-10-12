CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_wup_betrieb_1
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  v01.mandant_id AS mandant_id,
  v01.wup_id AS wup_id,
  v01.nb_id AS nb_id,
  v01.wup_standort AS wup_standort,
  v01.dat_von AS dat_von,
  v01.dat_bis AS dat_bis,
  v01.dat_qbm_umstellung AS dat_qbm_umstellung,
  v01.dat_eroeffnung AS dat_eroeffnung,
  v01.wup_plz AS wup_plz,
  v02.region_id AS region_id,
  v01.kreistyp_gruppe_id AS kreistyp_gruppe_id,
  v01.vkl_id AS vkl_id
FROM kfl_production_dbp_view.v_wup_1 AS v01
LEFT JOIN kfl_production_dbp_view.v_vaus_wup_1 AS v02
  ON v01.mandant_id = v02.mandant_id AND v01.wup_id = v02.wup_id
WHERE
  (
    v01.mandant_id = 2
    AND v01.verkaufsorganisation_id = '1000'
    OR v01.mandant_id = 3
    AND v01.verkaufsorganisation_id = '1060'
    OR v01.mandant_id = 5
    AND v01.verkaufsorganisation_id = '1020'
    OR v01.mandant_id = 6
    AND v01.verkaufsorganisation_id = '1030'
    OR v01.mandant_id = 7
    AND v01.verkaufsorganisation_id = '1070'
    OR v01.mandant_id = 8
    AND v01.verkaufsorganisation_id = '1090'
  )
  AND v01.nb_id = -111
  OR v01.mandant_id <> 1
  AND (
    v01.nb_id = 0 OR v01.wup_id = 0
  );
