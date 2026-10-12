create or replace view LDL_DATA_PRODUCTION.ETL_PROCESS.V_LC_PRTCL_NEW_PROCESS_RUNSTATE_2(
	TCACHE_DATABASE,
	TCACHE_TABLENAME,
	TCACHE_RECIPIENT_PROCESSNAME,
	TCACHE_PROCESSCONTAINER,
	CONTEXT_AREA_TYPE,
	CONTEXT_AREA,
	CONTEXT_LOAD_ID,
	READY_TS,
	UPDATED_TS,
	LAST_TOUCHED_TS,
	CNT_WAIT4TOTAL,
	CNT_READY,
	CNT_WAIT4PENDING,
	CTX_OPEN_FG,
	CTX_STARTED_FG,
	BEFORE_SUCCESS_STATE,
	CTX_STATE_NEW,
	TCACHE_DELETED_SINCE,
	IS_BEFORE_STATE_PROTECTED,
	CTX_STATE
) as
SELECT
base.tcache_database AS tcache_database
,base.tcache_tablename AS tcache_tablename
,base.tcache_recipient_processname AS tcache_recipient_processname
,base.tcache_processcontainer AS tcache_processcontainer
,base.context_area_type AS context_area_type
,base.context_area AS context_area
,base.context_load_id AS context_load_id
,base.ready_ts AS ready_ts
,mc.updated_ts AS updated_ts
,COALESCE(base.ready_ts,mc.updated_ts) AS last_touched_ts
,SUM(1) OVER
                (PARTITION BY base.tcache_database, base.tcache_tablename,base.context_area_type,base.context_area,base.context_load_id) AS cnt_wait4total
,SUM(CASE WHEN base.ready_ts IS NULL THEN 0 ELSE 1 END) OVER
             (PARTITION BY base.tcache_database, base.tcache_tablename,base.context_area_type,base.context_area,base.context_load_id) AS cnt_ready
,SUM(CASE WHEN base.ready_ts IS NULL THEN 1 ELSE 0 END) OVER
                (PARTITION BY base.tcache_database, base.tcache_tablename,base.context_area_type,base.context_area,base.context_load_id) AS cnt_wait4pending
,CASE WHEN
              SUM(CASE WHEN base.ready_ts IS NULL THEN 1 ELSE 0 END) OVER
                  (PARTITION BY base.tcache_processcontainer,base.context_area_type,base.context_area,base.context_load_id)
            = 0
           THEN 0
       ELSE 1 END AS ctx_open_fg
,CASE WHEN
           SUM(CASE WHEN base.ready_ts IS NULL THEN 0 ELSE 1 END) OVER
                 (PARTITION BY base.tcache_processcontainer,base.context_area_type,base.context_area,base.context_load_id)
            > 0
            THEN 1
       ELSE 0 END AS ctx_started_fg
,MAX(base.success_state) OVER (PARTITION BY base.context_area_type,base.context_area,base.context_load_id) AS before_success_state
,CASE WHEN ctx_started_fg=1 THEN
           CASE WHEN ctx_open_fg=1
                     AND COALESCE(mc.fllwing_ctx_has_started,0)=1
                     AND mc.hours_since_last_update>4
                 THEN 'broken'
                WHEN ctx_open_fg=1
                     AND (COALESCE(mc.fllwing_ctx_has_started,0)=0
                          OR COALESCE(mc.fllwing_ctx_has_started,0)=1
                             AND mc.hours_since_last_update<=4)
                 THEN 'possibly running or broken'
           ELSE 'ready' END
      ELSE before_success_state END AS ctx_state_new
,base.delete_ts AS tcache_deleted_since
,CASE WHEN before_success_state = 'reload' OR SUBSTR( before_success_state, 1, 11) = 'waiting_for' OR before_success_state = 'broken'
THEN 'yes'
ELSE 'no' END AS is_before_state_protected
,CASE
           WHEN base.delete_ts IS NULL AND is_before_state_protected='yes' AND ctx_state_new='ready' THEN 'ready'
           WHEN base.delete_ts IS NULL AND is_before_state_protected='yes' AND ctx_state_new<>'ready' THEN before_success_state
           WHEN base.delete_ts IS NOT NULL THEN 'unusable'
      ELSE ctx_state_new END AS ctx_state
FROM ETL_PROCESS.v_lc_prtcl_generic_base_2 base
LEFT OUTER JOIN ETL_PROCESS.v_lc_prtcl_main_contexts_2 mc
ON mc.context_load_id=base.context_load_id
   AND mc.processcontainer=base.processcontainer
WHERE base.active_fg=1 
;