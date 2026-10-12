CREATE OR REPLACE VIEW ldl_data_etl_process.v_lc_prtcl_delete_tasks_2 AS SELECT deltasks.tcache_database,
 deltasks.tcache_tablename,
 deltasks.tcache_processcontainer,
 deltasks.context_area_type,
 deltasks.context_area,
 deltasks.context_load_id,
 deltasks.`_cnt_wait4pending` AS cnt_wait4pending,
 deltasks.`_last_touched_ts` AS last_touched_ts,
 deltasks.days_after_last_touch,
 deltasks.tcache_deleted_since,
 static_ctx_resolve.country_codes
FROM (SELECT DISTINCT UPPER(tcache_database) AS tcache_database,
   LOWER(tcache_tablename) AS tcache_tablename,
   tcache_processcontainer,
   context_area_type,
   context_area,
   context_load_id,
    CASE
    WHEN ctx_state = 'ready'
    THEN cnt_wait4pending
    ELSE MAX(cnt_wait4pending) OVER (PARTITION BY context_area_type, context_area, CAST(context_load_id AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    END AS `_cnt_wait4pending`,
    CASE
    WHEN ctx_state = 'ready'
    THEN MAX(last_touched_ts) OVER (PARTITION BY tcache_database, tcache_tablename, tcache_processcontainer,
       context_area_type, context_area, CAST(context_load_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
     UNBOUNDED FOLLOWING)
    ELSE MAX(last_touched_ts) OVER (PARTITION BY context_area_type, context_area, CAST(context_load_id AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
    END AS `_last_touched_ts`,
   CAST(FLOOR(TIMESTAMP_DIFF(CAST(CURRENT_TIMESTAMP() AS DATETIME), CASE
        WHEN ctx_state = 'ready'
        THEN MAX(last_touched_ts) OVER (PARTITION BY tcache_database, tcache_tablename, tcache_processcontainer,
           context_area_type, context_area, CAST(context_load_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
         UNBOUNDED FOLLOWING)
        ELSE MAX(last_touched_ts) OVER (PARTITION BY context_area_type, context_area, CAST(context_load_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        END, SECOND) / 86400) AS INTEGER) AS days_after_last_touch,
   MAX(tcache_deleted_since) OVER (PARTITION BY tcache_database, tcache_tablename, tcache_processcontainer,
      context_area_type, context_area, CAST(context_load_id AS STRING) RANGE BETWEEN UNBOUNDED PRECEDING AND
    UNBOUNDED FOLLOWING) AS tcache_deleted_since
  FROM ldl_data_etl_process.v_lc_prtcl_new_process_runstate_2) AS deltasks
 INNER JOIN (SELECT STRING_AGG(TRIM(country_cd), ',' ORDER BY country_cd IS NULL, country_cd) AS country_codes,
   area_grp_type,
   area_cd
  FROM (SELECT DISTINCT client_id,
       '\'' || country_cd || '\'' AS country_cd,
     area_grp_type,
     area_cd
    FROM ldl_data_etl_process.v_etl_context_orga_area_2) AS base
  GROUP BY area_grp_type,
   area_cd) AS static_ctx_resolve ON deltasks.context_area_type = static_ctx_resolve.area_grp_type AND deltasks.context_area
    = static_ctx_resolve.area_cd
WHERE deltasks.tcache_deleted_since IS NULL
 AND UPPER(deltasks.tcache_tablename) <> 'NONE';