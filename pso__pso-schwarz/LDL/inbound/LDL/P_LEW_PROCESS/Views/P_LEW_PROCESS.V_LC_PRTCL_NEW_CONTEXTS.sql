CREATE OR REPLACE VIEW P_LEW_PROCESS.V_LC_PRTCL_NEW_CONTEXTS
AS
   select c.context_area_type,
   c.context_area,
   c.context_load_id,
   c.processcontainer,
   c.success_state,
   c.fllwngctx_lid,
   coalesce(fllwing_ctx.fllwing_ctx_has_started,0) fllwing_ctx_has_started
from
(select b.context_area_type,
   b.context_area,
   b.context_load_id,
   b.processcontainer,
   b.success_state,
   max(real_fllwngctx_lid) over (partition by b.context_load_id) fllwngctx_lid
from (
    select a.*,
   min(a.context_load_id) over (partition by a.processcontainer order by a.last_ready_ts_per_context rows between 1 following and 1 following) fllwngctx_lid,
   case when a.context_load_id<>fllwngctx_lid then fllwngctx_lid end real_fllwngctx_lid
               from (
                       select ctx.context_area_type,
   ctx.context_area,
   ctx.context_load_id,
   ctx.processcontainer,
   max(ctx.success_state) success_state,
   max(updated_ts) last_ready_ts_per_context,
   max(delete_ts) last_delete_ts_per_context
from p_lew_process.v_lc_prtcl_all_contexts ctx
   INNER join p_lew_process.t_lc_conf_tcache_recipients conf
   ON ctx.processcontainer=conf.tcache_processcontainer
   LEFT OUTER join p_lew_process.t_lc_prtcl_tcache_recipients pr_ready
   ON ctx.context_area_type=pr_ready.context_area_type
   and ctx.context_area=pr_ready.context_area
   and ctx.context_load_id=pr_ready.context_load_id
   and conf.tcache_database=pr_ready.tcache_database
   and conf.tcache_tablename=pr_ready.tcache_tablename
   and conf.tcache_recipient_processname=pr_ready.tcache_recipient_processname
   LEFT OUTER join p_lew_process.t_lc_prtcl_tcache_delete_process pr_deleted
   ON pr_ready.tcache_database=pr_deleted.tcache_database
   and pr_ready.tcache_tablename=pr_deleted.tcache_tablename
   and ctx.context_area_type=pr_deleted.context_area_type
   and ctx.context_area=pr_deleted.context_area
   and ctx.context_load_id=pr_deleted.context_load_id
where pr_deleted.tcache_tablename is null or ready_ts>delete_ts
group by 1,2,3,4
) a
) b
) c
   LEFT join
   (select ctx.context_load_id,
   max(case ctx.success_state
            when 'raw' THEN 0
       else 1
       end) fllwing_ctx_has_started
from p_lew_process.v_lc_prtcl_all_contexts ctx
   group by 1
 ) fllwing_ctx
   ON c.fllwngctx_lid=fllwing_ctx.context_load_id
;