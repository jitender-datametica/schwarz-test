CREATE OR REPLACE VIEW ldl_data_etl_process.v_lc_prtcl_generic_base AS SELECT CTX.context_area_type,
 CTX.context_area,
 CTX.context_load_id,
 CTX.processcontainer,
 CTX.success_state,
 CTX.ctx_has_started_fg,
 CTX.updated_ts,
 CONF.tcache_tablename,
 CONF.tcache_database,
 CONF.tcache_recipient_processname,
 CONF.tcache_processcontainer,
 CONF.active_fg,
 CONF.refreshed_ts,
 CONF.created_ts,
 PR_READY.ready_ts,
 PR_DELETED.delete_ts
FROM ldl_data_etl_process.v_lc_prtcl_all_contexts AS CTX
 INNER JOIN ldl_data_etl_process.t_lc_conf_tcache_recipients AS CONF ON CTX.processcontainer = CONF.tcache_processcontainer
  
 LEFT JOIN ldl_data_etl_process.t_lc_prtcl_tcache_recipients AS PR_READY ON CTX.context_area_type = PR_READY.context_area_type
        AND CTX.context_area = PR_READY.context_area AND CTX.context_load_id = PR_READY.context_load_id AND UPPER(CONF.tcache_database
      ) = UPPER(PR_READY.tcache_database) AND UPPER(CONF.tcache_tablename) = UPPER(PR_READY.tcache_tablename) AND CONF.tcache_recipient_processname
    = PR_READY.tcache_recipient_processname
 LEFT JOIN ldl_data_etl_process.t_lc_prtcl_tcache_delete_process AS PR_DELETED ON UPPER(CONF.tcache_database) = UPPER(PR_DELETED
       .tcache_database) AND UPPER(CONF.tcache_tablename) = UPPER(PR_DELETED.tcache_tablename) AND CTX.context_area_type
      = PR_DELETED.context_area_type AND CTX.context_area = PR_DELETED.context_area AND CTX.context_load_id = PR_DELETED
   .context_load_id;