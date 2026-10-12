create or replace view LDL_DATA_PRODUCTION.ETL_PROCESS.V_LC_PRTCL_GENERIC_BASE_1(
	CONTEXT_AREA_TYPE,
	CONTEXT_AREA,
	CONTEXT_LOAD_ID,
	PROCESSCONTAINER,
	SUCCESS_STATE,
	CTX_HAS_STARTED_FG,
	UPDATED_TS,
	TCACHE_TABLENAME,
	TCACHE_DATABASE,
	TCACHE_RECIPIENT_PROCESSNAME,
	TCACHE_PROCESSCONTAINER,
	ACTIVE_FG,
	REFRESHED_TS,
	CREATED_TS,
	READY_TS,
	DELETE_TS
) as
SELECT
ctx.context_area_type AS context_area_type
,ctx.context_area AS context_area
,ctx.context_load_id AS context_load_id
,ctx.processcontainer AS processcontainer
,ctx.success_state AS success_state
,ctx.ctx_has_started_fg AS ctx_has_started_fg
,ctx.updated_ts AS updated_ts
,conf.tcache_tablename AS tcache_tablename
,conf.tcache_database AS tcache_database
,conf.tcache_recipient_processname AS tcache_recipient_processname
,conf.tcache_processcontainer AS tcache_processcontainer
,conf.active_fg AS active_fg
,conf.refreshed_ts AS refreshed_ts
,conf.created_ts AS created_ts
,pr_ready.ready_ts AS ready_ts
,pr_deleted.delete_ts AS delete_ts
FROM ETL_PROCESS.v_lc_prtcl_all_contexts_1 ctx 

INNER JOIN ETL_PROCESS.t_lc_conf_tcache_recipients_1 conf
ON ctx.processcontainer=conf.tcache_processcontainer

LEFT OUTER JOIN ETL_PROCESS.t_lc_prtcl_tcache_recipients_1 pr_ready
ON ctx.context_area_type=pr_ready.context_area_type
   AND ctx.context_area=pr_ready.context_area
   AND ctx.context_load_id=pr_ready.context_load_id
   AND UPPER(conf.tcache_database)=UPPER(pr_ready.tcache_database)
   AND UPPER(conf.tcache_tablename)=UPPER(pr_ready.tcache_tablename)
   AND conf.tcache_recipient_processname=pr_ready.tcache_recipient_processname

LEFT OUTER JOIN ETL_PROCESS.t_lc_prtcl_tcache_delete_process_1 pr_deleted
ON UPPER(conf.tcache_database)=UPPER(pr_deleted.tcache_database)
   AND UPPER(conf.tcache_tablename)=UPPER(pr_deleted.tcache_tablename)
   AND ctx.context_area_type=pr_deleted.context_area_type
   AND ctx.context_area=pr_deleted.context_area
   AND ctx.context_load_id=pr_deleted.context_load_id 
;