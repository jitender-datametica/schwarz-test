CREATE OR REPLACE VIEW P_LEW_PROCESS.V_LC_PRTCL_CALLING_RATE_LAST_DAYS_2
AS
   SELECT p.tcache_database,
   p.tcache_tablename,
   p.tcache_recipient_processname,
   p.days_before2check,
   MAX(p.cnt_calls_possible) AS cnt_calls_possible,
   MAX(p.cnt_calls_real) AS cnt_calls_real
  FROM (
          SELECT conf.tcache_database,
   conf.tcache_tablename,
   conf.tcache_recipient_processname,
   days.days_before2check,
   days.rundate,
   ctx_n_days.context_area_type,
   ctx_n_days.context_area,
   ctx_n_days.context_load_id,
   ctx_n_days.first_ready_ts,
   SUM(CASE WHEN ctx_n_days.context_load_id IS NULL THEN 0 ELSE 1 END)
                    OVER (PARTITION BY conf.tcache_database, conf.tcache_tablename,conf.tcache_recipient_processname
                          ORDER BY days.days_before2check ROWS UNBOUNDED PRECEDING) cnt_calls_possible,
   SUM(CASE WHEN pr_ready.tcache_tablename IS NULL THEN 0 ELSE 1 END)
                    OVER (PARTITION BY conf.tcache_database, conf.tcache_tablename,conf.tcache_recipient_processname
                          ORDER BY days.days_before2check ROWS UNBOUNDED PRECEDING) cnt_calls_real
          FROM p_lew_process.t_lc_conf_tcache_recipients_2 conf
   CROSS JOIN (SELECT
   ROW_NUMBER() OVER (PARTITION BY 1 ORDER BY client_id) AS days_before2check,
   CURRENT_DATE - days_before2check AS rundate
                      FROM p_lew_core.t_client_2
                      ) AS days
   LEFT OUTER JOIN (SELECT pr_ready1.context_area_type,
   pr_ready1.context_area,
   pr_ready1.context_load_id,
   MIN(pr_ready1.ready_ts) AS first_ready_ts,
   MAX(pr_ready1.ready_ts) AS last_ready_ts
                           FROM p_lew_process.t_lc_prtcl_tcache_recipients_2 pr_ready1
   WHERE pr_ready1.ready_ts >= CURRENT_DATE-100
   GROUP BY 1,2,3)    ctx_n_days
   ON CAST(ctx_n_days.first_ready_ts AS DATE) = days.rundate
   LEFT OUTER JOIN p_lew_process.t_lc_prtcl_tcache_recipients_2 pr_ready
   ON pr_ready.tcache_database=conf.tcache_database
   AND pr_ready.tcache_tablename=conf.tcache_tablename
   AND pr_ready.tcache_recipient_processname=conf.tcache_recipient_processname
   AND pr_ready.context_area_type=ctx_n_days.context_area_type
   AND pr_ready.context_area=ctx_n_days.context_area
   AND pr_ready.context_load_id=ctx_n_days.context_load_id
WHERE conf.active_fg=1
  AND pr_ready.ready_ts >= CURRENT_DATE-100
) p
GROUP BY p.tcache_database, p.tcache_tablename,p.tcache_recipient_processname,p.days_before2check
;