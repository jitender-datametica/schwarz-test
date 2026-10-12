CREATE OR REPLACE VIEW ldl_p_lew_process.v_lc_prtcl_new_process_runstate AS SELECT BASE.tcache_database,
 BASE.tcache_tablename,
 BASE.tcache_recipient_processname,
 BASE.tcache_processcontainer,
 BASE.context_area_type,
 BASE.context_area,
 BASE.context_load_id,
 BASE.ready_ts,
 MC.updated_ts,
 COALESCE(BASE.ready_ts, MC.updated_ts) AS last_touched_ts,
 SUM(1) OVER (PARTITION BY BASE.tcache_database, BASE.tcache_tablename, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_wait4total,
 SUM(CASE
   WHEN BASE.ready_ts IS NULL
   THEN 0
   ELSE 1
   END) OVER (PARTITION BY BASE.tcache_database, BASE.tcache_tablename, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_ready,
 SUM(CASE
   WHEN BASE.ready_ts IS NULL
   THEN 1
   ELSE 0
   END) OVER (PARTITION BY BASE.tcache_database, BASE.tcache_tablename, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS cnt_wait4pending,
  CASE
  WHEN (SUM(CASE
      WHEN BASE.ready_ts IS NULL
      THEN 1
      ELSE 0
      END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
  THEN 0
  ELSE 1
  END AS ctx_open_fg,
  CASE
  WHEN (SUM(CASE
      WHEN BASE.ready_ts IS NULL
      THEN 0
      ELSE 1
      END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
       RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
  THEN 1
  ELSE 0
  END AS ctx_started_fg,
 MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS before_success_state,
  CASE
  WHEN CASE
    WHEN (SUM(CASE
        WHEN BASE.ready_ts IS NULL
        THEN 0
        ELSE 1
        END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
    THEN 1
    ELSE 0
    END = 1
  THEN CASE
   WHEN CASE
       WHEN (SUM(CASE
           WHEN BASE.ready_ts IS NULL
           THEN 1
           ELSE 0
           END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
       THEN 0
       ELSE 1
       END = 1 AND COALESCE(MC.fllwing_ctx_has_started, 0) = 1 AND MC.hours_since_last_update > 4
   THEN 'broken'
   WHEN CASE
      WHEN (SUM(CASE
          WHEN BASE.ready_ts IS NULL
          THEN 1
          ELSE 0
          END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
      THEN 0
      ELSE 1
      END = 1 AND (COALESCE(MC.fllwing_ctx_has_started, 0) = 0 OR COALESCE(MC.fllwing_ctx_has_started, 0) = 1 AND MC.hours_since_last_update
         <= 4)
   THEN 'possibly running or broken'
   ELSE 'ready'
   END
  ELSE MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  END AS ctx_state_new,
 BASE.delete_ts AS tcache_deleted_since,
  CASE
  WHEN (MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
         RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'reload' OR SUBSTR((MAX(BASE.success_state) OVER
        (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING) RANGE BETWEEN
        UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), 1, 11) = 'waiting_for' OR (MAX(BASE.success_state) OVER (PARTITION BY
        BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING) RANGE BETWEEN
      UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'broken'
  THEN 'yes'
  ELSE 'no'
  END AS is_before_state_protected,
  CASE
  WHEN BASE.delete_ts IS NULL AND CASE
      WHEN (MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'reload' OR SUBSTR((MAX(BASE.success_state)
           OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), 1, 11) = 'waiting_for' OR (MAX(BASE.success_state
          ) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'broken'
      THEN 'yes'
      ELSE 'no'
      END = 'yes' AND CASE
     WHEN CASE
       WHEN (SUM(CASE
           WHEN BASE.ready_ts IS NULL
           THEN 0
           ELSE 1
           END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
       THEN 1
       ELSE 0
       END = 1
     THEN CASE
      WHEN CASE
          WHEN (SUM(CASE
              WHEN BASE.ready_ts IS NULL
              THEN 1
              ELSE 0
              END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
          THEN 0
          ELSE 1
          END = 1 AND COALESCE(MC.fllwing_ctx_has_started, 0) = 1 AND MC.hours_since_last_update > 4
      THEN 'broken'
      WHEN CASE
         WHEN (SUM(CASE
             WHEN BASE.ready_ts IS NULL
             THEN 1
             ELSE 0
             END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
         THEN 0
         ELSE 1
         END = 1 AND (COALESCE(MC.fllwing_ctx_has_started, 0) = 0 OR COALESCE(MC.fllwing_ctx_has_started, 0) = 1 AND MC
           .hours_since_last_update <= 4)
      THEN 'possibly running or broken'
      ELSE 'ready'
      END
     ELSE MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
     END = 'ready'
  THEN 'ready'
  WHEN BASE.delete_ts IS NULL AND CASE
      WHEN (MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'reload' OR SUBSTR((MAX(BASE.success_state)
           OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), 1, 11) = 'waiting_for' OR (MAX(BASE.success_state
          ) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 'broken'
      THEN 'yes'
      ELSE 'no'
      END = 'yes' AND CASE
     WHEN CASE
       WHEN (SUM(CASE
           WHEN BASE.ready_ts IS NULL
           THEN 0
           ELSE 1
           END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
       THEN 1
       ELSE 0
       END = 1
     THEN CASE
      WHEN CASE
          WHEN (SUM(CASE
              WHEN BASE.ready_ts IS NULL
              THEN 1
              ELSE 0
              END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
               RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
          THEN 0
          ELSE 1
          END = 1 AND COALESCE(MC.fllwing_ctx_has_started, 0) = 1 AND MC.hours_since_last_update > 4
      THEN 'broken'
      WHEN CASE
         WHEN (SUM(CASE
             WHEN BASE.ready_ts IS NULL
             THEN 1
             ELSE 0
             END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
              RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
         THEN 0
         ELSE 1
         END = 1 AND (COALESCE(MC.fllwing_ctx_has_started, 0) = 0 OR COALESCE(MC.fllwing_ctx_has_started, 0) = 1 AND MC
           .hours_since_last_update <= 4)
      THEN 'possibly running or broken'
      ELSE 'ready'
      END
     ELSE MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
     END <> 'ready'
  THEN MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
     RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
  WHEN BASE.delete_ts IS NOT NULL
  THEN 'unusable'
  ELSE CASE
   WHEN CASE
     WHEN (SUM(CASE
         WHEN BASE.ready_ts IS NULL
         THEN 0
         ELSE 1
         END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
          RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) > 0
     THEN 1
     ELSE 0
     END = 1
   THEN CASE
    WHEN CASE
        WHEN (SUM(CASE
            WHEN BASE.ready_ts IS NULL
            THEN 1
            ELSE 0
            END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
             RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
        THEN 0
        ELSE 1
        END = 1 AND COALESCE(MC.fllwing_ctx_has_started, 0) = 1 AND MC.hours_since_last_update > 4
    THEN 'broken'
    WHEN CASE
       WHEN (SUM(CASE
           WHEN BASE.ready_ts IS NULL
           THEN 1
           ELSE 0
           END) OVER (PARTITION BY BASE.tcache_processcontainer, BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
            RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0
       THEN 0
       ELSE 1
       END = 1 AND (COALESCE(MC.fllwing_ctx_has_started, 0) = 0 OR COALESCE(MC.fllwing_ctx_has_started, 0) = 1 AND MC.hours_since_last_update
          <= 4)
    THEN 'possibly running or broken'
    ELSE 'ready'
    END
   ELSE MAX(BASE.success_state) OVER (PARTITION BY BASE.context_area_type, BASE.context_area, CAST(BASE.context_load_id AS STRING)
      RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
   END
  END AS ctx_state
FROM ldl_p_lew_process.v_lc_prtcl_generic_base AS BASE
 LEFT JOIN ldl_p_lew_process.v_lc_prtcl_main_contexts AS MC ON BASE.context_load_id = MC.context_load_id AND BASE.processcontainer
    = MC.processcontainer
WHERE BASE.active_fg = 1;