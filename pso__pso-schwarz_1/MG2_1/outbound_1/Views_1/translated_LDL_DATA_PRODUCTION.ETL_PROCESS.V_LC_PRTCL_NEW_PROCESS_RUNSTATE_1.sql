CREATE OR REPLACE VIEW ldl_data_production_etl_process.v_lc_prtcl_new_process_runstate_1 (tcache_database,
tcache_tablename, tcache_recipient_processname, tcache_processcontainer, context_area_type, context_area,
context_load_id, ready_ts, updated_ts, last_touched_ts, cnt_wait4total, cnt_ready, cnt_wait4pending, ctx_open_fg,
ctx_started_fg, before_success_state, ctx_state_new, tcache_deleted_since, is_before_state_protected, ctx_state) AS
SELECT base.tcache_database,
 base.tcache_tablename,
 base.tcache_recipient_processname,
 base.tcache_processcontainer,
 base.context_area_type,
 base.context_area,
 base.context_load_id,
 base.ready_ts,
 mc.updated_ts,
 COALESCE(base.ready_ts, mc.updated_ts) AS last_touched_ts,
 SUM(1) OVER (PARTITION BY base.tcache_database, base.tcache_tablename, base.context_area_type, base.context_area, base
    .context_load_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_wait4total,
 SUM(CASE
   WHEN base.ready_ts IS NULL
   THEN 0
   ELSE 1
   END) OVER (PARTITION BY base.tcache_database, base.tcache_tablename, base.context_area_type, base.context_area, base
    .context_load_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_ready,
 SUM(CASE
   WHEN base.ready_ts IS NULL
   THEN 1
   ELSE 0
   END) OVER (PARTITION BY base.tcache_database, base.tcache_tablename, base.context_area_type, base.context_area, base
    .context_load_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_wait4pending,
  CASE
  WHEN (SUM(CASE
      WHEN base.ready_ts IS NULL
      THEN 1
      ELSE 0
      END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
  THEN 0
  ELSE 1
  END AS ctx_open_fg,
  CASE
  WHEN (SUM(CASE
      WHEN base.ready_ts IS NULL
      THEN 0
      ELSE 1
      END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
  THEN 1
  ELSE 0
  END AS ctx_started_fg,
 MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
  RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS before_success_state,
  CASE
  WHEN CASE
    WHEN (SUM(CASE
        WHEN base.ready_ts IS NULL
        THEN 0
        ELSE 1
        END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
    THEN 1
    ELSE 0
    END = 1
  THEN CASE
   WHEN CASE
       WHEN (SUM(CASE
           WHEN base.ready_ts IS NULL
           THEN 1
           ELSE 0
           END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
       THEN 0
       ELSE 1
       END = 1 AND COALESCE(mc.fllwing_ctx_has_started, 0) = 1 AND mc.hours_since_last_update > 4
   THEN 'broken'
   WHEN CASE
      WHEN (SUM(CASE
          WHEN base.ready_ts IS NULL
          THEN 1
          ELSE 0
          END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
      THEN 0
      ELSE 1
      END = 1 AND (COALESCE(mc.fllwing_ctx_has_started, 0) = 0 OR COALESCE(mc.fllwing_ctx_has_started, 0) = 1 AND mc.hours_since_last_update
         <= 4)
   THEN 'possibly running or broken'
   ELSE 'ready'
   END
  ELSE MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
   RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  END AS ctx_state_new,
 base.delete_ts AS tcache_deleted_since,
  CASE
  WHEN (MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'reload' OR SUBSTR((MAX(base.success_state) OVER (PARTITION BY
          base.context_area_type, base.context_area, base.context_load_id RANGE BETWEEN UNBOUNDED PRECEDING AND
        UNBOUNDED FOLLOWING)), 1, 11) = 'waiting_for' OR (MAX(base.success_state) OVER (PARTITION BY base.context_area_type
        , base.context_area, base.context_load_id RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'broken'
    
  THEN 'yes'
  ELSE 'no'
  END AS is_before_state_protected,
  CASE
  WHEN base.delete_ts IS NULL AND CASE
      WHEN (MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'reload' OR SUBSTR((MAX(base.success_state)
           OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id RANGE BETWEEN
            UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), 1, 11) = 'waiting_for' OR (MAX(base.success_state) OVER (PARTITION BY
            base.context_area_type, base.context_area, base.context_load_id RANGE BETWEEN UNBOUNDED PRECEDING AND
          UNBOUNDED FOLLOWING)) = 'broken'
      THEN 'yes'
      ELSE 'no'
      END = 'yes' AND CASE
     WHEN CASE
       WHEN (SUM(CASE
           WHEN base.ready_ts IS NULL
           THEN 0
           ELSE 1
           END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
       THEN 1
       ELSE 0
       END = 1
     THEN CASE
      WHEN CASE
          WHEN (SUM(CASE
              WHEN base.ready_ts IS NULL
              THEN 1
              ELSE 0
              END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
          THEN 0
          ELSE 1
          END = 1 AND COALESCE(mc.fllwing_ctx_has_started, 0) = 1 AND mc.hours_since_last_update > 4
      THEN 'broken'
      WHEN CASE
         WHEN (SUM(CASE
             WHEN base.ready_ts IS NULL
             THEN 1
             ELSE 0
             END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
         THEN 0
         ELSE 1
         END = 1 AND (COALESCE(mc.fllwing_ctx_has_started, 0) = 0 OR COALESCE(mc.fllwing_ctx_has_started, 0) = 1 AND mc
           .hours_since_last_update <= 4)
      THEN 'possibly running or broken'
      ELSE 'ready'
      END
     ELSE MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
     END = 'ready'
  THEN 'ready'
  WHEN base.delete_ts IS NULL AND CASE
      WHEN (MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'reload' OR SUBSTR((MAX(base.success_state)
           OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id RANGE BETWEEN
            UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), 1, 11) = 'waiting_for' OR (MAX(base.success_state) OVER (PARTITION BY
            base.context_area_type, base.context_area, base.context_load_id RANGE BETWEEN UNBOUNDED PRECEDING AND
          UNBOUNDED FOLLOWING)) = 'broken'
      THEN 'yes'
      ELSE 'no'
      END = 'yes' AND CASE
     WHEN CASE
       WHEN (SUM(CASE
           WHEN base.ready_ts IS NULL
           THEN 0
           ELSE 1
           END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
       THEN 1
       ELSE 0
       END = 1
     THEN CASE
      WHEN CASE
          WHEN (SUM(CASE
              WHEN base.ready_ts IS NULL
              THEN 1
              ELSE 0
              END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
          THEN 0
          ELSE 1
          END = 1 AND COALESCE(mc.fllwing_ctx_has_started, 0) = 1 AND mc.hours_since_last_update > 4
      THEN 'broken'
      WHEN CASE
         WHEN (SUM(CASE
             WHEN base.ready_ts IS NULL
             THEN 1
             ELSE 0
             END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
         THEN 0
         ELSE 1
         END = 1 AND (COALESCE(mc.fllwing_ctx_has_started, 0) = 0 OR COALESCE(mc.fllwing_ctx_has_started, 0) = 1 AND mc
           .hours_since_last_update <= 4)
      THEN 'possibly running or broken'
      ELSE 'ready'
      END
     ELSE MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
     END <> 'ready'
  THEN MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
   RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  WHEN base.delete_ts IS NOT NULL
  THEN 'unusable'
  ELSE CASE
   WHEN CASE
     WHEN (SUM(CASE
         WHEN base.ready_ts IS NULL
         THEN 0
         ELSE 1
         END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
     THEN 1
     ELSE 0
     END = 1
   THEN CASE
    WHEN CASE
        WHEN (SUM(CASE
            WHEN base.ready_ts IS NULL
            THEN 1
            ELSE 0
            END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
        THEN 0
        ELSE 1
        END = 1 AND COALESCE(mc.fllwing_ctx_has_started, 0) = 1 AND mc.hours_since_last_update > 4
    THEN 'broken'
    WHEN CASE
       WHEN (SUM(CASE
           WHEN base.ready_ts IS NULL
           THEN 1
           ELSE 0
           END) OVER (PARTITION BY base.tcache_processcontainer, base.context_area_type, base.context_area, base.context_load_id
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
       THEN 0
       ELSE 1
       END = 1 AND (COALESCE(mc.fllwing_ctx_has_started, 0) = 0 OR COALESCE(mc.fllwing_ctx_has_started, 0) = 1 AND mc.hours_since_last_update
          <= 4)
    THEN 'possibly running or broken'
    ELSE 'ready'
    END
   ELSE MAX(base.success_state) OVER (PARTITION BY base.context_area_type, base.context_area, base.context_load_id
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   END
  END AS ctx_state
FROM ldl_data_production_etl_process.v_lc_prtcl_generic_base_1 AS base
 LEFT JOIN ldl_data_production_etl_process.v_lc_prtcl_main_contexts_1 AS mc ON base.context_load_id = mc.context_load_id
  AND base.processcontainer = mc.processcontainer
WHERE base.active_fg = 1;