CREATE OR REPLACE VIEW ldl_data_production_etl_process.v_lc_prtcl_generic_base_2 (context_area_type, context_area,
context_load_id, processcontainer, success_state, ctx_has_started_fg, updated_ts, tcache_tablename, tcache_database,
tcache_recipient_processname, tcache_processcontainer, active_fg, refreshed_ts, created_ts, ready_ts, delete_ts) AS
SELECT ctx.context_area_type,
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
FROM ldl_data_production_etl_process.v_lc_prtcl_all_contexts_2 AS ctx
 INNER JOIN ldl_data_production_etl_process.t_lc_conf_tcache_recipients_2 AS conf ON ctx.processcontainer = conf.tcache_processcontainer
  
 LEFT JOIN ldl_data_production_etl_process.t_lc_prtcl_tcache_recipients_2 AS pr_ready ON ctx.context_area_type = pr_ready
       .context_area_type AND ctx.context_area = pr_ready.context_area AND ctx.context_load_id = pr_ready.context_load_id
       AND UPPER(conf.tcache_database) = UPPER(pr_ready.tcache_database) AND UPPER(conf.tcache_tablename) = UPPER(pr_ready
     .tcache_tablename) AND conf.tcache_recipient_processname = pr_ready.tcache_recipient_processname
 LEFT JOIN ldl_data_production_etl_process.t_lc_prtcl_tcache_delete_process_2 AS pr_deleted ON UPPER(conf.tcache_database
       ) = UPPER(pr_deleted.tcache_database) AND UPPER(conf.tcache_tablename) = UPPER(pr_deleted.tcache_tablename) AND
     ctx.context_area_type = pr_deleted.context_area_type AND ctx.context_area = pr_deleted.context_area AND ctx.context_load_id
    = pr_deleted.context_load_id;