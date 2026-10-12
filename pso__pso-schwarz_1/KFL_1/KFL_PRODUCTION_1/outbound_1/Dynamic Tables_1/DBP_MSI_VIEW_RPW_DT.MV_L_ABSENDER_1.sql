
CREATE OR REPLACE MATERIALIZED VIEW dbp_msi_view_rpw_dt.mv_l_absender_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90,max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true
) AS
SELECT mandant_id,
 gp_name,
 gp_id,
 CAST(NULL AS INTEGER) AS aktuell_wup_id,
 dat_von,
 dat_bis,
 7 AS system_id,
 3 AS abs_typ_id
FROM kfl_production_dbp_view.v_gp_1
WHERE mandant_id = 1
 AND gp_id > 999999
UNION DISTINCT
SELECT V01.mandant_id,
 V01.wup_standort AS abs_name,
 V01.wup_id AS abs_id,
 COALESCE(V02.aktuell_wup_id, V01.aktuell_wup_id) AS aktuell_wup_id,
 V01.dat_von,
 V01.dat_bis,
 7 AS system_id,
  CASE
  WHEN V01.nb_id = -111 AND V01.wup_typ_id IN (1, 2) OR V01.nb_id = 99
  THEN 2
  ELSE 1
  END AS abs_typ_id
FROM kfl_production_dbp_view.v_wup_1 AS V01
 LEFT JOIN kfl_production_dbp_view.v_wup_1 AS V02 ON V01.mandant_id = V02.mandant_id AND V01.wup_id = V02.wup_id_alt AND
   V01.nb_id = V02.nb_id
WHERE V01.mandant_id = 1;