CREATE OR REPLACE VIEW ldl_data_etl_process.v_lc_prtcl_main_contexts_2 AS SELECT context_load_id,
 processcontainer,
 MAX(updated_ts) AS updated_ts,
 MAX(success_state) AS main_success_state,
  CASE
  WHEN MAX(stager_plan_state) = 'free' AND MAX(loader_plan_state) = 'locked'
  THEN 1
  ELSE 0
  END AS main_ctx_has_started_fg,
 MAX(context_load_id) OVER (PARTITION BY processcontainer ORDER BY CASE
     WHEN MAX(stager_plan_state) = 'free' AND MAX(loader_plan_state) = 'locked'
     THEN 1
     ELSE 0
     END IS NULL, CASE
     WHEN MAX(stager_plan_state) = 'free' AND MAX(loader_plan_state) = 'locked'
     THEN 1
     ELSE 0
     END, MAX(updated_ts) IS NULL, MAX(updated_ts) ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS fllwing_ctx_lid,
 MAX(CASE
   WHEN MAX(stager_plan_state) = 'free' AND MAX(loader_plan_state) = 'locked'
   THEN 1
   ELSE 0
   END) OVER (PARTITION BY processcontainer ORDER BY CASE
     WHEN MAX(stager_plan_state) = 'free' AND MAX(loader_plan_state) = 'locked'
     THEN 1
     ELSE 0
     END IS NULL, CASE
     WHEN MAX(stager_plan_state) = 'free' AND MAX(loader_plan_state) = 'locked'
     THEN 1
     ELSE 0
     END, MAX(updated_ts) IS NULL, MAX(updated_ts) ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS fllwing_ctx_has_started
 ,
  CASE
  WHEN DATETIME_DIFF(CAST(CURRENT_TIMESTAMP() AS DATETIME), MAX(updated_ts), DAY) > 416
  THEN 9999
  ELSE DATETIME_DIFF(CAST(CURRENT_TIMESTAMP() AS DATETIME), MAX(updated_ts), HOUR)
  END AS hours_since_last_update
FROM ldl_data_etl_process.t_lc_prtcl_context_tasks_2
GROUP BY context_load_id,
 processcontainer;