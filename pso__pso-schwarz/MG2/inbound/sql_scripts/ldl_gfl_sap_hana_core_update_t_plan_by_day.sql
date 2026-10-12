
BEGIN TRANSACTION;
/* Deactivate (set END_DATE to) plan values associated with the dummy StoreNumbers that now are mapped to real StoreNumbers */
/*
MERGE into core_rel.T_PLAN_BY_DAY trg
USING 
(
    with 
    ajustest_store_nrs(country_cd, old_store_nr, is_real_store, new_store_nr) as
    (
        -- TODO: replace this CTE with a SELECT from the source dataset 
		-- SELECT * FROM <src> WHERE is_real_store = 0 and new_store_nr is not null 
        select 'DE', 3618, 1, null from dual
        union all
        select 'ES', 2161, 1, null from dual
        union all
        select 'GB', 87069, 0, 812 from dual
        
    )
    ,curr_bus_year as
    (
        select cd2.cal_dt, cd2.bus_year
        from core_dim.t_dim_calendar_date cd1
            join core_dim.t_dim_calendar_date cd2
                    on cd2.bus_year = cd1.bus_year
        where cd1.cal_dt = current_date
    )
    select 
        pbd.int_org_sid
        ,pbd.plan_pos_nr
        ,pbd.cal_dt
        ,pbd.PLANNED_VAL_TYPE_SID
    from core_rel.t_plan_by_day pbd 
    
        -- these joins are actually filters that narrow T_PLAN_BY_DAY down to the rows we want to update
        -- We want only Plan Revenue for Sales/Delivery Companies, for the current business year
        join meta.t_planned_value_type_key pvt_k
                on pvt_k.planned_val_type_sid = pbd.planned_val_type_sid
                and pvt_k.planned_val_type_nat_key_nr in ('157|WH_DLV', '157|WH_SLS')
        
        join meta.t_party_key comp_k 
                on comp_k.party_sid = pbd.int_org_sid
                and comp_k.party_key_type_cd = 'COMPANY'
    
        join curr_bus_year cby
                on cby.cal_dt = pbd.cal_dt
        
        join ajustest_store_nrs asn
                on to_char(asn.old_store_nr) = pbd.PLAN_POS_NR
                and asn.country_cd = substr(comp_k.party_nat_key_nr, 1, 2)
				
		-- make sure a SID exists for the new store, so we can transfer the plan value to this SID
		join meta.t_party_key st_k
			on st_k.party_nat_key_nr = asn.country_cd||'|'||to_number(asn.new_store_nr)
			and st_k.party_key_type_cd = 'STORE'
			
    WHERE 1=1
        and pbd.DWH_VALID_FG = TRUE
) src
on trg.int_org_sid = src.int_org_sid
    and trg.plan_pos_nr = src.plan_pos_nr
    and trg.cal_dt = src.cal_dt
    and trg.planned_val_type_sid = src.planned_val_type_sid
    and trg.dwh_valid_fg = TRUE
WHEN MATCHED THEN 
    UPDATE SET
        trg.DWH_VALID_FG = FALSE
        ,trg.DWH_VALID_TO_TMSP = dateadd('ns', -1, current_timestamp) -- TODO: set this to ETL exec time - 1ns
        ,trg.DWH_UPDATED_TMSP = current_timestamp -- TODO: set this to ETL exec time
;

*/
/*Insert the deactivated plan values, but this time they are linked to a SID of a real Store*/
/*
INSERT 
into core_rel.T_PLAN_BY_DAY
(
    INT_ORG_SID
    ,INT_ORG_TYPE_CD
    ,REAL_ESTATE_SID
    ,CAL_DT
    ,PLANNED_VAL_TYPE_SID
    ,PLAN_POS_NR
    ,DWH_VALID_FROM_TMSP
    ,DWH_VALID_TO_TMSP
    ,DWH_VALID_FG
    ,PLANNED_KPI_MEAS
    ,DWH_CREATED_TMSP
    ,DWH_UPDATED_TMSP
    ,DWH_LOAD_ID
    ,DWH_NODE_CD
)
with 
ajustest_store_nrs(country_cd, old_store_nr, is_real_store, new_store_nr) as
(
    -- select * from <src> where is_real_store = 0 and new_store_nr is not null 
    select 'DE', 3618, 1, null from dual
    union all
    select 'ES', 2161, 1, null from dual
    union all
    select 'GB', 87069, 0, 812 from dual
    
)
,curr_bus_year as
(
    select cd2.cal_dt, cd2.bus_year
    from core_dim.t_dim_calendar_date cd1
        join core_dim.t_dim_calendar_date cd2
                on cd2.bus_year = cd1.bus_year
    where cd1.cal_dt = current_date
)

select 
    st_k.party_sid                      as INT_ORG_SID
    ,st_k.PARTY_KEY_TYPE_CD             as INT_ORG_TYPE_CD
    ,-1                                 as REAL_ESTATE_SID
    ,pbd.CAL_DT
    ,pvt_k_st.PLANNED_VAL_TYPE_SID
    ,to_number(asn.new_store_nr)        as PLAN_POS_NR -- make sure we remove leading zeros
    ,current_timestamp                  as DWH_VALID_FROM_TMSP  -- TODO: set this to ETL exec time
    ,'9999-12-31 23:59:59.999999999'    as DWH_VALID_TO_TMSP
    ,TRUE                               as DWH_VALID_FG
    ,pbd.PLANNED_KPI_MEAS
    ,current_timestamp                  as DWH_CREATED_TMSP
    ,current_timestamp                  as DWH_UPDATED_TMSP
    ,-1                                 as DWH_LOAD_ID -- TODO: Set this from ETL job
    ,pbd.DWH_NODE_CD
from core_rel.t_plan_by_day pbd 

    -- these joins are actually filters that narrow T_PLAN_BY_DAY down to the rows we want to update
    -- We want only Plan Revenue for Sales/Delivery Companies, for the current business year
    join meta.t_planned_value_type_key pvt_k
            on pvt_k.planned_val_type_sid = pbd.planned_val_type_sid
            and pvt_k.planned_val_type_nat_key_nr in ('157|WH_DLV', '157|WH_SLS')
    
    join meta.t_party_key comp_k 
            on comp_k.party_sid = pbd.int_org_sid
            and comp_k.party_key_type_cd = 'COMPANY'

    join curr_bus_year cby
            on cby.cal_dt = pbd.cal_dt
    
    join ajustest_store_nrs asn
            on to_char(asn.old_store_nr) = pbd.PLAN_POS_NR
            and asn.country_cd = substr(comp_k.party_nat_key_nr, 1, 2)

    -- make sure a SID exists for the new store, so we can transfer the plan value to this SID
    join meta.t_party_key st_k
        on st_k.party_nat_key_nr = asn.country_cd||'|'||to_number(asn.new_store_nr)
        and st_k.party_key_type_cd = 'STORE'

    join meta.t_planned_value_type_key pvt_k_st
        on pvt_k_st.planned_val_type_nat_key_nr = '157|STR'
WHERE 1=1
	-- the rows that we just deactivated.
    and pbd.DWH_VALID_TO_TMSP = dateadd('ns', -1, current_timestamp)  -- TODO: set this to ETL exec time - 1ns
	and pbd.DWH_UPDATED_TMSP = current_timestamp -- TODO: set this to ETL exec time
;
*/
COMMIT;
