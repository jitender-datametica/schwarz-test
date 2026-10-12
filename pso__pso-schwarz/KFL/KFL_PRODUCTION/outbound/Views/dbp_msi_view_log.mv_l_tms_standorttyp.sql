CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_standorttyp (tms_standorttyp_id, tms_standorttyp_lfd_nr
, tms_standorttyp_bez) AS SELECT T0.tms_standorttyp_id,
 T0.tms_standorttyp_lfd_nr,
 T0.tms_standorttyp_bez
FROM kfl_production_dbp_view.v_l_tms_standorttyp AS T0
 INNER JOIN kfl_production_dbp_view.v_l_system AS S ON T0.system_id = S.system_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(T0.tms_standorttyp_id AS STRING), CAST(T0.tms_standorttyp_lfd_nr AS STRING)
      , T0.tms_standorttyp_bez ORDER BY CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END IS NULL, CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END)) = 1
UNION DISTINCT
SELECT ROUND(CAST('-1' AS BIGNUMERIC), 0),
 ROUND(CAST('-1' AS BIGNUMERIC), 0),
 'n/a';