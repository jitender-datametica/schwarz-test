CREATE OR REPLACE VIEW ldl_p_lew_process.v_lc_prtcl_new_contexts_2 AS SELECT c.context_area_type,
 c.context_area,
 c.context_load_id,
 c.processcontainer,
 c.success_state,
 c.fllwngctx_lid,
 COALESCE(fllwing_ctx.fllwing_ctx_has_started, 0) AS fllwing_ctx_has_started
FROM (SELECT context_area_type,
   context_area,
   context_load_id,
   processcontainer,
   success_state,
   MAX(real_fllwngctx_lid) OVER (PARTITION BY CAST(context_load_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS fllwngctx_lid
  FROM (SELECT CTX.context_area_type,
     CTX.context_area,
     CTX.context_load_id,
     CTX.processcontainer,
     MAX(CTX.success_state) AS success_state,
     MAX(CTX.updated_ts) AS last_ready_ts_per_context,
     MAX(PR_DELETED.delete_ts) AS last_delete_ts_per_context,
     MIN(CTX.context_load_id) OVER (PARTITION BY CTX.processcontainer ORDER BY MAX(CTX.updated_ts) IS NULL, MAX(CTX.updated_ts
         ) ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS fllwngctx_lid,
      CASE
      WHEN CTX.context_load_id <> (MIN(CTX.context_load_id) OVER (PARTITION BY CTX.processcontainer ORDER BY MAX(CTX.updated_ts
            ) IS NULL, MAX(CTX.updated_ts) ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING))
      THEN MIN(CTX.context_load_id) OVER (PARTITION BY CTX.processcontainer ORDER BY MAX(CTX.updated_ts) IS NULL, MAX(CTX
          .updated_ts) ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING)
      ELSE NULL
      END AS real_fllwngctx_lid
    FROM ldl_p_lew_process.v_lc_prtcl_all_contexts_2 AS CTX
     INNER JOIN ldl_p_lew_process.t_lc_conf_tcache_recipients_2 AS CONF ON CTX.processcontainer = CONF.tcache_processcontainer
      
     LEFT JOIN ldl_p_lew_process.t_lc_prtcl_tcache_recipients_2 AS PR_READY ON CTX.context_area_type = PR_READY.context_area_type
            AND CTX.context_area = PR_READY.context_area AND CTX.context_load_id = PR_READY.context_load_id AND CONF.tcache_database
          = PR_READY.tcache_database AND CONF.tcache_tablename = PR_READY.tcache_tablename AND CONF.tcache_recipient_processname
        = PR_READY.tcache_recipient_processname
     LEFT JOIN ldl_p_lew_process.t_lc_prtcl_tcache_delete_process_2 AS PR_DELETED ON PR_READY.tcache_database = PR_DELETED
          .tcache_database AND PR_READY.tcache_tablename = PR_DELETED.tcache_tablename AND CTX.context_area_type =
         PR_DELETED.context_area_type AND CTX.context_area = PR_DELETED.context_area AND CTX.context_load_id =
       PR_DELETED.context_load_id
    WHERE PR_DELETED.tcache_tablename IS NULL
     OR PR_READY.ready_ts > PR_DELETED.delete_ts
    GROUP BY CTX.context_area_type,
     CTX.context_area,
     CTX.context_load_id,
     CTX.processcontainer) AS b) AS c
 LEFT JOIN (SELECT context_load_id,
   MAX(CASE
     WHEN success_state = 'raw'
     THEN 0
     ELSE 1
     END) AS fllwing_ctx_has_started
  FROM ldl_p_lew_process.v_lc_prtcl_all_contexts_2 AS CTX
  GROUP BY context_load_id) AS fllwing_ctx ON c.fllwngctx_lid = fllwing_ctx.context_load_id;