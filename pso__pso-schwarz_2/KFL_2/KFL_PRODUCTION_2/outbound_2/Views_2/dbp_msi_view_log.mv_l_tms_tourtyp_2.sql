CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_tourtyp_2 (tms_tourtyp_id, tms_tourtyp_bez) AS SELECT T0.tms_tourtyp_id
 ,
 T0.tms_tourtyp_bez
FROM kfl_production_dbp_view.v_l_tms_tourtyp_2 AS T0
 INNER JOIN kfl_production_dbp_view.v_l_system_2 AS S ON T0.system_id = S.system_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(T0.tms_tourtyp_id AS STRING) ORDER BY CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END IS NULL, CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END)) = 1
UNION DISTINCT
SELECT 0,
 'kein Typ';