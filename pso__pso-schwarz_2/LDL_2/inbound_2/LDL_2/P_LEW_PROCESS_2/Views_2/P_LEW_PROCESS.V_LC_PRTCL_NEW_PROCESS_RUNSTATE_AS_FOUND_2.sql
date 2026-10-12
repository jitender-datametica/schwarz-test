CREATE OR REPLACE VIEW P_LEW_PROCESS.V_LC_PRTCL_NEW_PROCESS_RUNSTATE_AS_FOUND_2
AS
   select conf.tcache_database,
   conf.tcache_tablename,
   conf.tcache_recipient_processname,
   conf.tcache_processcontainer,
   new_ctx.context_area_type,
   new_ctx.context_area,
   new_ctx.context_load_id,
   pr_ready.ready_ts,
   sum(1) over
             (partition by conf.tcache_database, conf.tcache_tablename,new_ctx.context_area_type,new_ctx.context_area,new_ctx.context_load_id) cnt_wait4total,
   sum(case when pr_ready.tcache_tablename is null then 0 else 1 end) over
          (partition by conf.tcache_database, conf.tcache_tablename,new_ctx.context_area_type,new_ctx.context_area,new_ctx.context_load_id) cnt_ready,
   sum(case when pr_ready.tcache_tablename is null then 1 else 0 end) over
             (partition by conf.tcache_database, conf.tcache_tablename,new_ctx.context_area_type,new_ctx.context_area,new_ctx.context_load_id) cnt_wait4pending,
   case when
           sum(case when pr_ready.tcache_tablename is null then 1 else 0 end) over
               (partition by new_ctx.context_area_type,new_ctx.context_area,new_ctx.context_load_id)
         = 0
        then 0
    else 1 end ctx_open_fg,
   case when ctx_open_fg=1 and new_ctx.fllwng_context_load_id is not null then 'broken'
        when ctx_open_fg=1 and new_ctx.fllwng_context_load_id is null then 'possibly running or broken'
   else 'ready' end ctx_state
from p_lew_process.t_lc_conf_tcache_recipients_2 conf
   CROSS join p_lew_process.v_lc_prtcl_new_contexts_as_found_2 new_ctx
   LEFT OUTER join p_lew_process.t_lc_prtcl_tcache_recipients_2 pr_ready
   ON pr_ready.tcache_database=conf.tcache_database
   and pr_ready.tcache_tablename=conf.tcache_tablename
   and pr_ready.tcache_recipient_processname= conf.tcache_recipient_processname
   and pr_ready.context_area_type=new_ctx.context_area_type
   and pr_ready.context_area=new_ctx.context_area
   and pr_ready.context_load_id=new_ctx.context_load_id
where conf.active_fg=1
;