CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_vz_zuordnung
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
SELECT v01.mandant_id,
 v01.vz_wup_id,
 v01.wup_plz,
  CASE
  WHEN CAST(v01.wup_plz AS FLOAT64) < 20000 OR v01.vz_wup_id = 6907
  THEN '1'
  WHEN CAST(v01.wup_plz AS INTEGER) BETWEEN 20000 AND 59999
  THEN '3'
  ELSE '2'
  END AS zu_id,
 V02.wup_id,
 V02.nb_id
FROM (SELECT mandant_id,
   vz_wup_id,
   wup_plz,
    CASE
    WHEN CAST(wup_plz AS FLOAT64) < 20000 OR vz_wup_id = 6907
    THEN '1'
    WHEN CAST(wup_plz AS INTEGER) BETWEEN 20000 AND 59999
    THEN '3'
    ELSE '2'
    END AS zu_id
  FROM kfl_production_dbp_view.v_wup AS V01
  WHERE vz_wup_id = wup_id
   AND wup_typ_id = 2
   AND nb_id = -111
   AND mandant_id = 1) AS v01
 LEFT JOIN kfl_production_dbp_view.v_wup AS V02 ON v01.vz_wup_id = V02.vz_wup_id AND v01.mandant_id = V02.mandant_id;