CREATE OR REPLACE VIEW kfl_production_dbp_msi_view_log.mv_l_tms_tour_status (mandant_id, tms_tourstatus_id,
tms_tourstatus_lfd_nr, tms_tourstatus_bez) AS SELECT T0.mandant_id,
 T0.tms_tourstatus_id,
 T0.tms_tourstatus_lfd_nr,
 T0.tms_tourstatus_bez
FROM kfl_production_dbp_view.v_l_tms_tourstatus AS T0
 INNER JOIN kfl_production_dbp_view.v_l_system AS S ON T0.system_id = S.system_id AND S.system_gruppe <> 'WANKO BELOG'
QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(T0.mandant_id AS STRING), CAST(T0.tms_tourstatus_id AS STRING), CAST(T0.tms_tourstatus_lfd_nr AS STRING)
      ORDER BY CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END IS NULL, CASE
       WHEN LEFT(S.kl_system_bez, 3) <> 'FLW'
       THEN 0
       ELSE 1
       END)) = 1;