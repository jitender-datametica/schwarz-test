CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_treibstoff_2 (mandant_id, tms_treibstoff_id,
tms_treibstoff_bez) AS SELECT T0.mandant_id,
 T0.tms_treibstoff_id,
 T0.tms_treibstoff_bez
FROM kfl_production_dbp_view.v_l_tms_treibstoff_2 AS T0
 INNER JOIN kfl_production_dbp_view.v_l_system_2 AS S ON T0.system_id = S.system_id
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(T0.mandant_id AS STRING), CAST(T0.tms_treibstoff_id AS STRING) ORDER BY
       CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END IS NULL, CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END)) = 1;