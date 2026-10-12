create or replace view LDL_DATA_PRODUCTION.ETL_PROCESS.V_LC_PRTCL_MAIN_CONTEXTS_1(
	CONTEXT_LOAD_ID,
	PROCESSCONTAINER,
	UPDATED_TS,
	MAIN_SUCCESS_STATE,
	MAIN_CTX_HAS_STARTED_FG,
	FLLWING_CTX_LID,
	FLLWING_CTX_HAS_STARTED,
	HOURS_SINCE_LAST_UPDATE
) as
   SELECT context_load_id
   ,processcontainer
   ,updated_ts
   ,main_success_state
   ,loader_plan_touched_fg AS main_ctx_has_started_fg
   ,MAX(context_load_id) OVER (PARTITION BY processcontainer ORDER BY loader_plan_touched_fg DESC NULLS LAST, updated_ts ASC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS fllwing_ctx_lid
   ,MAX(loader_plan_touched_fg) OVER (PARTITION BY processcontainer ORDER BY loader_plan_touched_fg DESC NULLS LAST, updated_ts ASC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) AS fllwing_ctx_has_started
   ,CASE WHEN DATEDIFF(DAY, updated_ts, CURRENT_TIMESTAMP()) > 416 THEN 9999 ELSE DATEDIFF(HOUR, updated_ts, CURRENT_TIMESTAMP()) END AS HOURS_SINCE_LAST_UPDATE
   FROM
   (
   SELECT context_load_id
   ,processcontainer
   ,CASE WHEN MAX(stager_plan_state)='free' AND MAX(loader_plan_state)='locked' THEN 1 ELSE 0 END loader_plan_touched_fg
   ,MAX(success_state) main_success_state
   ,MAX(updated_ts) updated_ts
   ,MIN(created_ts) created_ts
   FROM ETL_PROCESS.t_lc_prtcl_context_tasks_1
   GROUP BY context_load_id,processcontainer
   ) x 
;