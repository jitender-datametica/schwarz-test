CREATE OR REPLACE VIEW P_LEW_PROCESS.V_LC_PRTCL_GENERIC_BASE_2
AS
SELECT
ctx.context_area_type,
ctx.context_area,
ctx.context_load_id,
ctx.processcontainer,
ctx.success_state,
ctx.ctx_has_started_fg,
ctx.updated_ts,
conf.tcache_tablename,
conf.tcache_database,
conf.tcache_recipient_processname,
conf.tcache_processcontainer,
conf.active_fg,
conf.refreshed_ts,
conf.created_ts,
pr_ready.ready_ts,
pr_deleted.delete_ts
FROM p_lew_process.v_lc_prtcl_all_contexts_2 ctx --Alle durch Stager oder sonstwen definierten Kontexte, basierend auf CTX_LID aus "t_lc_prtcl_context_tasks_2" und zugehöriger Länderauffächerung
   -- Blähe jeden Context um die als zugehörig definierte Prozesswolke (aus dem Prozesscontainer) auf.
   -- In der Konfig-Tabelle ist jedem Prozesscontainer die Menge an zugeordneten Prozessen hinterlegt
INNER JOIN p_lew_process.t_lc_conf_tcache_recipients_2 conf
ON ctx.processcontainer=conf.tcache_processcontainer
   -- addiere zu jedem konfigurierten Prozess seine SUCCESS-Information - falls vorhanden
LEFT OUTER JOIN p_lew_process.t_lc_prtcl_tcache_recipients_2 pr_ready
ON ctx.context_area_type=pr_ready.context_area_type
   AND ctx.context_area=pr_ready.context_area
   AND ctx.context_load_id=pr_ready.context_load_id
   AND UPPER(conf.tcache_database)=UPPER(pr_ready.tcache_database)
   AND UPPER(conf.tcache_tablename)=UPPER(pr_ready.tcache_tablename)
   AND conf.tcache_recipient_processname=pr_ready.tcache_recipient_processname
   -- addiere zu jedem konfigurierten Prozess seine TCACHE-Delete-Information - falls vorhanden
LEFT OUTER JOIN p_lew_process.t_lc_prtcl_tcache_delete_process_2 pr_deleted
ON UPPER(conf.tcache_database)=UPPER(pr_deleted.tcache_database)
   AND UPPER(conf.tcache_tablename)=UPPER(pr_deleted.tcache_tablename)
   AND ctx.context_area_type=pr_deleted.context_area_type
   AND ctx.context_area=pr_deleted.context_area
   AND ctx.context_load_id=pr_deleted.context_load_id
;



