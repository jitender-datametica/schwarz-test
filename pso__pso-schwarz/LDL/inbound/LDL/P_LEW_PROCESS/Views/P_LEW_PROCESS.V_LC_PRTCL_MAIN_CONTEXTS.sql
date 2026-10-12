CREATE OR REPLACE VIEW P_LEW_PROCESS.V_LC_PRTCL_MAIN_CONTEXTS
AS
   SELECT context_load_id,
   processcontainer,
   updated_ts,
   main_success_state,
   loader_plan_touched_fg main_ctx_has_started_fg,
   MAX(context_load_id) OVER (PARTITION BY processcontainer ORDER BY loader_plan_touched_fg DESC NULLS LAST, updated_ts ASC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) fllwing_ctx_lid,
   MAX(loader_plan_touched_fg) OVER (PARTITION BY processcontainer ORDER BY loader_plan_touched_fg DESC NULLS LAST, updated_ts ASC ROWS BETWEEN 1 FOLLOWING AND 1 FOLLOWING) fllwing_ctx_has_started,
   CASE WHEN DATEDIFF(DAY, updated_ts, current_timestamp()) > 416 THEN 9999 ELSE DATEDIFF(HOUR, updated_ts, current_timestamp()) END AS HOURS_SINCE_LAST_UPDATE
   FROM
   (
   SELECT context_load_id,
   processcontainer,
   CASE WHEN MAX(stager_plan_state)='free' AND MAX(loader_plan_state)='locked' THEN 1 ELSE 0 END loader_plan_touched_fg,
   MAX(success_state) main_success_state,
   MAX(updated_ts) updated_ts,
   MIN(created_ts) created_ts
   FROM p_lew_process.t_lc_prtcl_context_tasks
   GROUP BY context_load_id,processcontainer
   ) x
;