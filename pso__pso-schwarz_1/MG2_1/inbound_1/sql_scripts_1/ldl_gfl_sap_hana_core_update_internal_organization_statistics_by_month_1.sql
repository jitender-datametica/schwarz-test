/* Update curr_stat_fg for previosly loaded data
*/


UPDATE core_rel.t_internal_organization_statistics_by_month_1
SET curr_stat_fg = 0, 
    dwh_updated_tmsp = CURRENT_TIMESTAMP
WHERE dwh_load_id != ${LOAD_ID} AND curr_stat_fg = 1
      AND (int_org_sid, cal_month, stat_type_cd)
       IN ( 
            SELECT int_org_sid, cal_month, stat_type_cd 
            FROM 
            etl.t_ts_tcache_saphana_lpa906901_2_internal_organization_statistics_by_month__
           )
;
