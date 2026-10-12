CREATE OR REPLACE VIEW P_LEW_PROCESS.V_LC_PRTCL_NEW_CONTEXTS_AS_FOUND
AS
   select b.context_area_type,
   b.context_area,
   b.context_load_id,
   max(real_fllwng_context_load_id) over (partition by b.context_load_id) fllwng_context_load_id
from (
    select a.*,
   min(a.context_load_id) over (partition by 1 order by a.last_ready_ts_per_context rows between 1 following and 1 following) fllwng_context_load_id,
   case when a.context_load_id<>fllwng_context_load_id then fllwng_context_load_id end real_fllwng_context_load_id
           from (
                   select pr_ready.context_area_type,
   pr_ready.context_area,
   pr_ready.context_load_id,
   max(ready_ts) last_ready_ts_per_context,
   max(delete_ts) last_delete_ts_per_context
                   from p_lew_process.t_lc_prtcl_tcache_recipients pr_ready
   LEFT OUTER join p_lew_process.t_lc_prtcl_tcache_delete_process pr_deleted
   ON pr_ready.tcache_database=pr_deleted.tcache_database
   and pr_ready.tcache_tablename=pr_deleted.tcache_tablename
   and pr_ready.context_area_type=pr_deleted.context_area_type
   and pr_ready.context_area=pr_deleted.context_area
   and pr_ready.context_load_id=pr_deleted.context_load_id
where pr_deleted.tcache_tablename is null or ready_ts>delete_ts
group by 1,2,3
) a
) b
;