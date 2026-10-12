CREATE OR REPLACE VIEW ldl_p_lew_process.v_lc_prtcl_calling_rate_last_days_1 AS SELECT tcache_database,
 tcache_tablename,
 tcache_recipient_processname,
 days_before2check,
 MAX(cnt_calls_possible) AS cnt_calls_possible,
 MAX(cnt_calls_real) AS cnt_calls_real
FROM (SELECT CONF.tcache_database,
   CONF.tcache_tablename,
   CONF.tcache_recipient_processname,
   days.days_before2check,
   SUM(CASE
     WHEN ctx_n_days.context_load_id IS NULL
     THEN 0
     ELSE 1
     END) OVER (PARTITION BY CONF.tcache_database, CONF.tcache_tablename, CONF.tcache_recipient_processname ORDER BY
      days.days_before2check IS NULL, days.days_before2check ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cnt_calls_possible,
   SUM(CASE
     WHEN PR_READY.tcache_tablename IS NULL
     THEN 0
     ELSE 1
     END) OVER (PARTITION BY CONF.tcache_database, CONF.tcache_tablename, CONF.tcache_recipient_processname ORDER BY
      days.days_before2check IS NULL, days.days_before2check ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
   cnt_calls_real
  FROM ldl_p_lew_process.t_lc_conf_tcache_recipients_1 AS CONF
   INNER JOIN (SELECT ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY client_id IS NULL, client_id) AS days_before2check,
     DATE_SUB(CURRENT_DATE, INTERVAL ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY client_id IS NULL, client_id) DAY) AS
     rundate
    FROM ldl_p_lew_core.t_client_1) AS days ON TRUE
   LEFT JOIN (SELECT context_area_type,
     context_area,
     context_load_id,
     MIN(ready_ts) AS first_ready_ts,
     MAX(ready_ts) AS last_ready_ts
    FROM ldl_p_lew_process.t_lc_prtcl_tcache_recipients_1 AS PR_READY1
    WHERE CAST(ready_ts AS DATE) >= DATE_SUB(CURRENT_DATE, INTERVAL 100 DAY)
    GROUP BY context_area_type,
     context_area,
     context_load_id) AS ctx_n_days ON DATE(ctx_n_days.first_ready_ts) = days.rundate
   LEFT JOIN ldl_p_lew_process.t_lc_prtcl_tcache_recipients_1 AS PR_READY ON CONF.tcache_database = PR_READY.tcache_database
           AND CONF.tcache_tablename = PR_READY.tcache_tablename AND CONF.tcache_recipient_processname = PR_READY.tcache_recipient_processname
          AND ctx_n_days.context_area_type = PR_READY.context_area_type AND ctx_n_days.context_area = PR_READY.context_area
        AND ctx_n_days.context_load_id = PR_READY.context_load_id AND CAST(PR_READY.ready_ts AS DATE) >= DATE_SUB(CURRENT_DATE
      ,INTERVAL 100 DAY)
  WHERE CONF.active_fg = 1) AS p
GROUP BY tcache_database,
 tcache_tablename,
 tcache_recipient_processname,
 days_before2check;