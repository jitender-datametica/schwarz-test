/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_return_same_prod.sql
#----------------------------------------------------------------------------
# History:
#  1.0  26.09.2024  Mihail Ivanov  - Initial Implementation
#					ZKP GF_1 - script for scenario "ZKP: Rückgaben gleicher Artikel_1" 
#					Flag: RETURN_SAME_PROD_FG
#					User Story: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33392/
#
#  1.1  22.11.2024  Mihail Ivanov  - added filter re.TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too
#
#  1.2  03.12.2024  Mihail Ivanov  - bufixes:
#						- Products matched by LOCAL_PROD_NR instead of PROD_VARIANT_SID
#							as required for fix in other scenarios in this bug: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/59294/
#							the logic should be consistent so we apply same logic here
#						
#						- CASHIER_HASH cannot be used for a week window because it changes every day. Using CASHIER_NR now
#
#						- threshold for single return amount is applied first, BEFORE window functions are calculated.
#							this way, only valid receipts are counted in the weekly sum/count
*/

INSERT INTO ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final
(
	cash_register_event_sid
	,cash_register_event_nr
	,event_start_tmsp
	,bus_dt
	,cash_register_sid
	,cash_register_nr
	,store_sid
	,cashier_hash
	,txn_net_val
	,txn_gross_val
	,relevant_cancel_gross_val
	,curr_cd
	,relevant_cancel_line_cnt

	,RETURN_SAME_PROD_FG
)
with
-- we will join with the Param-View several times, so we want to trick snowflake to query it once, materialize the result and reuse it
-- we want to avoid querying the view 3 times because it involves T_INTERNAL_ORGANIZATION_1, we have a policy there, and we want to reduce how many times the policy is evaluated
mat_params as
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1
    WHERE SCENARIO_ID = 9 -- US:33392, flag: RETURN_SAME_PROD_FG, "Rückgaben gleicher Artikel_1"
)
,returned_products as
(
    SELECT 
        prl.RETAIL_EVENT_SID
		,prl.LOCAL_PROD_NR
		
		,any_value(re.CASH_REGISTER_EVENT_NR)	as CASH_REGISTER_EVENT_NR
		,any_value(re.EVENT_START_TMSP)			as EVENT_START_TMSP
		,any_value(re.BUS_DT)					as BUS_DT
		,any_value(re.CASH_REGISTER_SID)		as CASH_REGISTER_SID
		,any_value(re.STORE_SID)				as STORE_SID
		,any_value(re.CASHIER_HASH)				as CASHIER_HASH
		,any_value(re.TXN_NET_VAL)				as TXN_NET_VAL
		,any_value(re.TXN_GROSS_VAL)			as TXN_GROSS_VAL
		,any_value(re.CURR_CD)					as CURR_CD
        ,any_value(re.COUNTRY_ORG_CD)			as COUNTRY_ORG_CD
		
        -- how much is the amount for the Returned Prods for the receipt
        ,sum(prl.RETAIL_LINE_GROSS_VAL) as prod_return_gross_val 
    FROM ${FWRK_WORK_DB}.VT1
       join core_rel.T_RETAIL_EVENT_1 re_1
                on re.STORE_SID = vt1.LOC_SID
                and re.COUNTRY_ORG_CD  = vt1.COUNTRY_CD
                and re.BUS_DT = vt1.DWH_CAL_DT
		join core_rel.T_PRODUCT_RETAIL_LINE_1 prl
				on prl.RETAIL_EVENT_SID = re.RETAIL_EVENT_SID
                and prl.STORE_SID = re.STORE_SID
                and prl.COUNTRY_ORG_CD  = re.COUNTRY_ORG_CD
                and prl.BUS_DT = re.BUS_DT

    WHERE 1=1
        --delta
        and prl.BUS_DT between $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
		and re.BUS_DT between $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT
        
        -- business logic -> only Returns
		and re.RETAIL_EVENT_TYPE_CD = 'R'
        and prl.PROD_RETAIL_LINE_TYPE_CD = 'R' 
		and re.TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too
        
        -- Exclude Textile Products
        and not exists
        (
            SELECT 1
            FROM core_dim.T_DIM_SALES_VARIANT_1 sv
            WHERE sv.SALES_VARIANT_SID = prl.PROD_VARIANT_SID
                and sv.SUB_ITEM_GRP_NR in ('100' ,'101' ,'102' ,'105' ,'106') 
        )
	GROUP BY
		prl.RETAIL_EVENT_SID
		,prl.LOCAL_PROD_NR
)
,filtered_returns as
(
	SELECT 
		rp.*
	     
		 -- how many Return Receipts we have in the same calendar_1 week, for same Product, in same Cashier
        ,count(distinct rp.RETAIL_EVENT_SID) over (
                partition by cd.CAL_WEEK, rp.LOCAL_PROD_NR, ce.CASHIER_NR   
            ) as prod_weekly_returns_cnt
            
        -- how much is the total amount for the Returned Prodss for the same week, same cashier
        ,sum(rp.PROD_RETURN_GROSS_VAL) over (
                partition by cd.CAL_WEEK, rp.LOCAL_PROD_NR, ce.CASHIER_NR   
            ) as prod_weekly_returns_gross_val 
        
	FROM returned_products rp
	
	    -- param for Single Return Value "Rückgabewert des Artikels > X LW"
		join mat_params p_srv 
			on p_srv.COUNTRY_ORG_CD = rp.COUNTRY_ORG_CD
			and p_srv.PARAM_ID = 28

        join core_dim.T_DIM_CALENDAR_DATE_1 cd
				on rp.BUS_DT = cd.CAL_DT
		join core_app_fraud_detection.T_CASHIER_ENCRYPTION_1 ce 
				on ce.CASHIER_HASH = rp.CASHIER_HASH
	WHERE 1=1
		and abs(rp.PROD_RETURN_GROSS_VAL) >= p_srv.PARAM_VAL_QTY
		
)
SELECT 
    src.RETAIL_EVENT_SID
	,any_value(src.CASH_REGISTER_EVENT_NR)
	,any_value(src.EVENT_START_TMSP)
	,any_value(src.BUS_DT)
	,any_value(src.CASH_REGISTER_SID)
	,any_value(cr.CASH_REGISTER_NR)
	,any_value(src.STORE_SID)
	,any_value(src.CASHIER_HASH)
	,any_value(src.TXN_NET_VAL)
	,any_value(src.TXN_GROSS_VAL)
	,NULL	as RELEVANT_CANCEL_GROSS_VAL
	,any_value(src.CURR_CD)
	,NULL	as RELEVANT_CANCEL_LINE_CNT

	,1	as RETURN_SAME_PROD_FG
FROM filtered_returns src
    
    -- param for total Weekly Return Value "Geldrückgabe mit gleicher Artikel_1-Nr. muss innerhalb einer Woche_1 auf >= X"
    join mat_params p_wrv 
        on p_wrv.COUNTRY_ORG_CD = src.COUNTRY_ORG_CD
        and p_wrv.PARAM_ID = 27
		
	join core_rel.T_CASH_REGISTER_1 cr
		ON src.CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE

WHERE 1=1
    and abs(src.prod_weekly_returns_gross_val) >= p_wrv.PARAM_VAL_QTY
    and src.prod_weekly_returns_cnt > 1
GROUP BY 
	RETAIL_EVENT_SID
;
