/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: zkp_reagg_delta_insert.sql
#----------------------------------------------------------------------------
# History:
#	1.0  	26.11.2024  	Mihail Ivanov  - Initial Implementation:
							When a threshold for a scenario (a.k.a parameter_value) is changed for a given country_1
								the receipts for the last 8 weeks for this country_1 need to be reeavaluated
								if they fit any of the Automatic ZKP scenarios
							
							This scripts checks the last date of parameter value changed, 
								and when the receipts were last evaluated
							If necessary, we insert "artificial" delta to force the ZKP scripts to evaluate the receipts 
								for the last 8 weeks for the given country_1(s)
								
#	1.1  	10.03.2025  	Mihail Ivanov  - Adding additional 10 days backward for each store.
								For some return scenarios we need to check if there is an older return with same original purchase
								If such return exist it needs to be reevaluated because the result depends on how many returns are made with same original purchase
								Statistical analysis showed that 10 days backward cover more than 99.7% of relevant cases and this is good enough for business, while keeping execution time small
								https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66175/
*/

!SET exit_on_error=True;

-- (Monday of current week - 8 weeks)
SET SV_START_DT = (select to_char(trunc(current_date, 'W') - 8*7, 'YYYY-MM_1-DD') from dual);
SET SV_END_DT = to_char(CURRENT_DATE, 'YYYY-MM_1-DD');

SET SV_DATEDIFF = (select $SV_END_DT::DATE - $SV_START_DT::DATE +1 from dual);

SET SV_DAY_BACK_CNT = 10; -- by how many days back we extend the delta interval, so we can look for other returns with same original receipt


INSERT into etl_process.T_PRCS_LOG_1  
(
	AGGREGATE
	,DWH_NODE_CD
	
	,COUNTRY_CD
	,DWH_CAL_DT
	,LOC_SID
	
	,RECALC_FG
	,STATUS_1
	,DWH_LOAD_ID
	,CREATE_TMSP
	,UPDATE_TMSP
	,START_TMSP
	,END_TMSP
)
with 
curr_delta as 
(
    SELECT
        DISTINCT
        country_cd,
        dwh_cal_dt,
        loc_sid
    FROM ETL_PROCESS.t_prcs_log_1 prcs_log
    WHERE prcs_log.dwh_load_id = ${LOAD_ID}
)
,other_ret_dates as
(
    select 
        DISTINCT
        prl2.STORE_SID
        ,prl2.COUNTRY_ORG_CD
        ,prl2.BUS_DT
    from curr_delta cd
        JOIN core_rel.T_PRODUCT_RETAIL_LINE_1 prl
                on prl.STORE_SID = cd.LOC_SID
                AND prl.COUNTRY_ORG_CD  = cd.COUNTRY_CD
                AND prl.BUS_DT = cd.DWH_CAL_DT
                and prl.RETAIL_EVENT_LINE_SCENARIO_ID BETWEEN 140 AND 149	--Return receipt lines
        join core_rel.T_PRODUCT_RETAIL_LINE_1 prl2
                on prl2.COUNTRY_ORG_CD = prl.COUNTRY_ORG_CD
                and prl2.RETAIL_EVENT_LINE_SCENARIO_ID BETWEEN 140 AND 149	--Return receipt lines
				
                and prl2.ORIG_SALES_EVENT_SID = prl.ORIG_SALES_EVENT_SID 	-- same purchase
				and prl2.RETAIL_EVENT_SID <> prl.RETAIL_EVENT_SID			-- different return event
                
                and prl2.BUS_DT >= (select min(dwh_cal_dt) - $SV_DAY_BACK_CNT::NUMBER from curr_delta)
)
select 
    't_fact_fraud_detection_by_cash_register_event_1'
    ,'CORE_DIM'
	
    ,ord.COUNTRY_ORG_CD
    ,ord.BUS_DT
    ,ord.STORE_SID
	
    ,0
    ,0
    ,${LOAD_ID}
    ,current_date
    ,current_date
    ,current_date
    ,current_date
from other_ret_dates ord
    left join curr_delta cd
        on ord.STORE_SID = cd.LOC_SID
        AND ord.COUNTRY_ORG_CD  = cd.COUNTRY_CD
        AND ord.BUS_DT = cd.DWH_CAL_DT
where cd.loc_sid is null -- only new Store/Day combos, that do no exist in current delta
;






INSERT into etl_process.T_PRCS_LOG_1  
(
	AGGREGATE
	,DWH_NODE_CD
	
	,COUNTRY_CD
	,DWH_CAL_DT
	,LOC_SID
	
	,RECALC_FG
	,STATUS_1
	,DWH_LOAD_ID
	,CREATE_TMSP
	,UPDATE_TMSP
	,START_TMSP
	,END_TMSP
)
with 
country_param_update as
(
    select 
        country_org_cd
        ,max(PARAM_LAST_UPDATE_TMSP) country_param_max_tmsp
    from CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1
	where SCENARIO_TYPE_CD = 'AUTO'
    group by country_org_cd
)
,country_data_load as 
(
    select 
        io.country_org_cd,
        min(fe.dwh_updated_tmsp) as country_load_min_tmsp
    from core_dim.t_fact_fraud_detection_by_cash_register_event_1 fe
        join core_dim.t_dim_internal_organization_1 io 
                on io.int_org_sid = fe.store_sid
                and io.dwh_valid_fg = TRUE
    where bus_dt >= $SV_START_DT
    group by io.country_org_Cd
)
,stores_for_reload as 
(
    select 
        cdl.COUNTRY_ORG_CD
        ,io_st.INT_ORG_SID as STORE_SID
    from country_param_update cpu
        join country_data_load cdl
            on cdl.country_org_cd = cpu.country_org_cd
            -- if there is data loaded BEFORE last param change, we must reload it
            -- all receipts from past 8 weeks must be evaluated AFTER last param val change
            and cdl.country_load_min_tmsp < country_param_max_tmsp
        
        -- take all stores for the countries that need to be reloaded
        join core_dim.t_dim_internal_organization_1 io_st
            on io_st.country_org_cd = cdl.country_org_cd
            and io_st.DWH_VALID_FG = TRUE
            and io_st.INT_ORG_TYPE_CD = 'STORE'
    
)
,days_last8_weeks as 
(
    select $SV_START_DT::DATE + row_number() over (order by 1) -1 dt_val
    from table(generator(rowcount=>$SV_DATEDIFF)) g
)
SELECT 
    't_fact_fraud_detection_by_cash_register_event_1'
    ,'CORE_DIM'
	
    ,sfr.COUNTRY_ORG_CD
    ,d.DT_VAL
    ,sfr.STORE_SID
	
    ,0
    ,0
    ,${LOAD_ID}
    ,current_date
    ,current_date
    ,current_date
    ,current_date
FROM stores_for_reload sfr
    ,days_last8_weeks d
;
