CREATE OR REPLACE MATERIALIZED VIEW kfl_production_dbp_msi_view_ais_kmo.mv_vz
OPTIONS (
  ENABLE_REFRESH=TRUE,
  REFRESH_INTERVAL_MINUTES=90
) AS
SELECT
  mandant_id AS mandant_id,
  wup_id AS vz_id,
  nb_id AS nb_id,
  wup_standort AS vz_bez
FROM kfl_production_dbp_view.v_wup AS v01
WHERE
  (
    mandant_id = 2
    AND verkaufsorganisation_id = '1000'
    OR mandant_id = 3
    AND verkaufsorganisation_id = '1060'
    OR mandant_id = 5
    AND verkaufsorganisation_id = '1020'
    OR mandant_id = 6
    AND verkaufsorganisation_id = '1030'
    OR mandant_id = 4
    AND verkaufsorganisation_id = '1040'
    OR mandant_id = 7
    AND verkaufsorganisation_id = '1070'
    OR mandant_id = 8
    AND verkaufsorganisation_id = '1090'
  )
  AND nb_id = -111;
