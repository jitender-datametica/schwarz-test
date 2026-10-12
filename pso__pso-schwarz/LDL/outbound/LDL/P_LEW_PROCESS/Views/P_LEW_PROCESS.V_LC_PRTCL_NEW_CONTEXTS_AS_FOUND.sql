CREATE OR REPLACE VIEW ldl_p_lew_process.v_lc_prtcl_new_contexts_as_found AS SELECT context_area_type,
 context_area,
 context_load_id,
 MAX(real_fllwng_context_load_id) OVER (PARTITION BY CAST(context_load_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING
  AND UNBOUNDED FOLLOWING) AS fllwng_context_load_id
FROM (SELECT PR_READY.context_area_type,
   PR_READY.context_area,
   PR_READY.context_load_id,
   MAX(PR_READY.ready_ts) AS last_ready_ts_per_context,
   MAX(PR_DELETED.delete_ts) AS last_delete_ts_per_context,
   MIN(PR_READY.context_load_id) OVER (PARTITION BY 1 ORDER BY MAX(PR_READY.ready_ts) IS NULL, MAX(PR_READY.ready_ts)
    ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS fllwng_context_load_id,
    CASE
    WHEN PR_READY.context_load_id <> (MIN(PR_READY.context_load_id) OVER (PARTITION BY 1 ORDER BY MAX(PR_READY.ready_ts
          ) IS NULL, MAX(PR_READY.ready_ts) ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING))
    THEN MIN(PR_READY.context_load_id) OVER (PARTITION BY 1 ORDER BY MAX(PR_READY.ready_ts) IS NULL, MAX(PR_READY.ready_ts
        ) ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
    ELSE NULL
    END AS real_fllwng_context_load_id
  FROM ldl_p_lew_process.t_lc_prtcl_tcache_recipients AS PR_READY
   LEFT JOIN ldl_p_lew_process.t_lc_prtcl_tcache_delete_process AS PR_DELETED ON PR_READY.tcache_database = PR_DELETED.tcache_database
         AND PR_READY.tcache_tablename = PR_DELETED.tcache_tablename AND PR_READY.context_area_type = PR_DELETED.context_area_type
        AND PR_READY.context_area = PR_DELETED.context_area AND PR_READY.context_load_id = PR_DELETED.context_load_id
  WHERE PR_DELETED.tcache_tablename IS NULL
   OR PR_READY.ready_ts > PR_DELETED.delete_ts
  GROUP BY PR_READY.context_area_type,
   PR_READY.context_area,
   PR_READY.context_load_id) AS b;