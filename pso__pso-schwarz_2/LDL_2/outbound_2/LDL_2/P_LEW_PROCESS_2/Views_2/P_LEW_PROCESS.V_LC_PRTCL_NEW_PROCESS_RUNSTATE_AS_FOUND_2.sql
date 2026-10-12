CREATE OR REPLACE VIEW ldl_p_lew_process.v_lc_prtcl_new_process_runstate_as_found_2 AS SELECT CONF.tcache_database,
 CONF.tcache_tablename,
 CONF.tcache_recipient_processname,
 CONF.tcache_processcontainer,
 NEW_CTX.context_area_type,
 NEW_CTX.context_area,
 NEW_CTX.context_load_id,
 PR_READY.ready_ts,
 SUM(1) OVER (PARTITION BY CONF.tcache_database, CONF.tcache_tablename, NEW_CTX.context_area_type, NEW_CTX.context_area
    , CAST(NEW_CTX.context_load_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 cnt_wait4total,
 SUM(CASE
   WHEN PR_READY.tcache_tablename IS NULL
   THEN 0
   ELSE 1
   END) OVER (PARTITION BY CONF.tcache_database, CONF.tcache_tablename, NEW_CTX.context_area_type, NEW_CTX.context_area
    , CAST(NEW_CTX.context_load_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_ready,
 SUM(CASE
   WHEN PR_READY.tcache_tablename IS NULL
   THEN 1
   ELSE 0
   END) OVER (PARTITION BY CONF.tcache_database, CONF.tcache_tablename, NEW_CTX.context_area_type, NEW_CTX.context_area
    , CAST(NEW_CTX.context_load_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 cnt_wait4pending,
  CASE
  WHEN (SUM(CASE
      WHEN PR_READY.tcache_tablename IS NULL
      THEN 1
      ELSE 0
      END) OVER (PARTITION BY NEW_CTX.context_area_type, NEW_CTX.context_area, CAST(NEW_CTX.context_load_id AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
  THEN 0
  ELSE 1
  END AS ctx_open_fg,
  CASE
  WHEN CASE
     WHEN (SUM(CASE
         WHEN PR_READY.tcache_tablename IS NULL
         THEN 1
         ELSE 0
         END) OVER (PARTITION BY NEW_CTX.context_area_type, NEW_CTX.context_area, CAST(NEW_CTX.context_load_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
     THEN 0
     ELSE 1
     END = 1 AND NEW_CTX.fllwng_context_load_id IS NOT NULL
  THEN 'broken'
  WHEN CASE
     WHEN (SUM(CASE
         WHEN PR_READY.tcache_tablename IS NULL
         THEN 1
         ELSE 0
         END) OVER (PARTITION BY NEW_CTX.context_area_type, NEW_CTX.context_area, CAST(NEW_CTX.context_load_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
     THEN 0
     ELSE 1
     END = 1 AND NEW_CTX.fllwng_context_load_id IS NULL
  THEN 'possibly running or broken'
  ELSE 'ready'
  END AS ctx_state
FROM ldl_p_lew_process.t_lc_conf_tcache_recipients_2 AS CONF
 INNER JOIN ldl_p_lew_process.v_lc_prtcl_new_contexts_as_found_2 AS NEW_CTX ON TRUE
 LEFT JOIN ldl_p_lew_process.t_lc_prtcl_tcache_recipients_2 AS PR_READY ON CONF.tcache_database = PR_READY.tcache_database
        AND CONF.tcache_tablename = PR_READY.tcache_tablename AND CONF.tcache_recipient_processname = PR_READY.tcache_recipient_processname
       AND NEW_CTX.context_area_type = PR_READY.context_area_type AND NEW_CTX.context_area = PR_READY.context_area AND
   NEW_CTX.context_load_id = PR_READY.context_load_id
WHERE CONF.active_fg = 1;