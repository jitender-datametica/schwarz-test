-- Converted to BigQuery SQL using Python script

/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_return_no_orig_receipt.sql
#----------------------------------------------------------------------------
# History:
#  1.0  09.08.2024  Andrzej Wandtke 	- ZKP GF Story 33393 development by Mihail Ivanov - script for scenario Money refund without original receipt 
#  1.1  19.08.2024  Andrzej Wandtke 	- ZKP GF Story 46391 add table vt1
#  1.2  21.11.2024  Mihail Ivanov  		- added filter re.TURNOVER_RELEVANT_FG = TRUE
#  1.3  03.12.2024  Mihail Ivanov		- Products matched by LOCAL_PROD_NR instead of PROD_VARIANT_SID
#											as required for fix in this bug: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/59294/
#
#										  Also added threshold evaluation of Returned Amount
#  1.4  09.12.2024  Kamil Roszczyk      - ZKP GF - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56797
#										Change log:
#											- fixed the duplicates issue
#											- added the fix for returns with dummy orig_sales_event_sid numbers
#											- changed the calculation method for both flags
#  1.5  15.01.2025  Andrzej Wandtke      - ZKP GF - bug 62166 - change the logic for products_matched
#  1.6  27.02.2025  Mihail Ivanov      	 - ZKP GF - bug 63924 - change the window clause for "products_matched", "total_return_cnt"
#  1.7  27.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
#  1.8  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
*/
INSERT INTO
	`${BQ_PROJECT_ID}.${FWRK_WORK_DB}.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_FINAL` --need to replace dataset parameter om
		(
			cash_register_event_sid
			, cash_register_event_nr
			, event_start_tmsp
			, bus_dt
			, cash_register_sid
			, cash_register_nr
			, store_sid
			, cashier_hash
			, txn_net_val
			, txn_gross_val
			, curr_cd
			, return_not_on_receipt_fg
			, return_qty_invalid_fg
		)
with
returned_products as
(
    SELECT 
        prl.RETAIL_EVENT_SID                    as RET_RETAIL_EVENT_SID
        ,prl.LOCAL_PROD_NR                      as RET_LOCAL_PROD_NR
        ,ANY_VALUE(prl.BUS_DT)                  as RET_BUS_DT
        ,ANY_VALUE(prl.ORIG_SALES_EVENT_SID)    as PURCH_RETAIL_EVENT_SID -- ID of the receipt with which the ReturnedProduct was purchase
        ,coalesce(sum(prl.PROD_VARIANT_QTY), sum(prl.PROD_VARIANT_CNT) )   as RET_QTY
    FROM `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` prl
    WHERE 1=1
        and prl.PROD_RETAIL_LINE_TYPE_CD in ('R', 'RD')
		and prl.TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too
        and prl.bus_dt between MIN_DWH_CAL_DT and MAX_DWH_CAL_DT  --need to replace data parameters om
        and (prl.country_org_cd) IN
        (
          SELECT country_cd
          FROM VT1
        )
        and (prl.bus_dt) IN
        (
          SELECT dwh_cal_dt
          FROM VT1
        )
        and (prl.store_sid) IN
        (
          SELECT loc_sid
          FROM VT1
        )
        -- and (prl.country_org_cd, prl.bus_dt, prl.store_sid) IN
        -- (
        --    SELECT country_cd, dwh_cal_dt, loc_sid
        --    FROM ETL.VT1
        -- )
    GROUP BY
        prl.RETAIL_EVENT_SID
        ,prl.LOCAL_PROD_NR
)
, purchased_products as
(
    SELECT 
        p_prl.RETAIL_EVENT_SID                      as PURCH_RETAIL_EVENT_SID
        ,p_prl.LOCAL_PROD_NR                        as PURCH_LOCAL_PROD_NR
        ,coalesce(
                sum(p_prl.PROD_VARIANT_QTY)
                ,sum(p_prl.PROD_VARIANT_CNT))       as PURCH_QTY
    FROM `${BQ_PROJECT_ID}.CORE_REL.T_PRODUCT_RETAIL_LINE` p_prl
    WHERE 1=1
        and p_prl.RETAIL_EVENT_SID in (select distinct PURCH_RETAIL_EVENT_SID from returned_products)
        and p_prl.bus_dt <= MAX_DWH_CAL_DT -- if return is before MaxDate, then purchase must also be before MaxDate -- om
        -- and p_prl.bus_dt >= dateadd(d, -360, current_date()) -- -- for performance. Different laws allow return for 7,14 or 30 days. Anyway there should not be a return that happens more than 360 days after purchase
        and p_prl.bus_dt >= DATE_SUB(MIN_DWH_CAL_DT, INTERVAL 360 DAY)
        and (p_prl.country_org_cd) IN
        (
           SELECT country_cd
           FROM VT1
        )
    GROUP BY
        p_prl.RETAIL_EVENT_SID
        ,p_prl.LOCAL_PROD_NR
)
, calc_flags as
(
SELECT
    rpv.ret_retail_event_sid as cash_register_event_sid			
	,re.cash_register_event_nr
	,re.event_start_tmsp
	,rpv.ret_bus_dt
	,re.cash_register_sid
	,cr.cash_register_nr
	,re.store_sid
	,re.cashier_hash
	,re.txn_net_val
	,re.txn_gross_val
	,re.curr_cd
	-- checking the number of matching lines between return and sales receipt
	-- count distinct is added in order not to consider the same product many times
	-- both RET_RETAIL_EVENT_SID and PURCH_RETAIL_EVENT_SID are part of the window clause in case lines of the same return receipt have different Purchase SIDs (is not expected but ... who knows)
    -- ,COUNT(DISTINCT DECODE(ppv.PURCH_LOCAL_PROD_NR = rpv.RET_LOCAL_PROD_NR, True, ppv.PURCH_LOCAL_PROD_NR, null)) 
		-- 	OVER(PARTITION BY rpv.RET_RETAIL_EVENT_SID, rpv.PURCH_RETAIL_EVENT_SID) as products_matched

  --  ,   MAX(CASE 
  --       WHEN products_matched = total_return_cnt THEN False 
  --       ELSE True 
  --   END) AS RETURN_NOT_ON_RECEIPT_FG

, COUNT(DISTINCT CASE 
                  WHEN ppv.PURCH_LOCAL_PROD_NR = rpv.RET_LOCAL_PROD_NR 
                  THEN ppv.PURCH_LOCAL_PROD_NR 
                  ELSE NULL 
               END)
  OVER(PARTITION BY rpv.RET_RETAIL_EVENT_SID, rpv.PURCH_RETAIL_EVENT_SID) AS products_matched



	-- count the total number of distinctive products in return receipt for comparison with products_matched
	-- both RET_RETAIL_EVENT_SID and PURCH_RETAIL_EVENT_SID are part of the window clause in case lines of the same return receipt have different Purchase SIDs (is not expected but ... who knows)
	,COUNT(DISTINCT rpv.RET_LOCAL_PROD_NR) 
			OVER(PARTITION BY rpv.RET_RETAIL_EVENT_SID, rpv.PURCH_RETAIL_EVENT_SID) as total_return_cnt
    -- purchase receipt that contains the PV was found, but the returned quantity is bigger
    ,CASE
			WHEN ppv.PURCH_LOCAL_PROD_NR = rpv.RET_LOCAL_PROD_NR THEN (ABS(rpv.RET_QTY) > ppv.PURCH_QTY)
			ELSE False
		END as RETURN_QTY_INVALID_FG
FROM returned_products rpv
	join `${BQ_PROJECT_ID}.CORE_REL.T_RETAIL_EVENT` re 
		on rpv.RET_RETAIL_EVENT_SID = re.RETAIL_EVENT_SID
		and re.bus_dt between MIN_DWH_CAL_DT and MAX_DWH_CAL_DT 
	inner join `${BQ_PROJECT_ID}.CORE_REL.T_CASH_REGISTER` cr
		ON re.CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE
    -- filter using threshold for param value "Returned Amount"
    inner join `${BQ_PROJECT_ID}.CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE` pv_ra 
        on pv_ra.COUNTRY_ORG_CD = re.COUNTRY_ORG_CD
        and pv_ra.scenario_id = 10
        and pv_ra.param_id = 29
		and pv_ra.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE 
        and abs(re.txn_gross_val) >= pv_ra.PARAM_VAL_QTY
	-- Initially this was left outer join on both retail_event_sid and local_prod_nr but it was changed due to the nature of orig_sales_event_sid attribute data
	-- Sometimes cashiers mark a dummy receipt number as an original receipt during proceeding the return. Such input makes orig_sales_event_sid field being populated with receipt ID but such ID has no relation to any actual receipt in t_retail_event
	-- We want to make sure that whatever we try to compare for both flags comes from actual receipts - inner join is used to force it but local_prod_nr condition is skipped to allow checking for return products not matched with sales receipt in SELECT statement calculations
    inner join purchased_products ppv
        on ppv.PURCH_RETAIL_EVENT_SID = rpv.PURCH_RETAIL_EVENT_SID
)
SELECT
	cash_register_event_sid			
	-- , ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr
  , ANY_VALUE(CAST(cash_register_event_nr AS STRING)) AS cash_register_event_nr
	, ANY_VALUE(event_start_tmsp) AS event_start_tmsp
	, ANY_VALUE(ret_bus_dt) AS bus_dt
	, ANY_VALUE(cash_register_sid) AS cash_register_sid
	-- , ANY_VALUE(cash_register_nr) AS cash_register_nr
  , ANY_VALUE(CAST(cash_register_nr AS STRING)) AS cash_register_nr
	, ANY_VALUE(store_sid) AS store_sid
	, ANY_VALUE(cashier_hash) AS cashier_hash
	, ANY_VALUE(txn_net_val) AS txn_net_val
	, ANY_VALUE(txn_gross_val) AS txn_gross_val
	, ANY_VALUE(curr_cd) AS curr_cd
	-- if the number of products matched between the return and sales receipt and the total number of products in return are the same then it means all returned products are in original sales receipt so it's not a fraud, otherwise it's a fraud
	-- , MAX(DECODE(products_matched, total_return_cnt, False, True)) AS RETURN_NOT_ON_RECEIPT_FG
 , MAX(CASE 
        WHEN products_matched = total_return_cnt THEN False 
        ELSE True 
    END) AS RETURN_NOT_ON_RECEIPT_FG

	, MAX(RETURN_QTY_INVALID_FG) AS RETURN_QTY_INVALID_FG
FROM
    calc_flags
WHERE
    products_matched <> total_return_cnt
    OR return_qty_invalid_fg = True
GROUP BY
    cash_register_event_sid	
;
