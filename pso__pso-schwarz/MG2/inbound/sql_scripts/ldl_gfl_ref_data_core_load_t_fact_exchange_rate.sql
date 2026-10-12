truncate table core_dim.T_FACT_EXCHANGE_RATE;
insert into core_dim.t_fact_exchange_rate (src_curr_cd, tgt_curr_cd, exchange_rate_type_cd, active_from_dt, active_to_dt, active_fg, bus_year, exchange_rate, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
select src_curr_cd,
       tgt_curr_cd,
       exchange_rate_type_cd,
       dwh_valid_from_tmsp,
       dwh_valid_to_tmsp,
       dwh_valid_fg,
       case when day(dwh_valid_from_tmsp) = 1
             and month(dwh_valid_from_tmsp) = 3
             and day(dwh_valid_to_tmsp) in (28, 29)
             and month(dwh_valid_to_tmsp) = 2
            then year(dwh_valid_from_tmsp)
            else 0
        end as bus_year,    
       exchange_rate,
       current_timestamp,
       current_timestamp,
       ${LOAD_ID},
       'P_LEW_CORE'
  from core_rel.t_exchange_rate
;
