/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_return_same_receipt.sql
#----------------------------------------------------------------------------
# History:
#  1.0  30.09.2024  Mihail Ivanov  - ZKP GF - Initial implementation
		UserStory 
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33405/
			"ZKP: Mehrfache Geldrückgabe mit gleichem Originalbon"
		Setting the following flags:
			RETURN_SAME_RECEIPT_FG
			
#  1.1  21.11.2024  Mihail Ivanov  - added filter TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too

#  1.2  17.01.2025  Mihail Ivanov  - First return is not marked as suspicious. Only the following returns
									requetest here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63029
									
#  1.3  18.03.2025  Mihail Ivanov  - bugfix: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/67057
										threshold for return amount is compared now to the sum of retail_lines -  RETAIL_LINE_GROSS_VAL (instead of the amount in the header - TXN_GROSS_VAL)
										also if one of the returns passes the threshold, all returns with this purchase event are evaluated

#  1.4  27.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios

#  1.5  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.6  23.04.2025  Kamil Roszczyk - Changes:
						- added 'all return items are not on the follow-up receipt after the return' logic
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/68261
*/



-- it is possible that one return happend in the delta period, but long before there was another return with same original receipt
-- so first we take returns in the delta, get their original purchase,  and then look for other retuns with  same original purchase

--  I do this in separate temporary table, because I want this part to be executed first
-- 		and use the result as filter for "All Returns" in T_PRODUCT_RETAIL_LINE
--  When I put everything in one query, the optiimizer sometimes starts first with T_PRODUCT_RETAIL_LINE ("All returns")
--		And it applies no filter to it, so all partitions read (nothing is pruned)
--  This is very ineffective and we want to avoid it.
CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.T_TMP_ORIG_PURCHASE 
DATA_RETENTION_TIME_IN_DAYS = 0
AS
SELECT
    DISTINCT 
    purch_e.RETAIL_EVENT_SID
    ,purch_e.BUS_DT
    ,purch_e.COUNTRY_ORG_CD
FROM ${FWRK_WORK_DB}.VT1 -- delta
    JOIN core_rel.T_PRODUCT_RETAIL_LINE ret_l
            ON ret_l.BUS_DT = vt1.DWH_CAL_DT
            AND ret_l.COUNTRY_ORG_CD = vt1.COUNTRY_CD
            AND ret_l.STORE_SID = vt1.LOC_SID
    JOIN core_rel.T_RETAIL_EVENT purch_e
            ON purch_e.RETAIL_EVENT_SID = ret_l.ORIG_SALES_EVENT_SID

WHERE 1=1
    -- delta
    AND ret_l.BUS_DT BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT

    AND ret_l.PROD_RETAIL_LINE_TYPE_CD IN ('R', 'RD')
	and ret_l.TURNOVER_RELEVANT_FG = TRUE -- this eliminates cancelled (aborted) and suspended receipts too
	
    AND purch_e.RETAIL_EVENT_TYPE_CD = 'S'
;



-- again, workaround to force snowflake to filter "All Returns" by some date, instead of reading the full table
-- in a perfect world, optimizer would be able to do this on its own and I wouldn't have to do it manually
-- but as of Sept 2024 we need this.
SET SV_PURCH_MIN_DT = (SELECT TO_CHAR(MIN(BUS_DT), 'YYYY-MM-DD') FROM ${FWRK_WORK_DB}.T_TMP_ORIG_PURCHASE);



CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.T_TMP_RETURN_RECEIPTS 
DATA_RETENTION_TIME_IN_DAYS = 0
AS
with  
-- we will join with the Param-View several times, so we want to trick snowflake to query it once, materialize the result and reuse it
-- we want to avoid querying the view 3 times because it involves T_INTERNAL_ORGANIZATION, we have a policy there, and we want to reduce how many times the policy is evaluated
mat_params AS
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE
    WHERE SCENARIO_ID = 8 -- US:33405, flag: RETURN_SAME_RECEIPT_FG, "ZKP: Mehrfache Geldrückgabe mit gleichem Originalbon"
)
SELECT 
	ar_e.RETAIL_EVENT_SID					as RET_RETAIL_EVENT_SID
	,ANY_VALUE(ar_e.CASH_REGISTER_EVENT_NR) as CASH_REGISTER_EVENT_NR
	,ANY_VALUE(ar_e.EVENT_START_TMSP) as EVENT_START_TMSP
	,ANY_VALUE(ar_e.EVENT_END_TMSP) as EVENT_END_TMSP
	,ANY_VALUE(ar_e.BUS_DT) as BUS_DT
	,ANY_VALUE(ar_e.CASH_REGISTER_SID) as CASH_REGISTER_SID
	,ANY_VALUE(cr.CASH_REGISTER_NR) as CASH_REGISTER_NR
	,ANY_VALUE(ar_e.STORE_SID) as STORE_SID
	,ANY_VALUE(ar_e.CASHIER_HASH) as CASHIER_HASH
	,ANY_VALUE(ar_e.TXN_NET_VAL) as TXN_NET_VAL
	,ANY_VALUE(ar_e.TXN_GROSS_VAL) as TXN_GROSS_VAL
	,ANY_VALUE(ar_e.curr_cd) as curr_cd
	,ANY_VALUE(ce.CASHIER_NR) as CASHIER_NR
    ,ANY_VALUE(ar_e.COUNTRY_ORG_CD) as COUNTRY_ORG_CD
	
	,op.RETAIL_EVENT_SID					as ORIG_PURCH_RETAIL_EVENT_SID
	,ar_l.LOCAL_PROD_NR
	
	--Calculating the sum of all lines of each separate product...
	,SUM(ar_l.RETAIL_LINE_GROSS_VAL) as PRODUCT_LINES_GROSS_VAL
	--...and here using this calculation as a base for the sum of all products in a return receipt
	,ABS(SUM(PRODUCT_LINES_GROSS_VAL) OVER(PARTITION BY ar_e.RETAIL_EVENT_SID)) as RETURN_GROSS_VAL
	,ANY_VALUE(ret_cnt.PARAM_VAL_QTY)		as PARAM_MIN_RETURNS_CNT
	,ANY_VALUE(ret_val.PARAM_VAL_QTY)		as PARAM_MIN_RETURN_GROSS_VAL
	,IFF(RETURN_GROSS_VAL >= PARAM_MIN_RETURN_GROSS_VAL, 1, 0) as RECEIPT_PASSED_AMOUNT_THRESHOLD_FG
	
FROM ${FWRK_WORK_DB}.T_TMP_ORIG_PURCHASE op

	JOIN core_rel.T_PRODUCT_RETAIL_LINE ar_l -- all returns (lines) with same ORIG purchase 
			ON ar_l.ORIG_SALES_EVENT_SID = op.RETAIL_EVENT_SID

			-- little trick for performance. After all, a return cannot happen at earlier date than the purchase date
			AND ar_l.BUS_DT >= op.BUS_DT
			AND ar_l.BUS_DT >= $SV_PURCH_MIN_DT
			AND ar_l.COUNTRY_ORG_CD = op.COUNTRY_ORG_CD

	JOIN core_rel.T_RETAIL_EVENT ar_e -- all retunrs (event) with same Orig Purchase
			ON ar_e.RETAIL_EVENT_SID = ar_l.RETAIL_EVENT_SID
			AND ar_e.BUS_DT = ar_l.BUS_DT
			AND ar_e.COUNTRY_ORG_CD = ar_l.COUNTRY_ORG_CD

	JOIN mat_params ret_val  -- "Return Value" - parameter how many returns with same receipt
				ON ret_val.COUNTRY_ORG_CD = ar_e.COUNTRY_ORG_CD
				AND ret_val.PARAM_ID = 25
				-- if scneario is not enabled all receipts from that country will be eliminated in the inner join
				and ret_val.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
				
	JOIN mat_params ret_cnt  -- "Returns Count" - parameter how many returns with same receipt
				ON ret_cnt.COUNTRY_ORG_CD = ar_e.COUNTRY_ORG_CD
				AND ret_cnt.PARAM_ID = 24
				-- if scneario is not enabled all receipts from that country will be eliminated in the inner join
				and ret_cnt.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE

	JOIN core_rel.T_CASH_REGISTER cr
		ON ar_e.CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE
		
	LEFT JOIN core_app_fraud_detection.T_CASHIER_ENCRYPTION ce
			ON ce.CASHIER_HASH = ar_e.CASHIER_HASH

WHERE 1=1
	AND ar_l.PROD_RETAIL_LINE_TYPE_CD IN ('R', 'RD')
	and ar_l.TURNOVER_RELEVANT_FG = TRUE
	AND ar_e.RETAIL_EVENT_TYPE_CD = 'R'
	and ar_e.TURNOVER_RELEVANT_FG = TRUE
GROUP BY
    ar_e.RETAIL_EVENT_SID
    , op.RETAIL_EVENT_SID
    , ar_l.LOCAL_PROD_NR
;




INSERT INTO ETL.t_fact_fraud_detection_by_cash_register_event_final
(
	CASH_REGISTER_EVENT_SID
	,CASH_REGISTER_EVENT_NR
	,EVENT_START_TMSP
	,BUS_DT
	,CASH_REGISTER_SID
	,CASH_REGISTER_NR
	,STORE_SID
	,CASHIER_HASH
	,TXN_NET_VAL
	,TXN_GROSS_VAL
	,CURR_CD

	,RETURN_SAME_RECEIPT_FG
)
WITH
	--T_TMP_RETURN_RECEIPTS is a table on a product level so we need distinctive receipt header information from it to avoid duplicates
    all_return_headers AS
        (
            SELECT DISTINCT
                ret_retail_event_sid
                , cash_register_event_nr
                , bus_dt
                , cash_register_sid
                , cashier_nr
                , country_org_cd
            FROM
                ${FWRK_WORK_DB}.T_TMP_RETURN_RECEIPTS
        )
	--Prequalifying potential followers of return receipts (sales receipts of same day, cash register and country as a return receipt)
    , purch_day_and_register_of_return AS
        (
            SELECT 	
        		re.retail_event_sid
        		,re.cash_register_event_nr
        		,re.bus_dt
        		,re.cash_register_sid
        		,ce.cashier_nr
        	FROM
                core_rel.t_retail_event re
        	INNER JOIN
                core_app_fraud_detection.t_cashier_encryption ce
        			ON ce.cashier_hash = re.cashier_hash
        	WHERE
                re.retail_event_type_cd = 'S'
        		AND re.turnover_relevant_fg = TRUE
        		AND EXISTS
            		(
            			SELECT 1
            			FROM all_return_headers arh
            			WHERE arh.bus_dt = re.bus_dt
                            AND arh.cash_register_sid = re.cash_register_sid
            				and arh.country_org_cd = re.country_org_cd
            		)
        )
	--Qualifying the 'purchase after return' receipt. If not available, par_retail_event_sid is null, hence the left join in the logic
    , purch_event_after_return AS
        (
            SELECT
                arh.ret_retail_event_sid
                , par.retail_event_sid AS par_retail_event_sid
            FROM
                all_return_headers arh
            LEFT OUTER JOIN
                purch_day_and_register_of_return par
                    ON par.bus_dt = arh.bus_dt
                    AND par.cashier_nr = arh.cashier_nr
                    AND par.cash_register_sid = arh.cash_register_sid
                    AND par.cash_register_event_nr > arh.cash_register_event_nr
            QUALIFY
                ROW_NUMBER() OVER (PARTITION BY arh.ret_retail_event_sid ORDER BY par.cash_register_event_nr ASC) = 1
        )
	--Appending the list of products in purchase after return
    , purch_products_after_return_event AS
        (
            SELECT DISTINCT
                par.ret_retail_event_sid
                , par.par_retail_event_sid
                , prl.local_prod_nr
            FROM
                purch_event_after_return par
            INNER JOIN
                core_rel.t_product_retail_line prl
                    ON prl.retail_event_sid = par.par_retail_event_sid
        )
    , return_events_calc AS
        (
            SELECT
                rr.RET_RETAIL_EVENT_SID
            	, ANY_VALUE(rr.CASH_REGISTER_EVENT_NR) as CASH_REGISTER_EVENT_NR
            	, ANY_VALUE(rr.EVENT_START_TMSP) as EVENT_START_TMSP
            	, ANY_VALUE(rr.EVENT_END_TMSP) as EVENT_END_TMSP
            	, ANY_VALUE(rr.BUS_DT) as BUS_DT
            	, ANY_VALUE(rr.CASH_REGISTER_SID) as CASH_REGISTER_SID
            	, ANY_VALUE(rr.CASH_REGISTER_NR) as CASH_REGISTER_NR
            	, ANY_VALUE(rr.STORE_SID) as STORE_SID
            	, ANY_VALUE(rr.CASHIER_HASH) as CASHIER_HASH
            	, ANY_VALUE(rr.TXN_NET_VAL) as TXN_NET_VAL
            	, ANY_VALUE(rr.TXN_GROSS_VAL) as TXN_GROSS_VAL
            	, ANY_VALUE(rr.CURR_CD) as CURR_CD
				, ANY_VALUE(rr.RECEIPT_PASSED_AMOUNT_THRESHOLD_FG) as RECEIPT_PASSED_AMOUNT_THRESHOLD_FG
				, ANY_VALUE(rr.PARAM_MIN_RETURNS_CNT) as PARAM_MIN_RETURNS_CNT
                
				--T_TMP_RETURN_RECEIPTS table is already on a product level so the set provides distinctive products as it is
                , COUNT(rr.local_prod_nr) AS RET_DISTINCT_PROD_CNT
				--The join to purch_products_after_return_event CTE is on a receipt ID and product number so if there is no match on a product then par_p.local_prod_nr will be null and will not be considered by COUNT function
                , COUNT(par_p.local_prod_nr) AS RET_AND_PURCH_DISTINCT_PROD_CNT
            
                , rr.ORIG_PURCH_RETAIL_EVENT_SID
                
            	, ROW_NUMBER() OVER (PARTITION BY rr.ORIG_PURCH_RETAIL_EVENT_SID ORDER BY ANY_VALUE(rr.EVENT_END_TMSP)) 	as RET_SORT_NR
            FROM
                ${FWRK_WORK_DB}.T_TMP_RETURN_RECEIPTS rr
            LEFT OUTER JOIN
                purch_products_after_return_event par_p
                    ON rr.ret_retail_event_sid = par_p.ret_retail_event_sid
					AND rr.local_prod_nr = par_p.local_prod_nr
            GROUP BY
            	rr.RET_RETAIL_EVENT_SID
                , rr.ORIG_PURCH_RETAIL_EVENT_SID
		)
	, return_events_filtered AS
		(
			SELECT
				RET_RETAIL_EVENT_SID
            	, CASH_REGISTER_EVENT_NR
            	, EVENT_START_TMSP
            	, EVENT_END_TMSP
            	, BUS_DT
            	, CASH_REGISTER_SID
            	, CASH_REGISTER_NR
            	, STORE_SID
            	, CASHIER_HASH
            	, TXN_NET_VAL
            	, TXN_GROSS_VAL
            	, CURR_CD
				, RET_SORT_NR
				, SUM(RECEIPT_PASSED_AMOUNT_THRESHOLD_FG) OVER (PARTITION BY ORIG_PURCH_RETAIL_EVENT_SID) as RECEIPTS_PASSED_AMOUNT_THRESHOLD_CNT
				, COUNT(RET_RETAIL_EVENT_SID) OVER (PARTITION BY ORIG_PURCH_RETAIL_EVENT_SID) as RETURNS_PER_ORIG_PURCH_CNT
			FROM
				return_events_calc
			WHERE
				--Take all return receipts being first returns associated with an original receipt chronologically
				--For second and next return receipts apply 'all return items are not on the follow-up receipt after the return' logic
				--If there is no option to determine the follow-up receipt due to the old cashier_hash/cashier_nr values in a return being anonymized then qualify such return anyways
				--In such cases RET_AND_PURCH_DISTINCT_PROD_CNT column will be equal to zero for that row so then it will always be different than RET_DISTINCT_PROD_CNT which is equal or more than 1 by definition of a return - the expression will be then evaluated to True
				RET_SORT_NR = 1
				OR RET_DISTINCT_PROD_CNT <> RET_AND_PURCH_DISTINCT_PROD_CNT
            QUALIFY 1=1
				--After 'all return items are not on the follow-up receipt after the return' logic is applied - filter receipts on thresholds
            	AND RETURNS_PER_ORIG_PURCH_CNT >= PARAM_MIN_RETURNS_CNT
            	AND RECEIPTS_PASSED_AMOUNT_THRESHOLD_CNT >= 1 -- if one of the returns have amount above threshold, all returns are included
        )
SELECT 
	RET_RETAIL_EVENT_SID
	,CASH_REGISTER_EVENT_NR
	,EVENT_START_TMSP
	,BUS_DT
	,CASH_REGISTER_SID
	,CASH_REGISTER_NR
	,STORE_SID
	,CASHIER_HASH
	,TXN_NET_VAL
	,TXN_GROSS_VAL
	,curr_cd

	-- first return has a flag FALSE, only the following returns that use the same original receipt are marked as suspicious.
	-- we still want the event to be returned with explicit FALSE, to make sure the flag will be updated if it was TRUE before
	,DECODE(RET_SORT_NR, 1, 0, 1)      AS RETURN_SAME_RECEIPT_FG
FROM return_events_filtered
;
