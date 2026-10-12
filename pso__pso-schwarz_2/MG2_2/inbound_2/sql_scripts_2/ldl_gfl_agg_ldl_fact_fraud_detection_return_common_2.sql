/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_return_common.sql
#----------------------------------------------------------------------------
# History:
#  1.0  27.09.2024  Mihail Ivanov  - Initial Implementation

	Four scenarios share the following conditions:
	
		- All return items are not on the follow-up receipt after the money return
		- The value of the cash refund (receipt total) is not the same as the receipt total of the subsequent receipt after the money has been returned
		- The value of the cash refund (receipt total) is not the same as the receipt total of the subsequent receipt according to the corresponding original receipt
		
	Additionally we pre-calculate flags that are used in many (but not all) scenarios. When needed we will filter by these flags
	
	The conditions have tricky logic and also require substantial execution time.
	So for these four scenarios we first put all receipts* that meet these conditions in temp table
	Table - etl.t_fraud_detection_returns_common (*it contains 1 row per ProdVariantSID and RetailEventSID)
	
	Then as a second step we evaluate the scenario-specific conditions
	
	The four scenarios are:
		US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33408/
		"money refund with more than on item_2 for the original receipt" / "Geldrückgabe mehrerer Artikel_2 eines Originalbons"
		flag: RETURN_MULT_PROD_FG
		
        US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33396/
		"Geldrückgabe nicht autorisierungspflichtig"
		flag: RETURN_WITHOUT_AUTH_FG 
        
		US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33395/ 
		"Geldrückgabe - Originalbon gleicher Tag_2, gleicher Bediene"
		flag: RETURN_SAME_CASHIER_AND_DAY_FG 
        
		US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33407/
		"Geldrückgabe ohne Originalbon (manuell)" 
		flag: RETURN_WITHOUT_RECEIPT_FG
		

#  1.1  	01.10.2024  Mihail Ivanov  - bugfix
			- apply ABS() to transaction amount of returns to make it positive and compareable with threshold values
			- fix LEFT JOINs to keep Returns without Original Purchase and be able to set flag for them 
		


#  2.0  	11.11.2024  Mihail Ivanov  - adding sub-scenarios for some of the main scenarios
			- Because of the sub-scenarios the code if refactored:
				first the initial temp table is created, 
				then if we have several sub-scenarios for one main scenario - we put them in separate step 
				
				The result is we have 3 separate queries that use the temp table
				Step 2.1 - "Same Cashier Return" - main scenario and sub-scenarios
				Step 2.2 - "Multiple products Return" - main scenario and sub-scenarios
				Step 2.3 - other scenarios - "Return without authorization" and "Return without original receipt"
				
				
			- Now to the refactored code, we have added the following sub-scenarios:
				
				To Step 2.2 - "Multiple products Return" - main scenario and sub-scenarios
	
					US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56040/
					"ZKP: Money refund with all item_2 for the original receipt / Geldrückgabe aller Artikel_2 eines Originalbons"
					flag: RETURN_MULT_PROD_FULL_QTY_FG
				
#  2.1  	11.11.2024  Mihail Ivanov  - adding sub-scenarios 
			
			flag: RETURN_WITHOUT_RECEIPT_FG - changed logic
			flag: RETURN_WITHOUT_RECEIPT_KE_INPUT_FG  is added - which is actually specified in 
				US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33407/
				"Geldrückgabe ohne Originalbon (manuell)" 
			
				
			
			Added sub-scenario for Return Without Receipt:
			US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56048
			"ZKP:  money refund without original receipt "DV" / Geldrückgaben ohne Originalbon mit Erfassungsart "DV""
			flag: RETURN_WITHOUT_RECEIPT_DV_INPUT_FG

#  2.2  	13.11.2024  Mihail Ivanov  - bugfixes in WHERE/QUALIFY conditions in  step1.0 (t_fraud_detection_returns_common)

#  2.3		13.11.2024  Kamil Roszczyk - added IS_PV_LS_INPUT_FG flag to the temporary table definition in step 1.0,
										 added sub-scenarios to step 2.1:
			
			US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/56001
			"ZKP: money refund / Geldrückgabe – sub scenarios to Originalbon gleicher Tag_2, gleicher Bediener"
			flag: RETURN_SAME_CASHIER_FG - new flag
			flag: RETURN_SAME_CASHIER_DIFF_DAY_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_FG - enhanced logic
			flag: RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG - new flag


#  2.4  	21.11.2024  Mihail Ivanov  - bugfixes: next receipt taken by ordering CASH_REGISTER_EVENT_NR for same day and CASH_REGISTER_SID
										as defined here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/53633
										
										bugfix: flag IS_SAME_CASHIER_FG is evaluated based on CASHIER_NR and STORE_SID now (not CASHIER_HASH, because same cashier has new hash every day)
	
	
	
#	
#	2.5		03.12.2024  Mihail Ivanov  - bugfix 
#				Products matched by LOCAL_PROD_NR instead of PROD_VARIANT_SID
#				as required for fix in other scenarios in this bug: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/59294/
#				the logic should be consistent so we apply same logic here
#
#  	2.6		15.01.2025  Kamil Roszczyk - added new rules to the logic
			US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/61201
				- added IS_QUANTITY_SUSPICIOUS_FG filter to "Multiple products Return" scenario temp table query
				- added the logic and the filter to load only these return receipts data where the return's Bonsumme value is different than the first payment in cash for the following receipt - added in t_fraud_detection_returns_common temp table as it's a common filter
				- added Doppeltipper logic - detect and exclude returns if they are classified as with mistakenly scanned product lines. Logic added to t_fraud_detection_returns_common temp table, filters added to "Same Cashier Return" and "Return without authorization" scenarios temp tables

#  	2.7		20.01.2025	Kamil Roszczyk - bugfixing
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/62194
				Modified temp table in step 1.0:
					- renamed PAR_PROD_QTY column to PAR_SAME_PROD_QTY
					- removed the join condition to purch_products_after_return_event set in common_scenarios CTE
					- adjusted all existing calculations within common_scenarios CTE to the lack of aforementioned join condition
					- changed the method of calculating IS_QUANTITY_SUSPICIOUS_FG to reflect the old ZKP system algorithms, minor changes of other CTEs to get the data for the needs of IS_QUANTITY_SUSPICIOUS_FG changes
			
#	2.8		21.01.2025  Mihail Ivanov  - changes
					"Return amount   (upper bound)" Threshold for Return without authorizartion (step 2.3) is removed as requested here:
					https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/55225


			
#	2.9		12.02.2025  Andrzej Wandtke  - 64557 : change for flag RETURN_WITHOUT_AUTH_FG - add condition on t_retail_event.auth_by_hash as to exclude receipts with an approval on event level

#	2.10	19.02.2025  Kamil Roszczyk - bugfixing
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64336
				- added RET_TOTAL_LINES attribute to t_fraud_detection_returns_common; replaced RET_LINES_CNT with RET_TOTAL_LINES in step 2.2 comparison with parameter
				- fixed multiplication of Bonsumme values by adding return_receipts CTE
				- added filter in step 2.2 main_scenario CTE for excluding returns without original receipt
				- removed PROD_RETAIL_LINE_TYPE_CD filter in t_fraud_detection_returns_common

#	2.11	24.02.2025  Kamil Roszczyk - bugfixing
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64557
				- removed RET_AUTH_BY_HASH from t_fraud_detection_returns_common and all references to this column
				- added IS_ALL_PROD_LINES_NO_AUTH_FG flag - it indicates if all lines for same product in return receipt were not authorized
				- modified the RETURN_WITHOUT_AUTH_FG logic in step 2.3 so it can handle situation with multiple lines for same product having different authorization status_2

#	2.12	26.02.2025	Kamil Roszczyk - bugfixing
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64688
				- in common_scenarios CTE of t_fraud_detection_returns_common temp table added COALESCE functions to few fields originating from purchase after returns to make sure they are not null but 0 in case there is no purchase after return available (same was done in old system)
				- modified one of QUALIFY conditions in common_scenarios CTE

#	2.13	06.03.2025  Mihail Ivanov  - some window functions had only the SID of "Purchase After Return" in the "partition by",
							but this SID will be the same for many returns if they are done immediately after each other.
							If the take 1 row per "Purchase after retunr SID" we will take only 1 of many Returns, the other will be eliminated.
							So now the "partition by" includes SID of the Return + SID of the Next Purchase Event ( where this is necessary)
                                                        reported here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/65894				
				
#	2.14	10.03.2025  Mihail Ivanov  - Changes in "Doppletipper" logic 
							requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66175
				

#  2.15  	26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country_2 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
						- Using CASHIER_NR to determine next receipt by same employee. This is necessary because sometimes we get two hashes for same Store+Day+CashierNR			

#  2.16  	02.04.2025  Andrzej Wandtke  - Changes: populate the flag RETURN_MULT_PROD_SAME_CASHIER_FG
                                              https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66944

#  2.17  	03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  2.18		12.05.2025  Kamil Roszczyk  - Bugfixing:
							- added RET_PROD_LINES_GROSS_AMOUNT column to t_fraud_detection_returns_common
							- replaced header gross value with lines gross value based on RET_PROD_LINES_GROSS_AMOUNT calculation in a logic for RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG in step 2.1
								https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/70166
*/



-- step 1.0 - create temp table with all receipts that satisfy the common conditions
CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.t_fraud_detection_returns_common
DATA_RETENTION_TIME_IN_DAYS = 0
(
        RET_RETAIL_EVENT_SID
        ,RET_LOCAL_PROD_NR -- RET_PROD_VARIANT_SID
        
    	,RET_CASH_REGISTER_EVENT_NR
    	,RET_EVENT_START_TMSP
    	,RET_BUS_DT
    	,RET_CASH_REGISTER_SID
    	,RET_STORE_SID
        ,RET_COUNTRY_ORG_CD
    	,RET_CASHIER_HASH
    	,RET_TXN_NET_VAL
    	,RET_TXN_GROSS_VAL
    	,RET_CURR_CD
    	,RET_AUTH_BY_HASH_EVT
        ,ORIG_BUS_DT
        ,ORIG_CASHIER_HASH
		,ORIG_RETAIL_EVENT_SID
		,IS_KE_INPUT_FG
		,IS_DV_INPUT_FG
		,IS_LS_INPUT_FG					
        
        ,RET_PROD_QTY 					-- returned prod qty
        ,PAR_SAME_PROD_QTY				-- "purchased after return" same prod qty
        ,PAR_DISTINCT_PROD_CNT 			-- how many different Products exist in the Purchase after the Return
		,RET_LINES_CNT					-- how many lines for return exist in the return receipt (total, not per ProdVariant)
		,RET_DISTINCT_PROD_CNT 			-- how many different Products are returned 
		,RET_AND_PURCH_DISTINCT_PROD_CNT	-- how many different Products exist both in the Return Receipt AND in the Purchase after the return receipt
		,RET_TOTAL_LINES                -- how many lines for return exist in the return receipt together with deposit return lines
		,RET_PROD_LINES_GROSS_AMOUNT	-- return amount of a Product Variant calculated using only return lines
		
		,IS_SAME_CASHIER_FG				-- same cashier(employee_2) on original purchase and the return receipt
		,IS_QUANTITY_SUSPICIOUS_FG		-- *see below how column is calculated
        ,IS_DOPPELTIPPER_FG				-- return is a correction of an accidental double scan in original receipt (Doppeltipper)
		,IS_ALL_PROD_LINES_NO_AUTH_FG	-- all lines for a product variant are not authorized when returned
)
AS
WITH
returned_products AS 
-- prefix RET_ stands for "Return" not "Retail"
(
	SELECT
		re.retail_event_sid           		AS RET_RETAIL_EVENT_SID
		,prl.local_prod_nr           		AS RET_LOCAL_PROD_NR
        
		,any_value(re.event_start_tmsp)			AS ret_event_start_tmsp
		,any_value(re.bus_dt)                	AS ret_bus_dt
		,any_value(re.country_org_cd)        	AS ret_country_org_cd
		,any_value(re.store_sid)             	AS ret_store_sid
		,any_value(re.cash_register_sid)     	AS ret_cash_register_sid
		,any_value(re.cash_register_event_nr)	AS ret_cash_register_event_nr
		,any_value(re.cashier_hash)          	AS ret_cashier_hash
		,any_value(ce.cashier_nr)          		AS ret_cashier_nr
		,any_value(re.txn_gross_val)         	AS ret_txn_gross_val
		,any_value(re.txn_net_val)           	AS ret_txn_net_val
		,any_value(re.curr_cd)               	AS ret_curr_cd
		,any_value(re.auth_by_hash)           	AS ret_auth_by_hash_evt -- authorization on event level (can be different from the line level)
		
        ,SUM(COALESCE(prl.PROD_VARIANT_QTY, PROD_VARIANT_CNT))   AS RET_PROD_QTY -- returned Product Variant quantity
        ,SUM(RET_PROD_QTY) OVER (PARTITION BY re.retail_event_sid)   AS RET_TOTAL_QTY -- returned total quantity
        ,COUNT(*)                               AS RET_PROD_LINES_CNT -- how many lines exist on the return receipt for this Product Variant
        ,SUM(RET_PROD_LINES_CNT) OVER (PARTITION BY re.retail_event_sid) AS RET_LINES_CNT   --how many lines exists in the whole receipt
		,SUM(DECODE(prl.AUTH_BY_HASH, NULL, 0, 1)) AS RET_PROD_AUTH_LINES_CNT	--how many lines for a product variant have been authorized in return receipt
		,SUM(prl.retail_line_gross_val) AS RET_PROD_LINES_GROSS_AMOUNT	-- return amount of a Product Variant calculated using only return lines
        ,SUM(decode(prl.PROD_ENTRY_METHOD_CD, 'KE', 1, 0)) AS IS_KE_INPUT_FG
		,SUM(decode(prl.PROD_ENTRY_METHOD_CD, 'DV', 1, 0)) AS IS_DV_INPUT_FG
		,SUM(decode(prl.PROD_ENTRY_METHOD_CD, 'LS', 1, 0)) AS IS_LS_INPUT_FG
        
        ,any_value(prl.orig_sales_event_sid)	    AS orig_retail_event_sid
        ,any_value(orig_re.bus_dt) 					AS orig_bus_dt
		,any_value(orig_re.country_org_cd) 			AS orig_country_org_cd
		,any_value(orig_re.store_sid) 				AS orig_store_sid
		,any_value(orig_re.cashier_hash)           	AS orig_cashier_hash
		,any_value(orig_ce.cashier_nr)           	AS orig_cashier_nr
        ,any_value(orig_re.event_start_tmsp)       	AS orig_event_start_tmsp
        ,any_value(orig_re.cash_register_sid) 		AS orig_cash_register_sid
		,any_value(orig_re.cash_register_event_nr)	AS orig_cash_register_event_nr


	FROM ${FWRK_WORK_DB}.VT1
        JOIN core_rel.T_RETAIL_EVENT_2 re_2
                ON re.STORE_SID = vt1.LOC_SID
                AND re.COUNTRY_ORG_CD  = vt1.COUNTRY_CD
                AND re.BUS_DT = vt1.DWH_CAL_DT
		JOIN core_rel.T_PRODUCT_RETAIL_LINE_2 prl
				ON prl.RETAIL_EVENT_SID = re.RETAIL_EVENT_SID
                AND prl.STORE_SID = re.STORE_SID
                AND prl.COUNTRY_ORG_CD  = re.COUNTRY_ORG_CD
                AND prl.BUS_DT = re.BUS_DT
		JOIN core_app_fraud_detection.T_CASHIER_ENCRYPTION_2 ce
				on ce.CASHIER_HASH = re.CASHIER_HASH
		LEFT JOIN core_rel.T_RETAIL_EVENT_2 orig_re
				ON orig_re.RETAIL_EVENT_SID = prl.ORIG_SALES_EVENT_SID
                AND orig_re.RETAIL_EVENT_TYPE_CD = 'S'
		LEFT JOIN core_app_fraud_detection.T_CASHIER_ENCRYPTION_2 orig_ce
				on orig_ce.CASHIER_HASH = orig_re.CASHIER_HASH
	WHERE 1=1
        AND re.RETAIL_EVENT_TYPE_CD = 'R'
        AND re.turnover_relevant_fg = TRUE
		AND re.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt --Delta date logic
		
        AND prl.RETAIL_EVENT_LINE_SCENARIO_ID BETWEEN 140 AND 149	--Return receipt lines
        --AND prl.PROD_RETAIL_LINE_TYPE_CD in ('R', 'RD')	--Filter removed - not all lines with scenario ID between 140 and 149 are marked as retail line type 'R' or 'RD'. Change compliant with old system
		AND prl.BUS_DT BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt --Delta date logic
		
	GROUP BY
		-- we might have several lines for returning same product (3 lines for returning Chips for example)
		-- we want to evaluate conditions based on LOCAL_PROD_NR, the quantity and amounts for them
		re.retail_event_sid
		,prl.LOCAL_PROD_NR	
)
-----------------------------------------------------------------
-- Doppeltipper - distinctive original receipts (returned_products CTE may contain duplicated original receipt data for the same return and different products OR for different returns that can reference the same original receipt)
--
-- if we have more than one Return Event made with same purchase receipt, then the purchase receipt is not "doppletipper" candidate, and we exclude it
-- the delta interval (VT1) is artificially extended by 10 additional days backwards to reevaluate returns that happened before (in the initial script - zkp_reagg_delta_insert.sql)
-- it is possible that when such return happened it was the only one made with that purchase receipt, and now we have another return for that purchase so "doppletipper" result will be different
--
-- we realise that there could be older returns and we will not reevaluate them 
-- statistical analysis shows that expanding VT1 by 10 days covers more than 99.7% of the relevant cases and this is good enough for the business
,original_receipts AS
(
    SELECT
        ORIG_RETAIL_EVENT_SID
    FROM
        returned_products
    WHERE 
		ORIG_RETAIL_EVENT_SID IS NOT NULL
	
	GROUP BY ORIG_RETAIL_EVENT_SID
	HAVING COUNT(distinct RET_RETAIL_EVENT_SID) = 1
)

-----------------------------------------------------------------
-- Doppeltipper - calculate line rankings and product quantity
--
,doppeltipper_line_ranks AS
(
    SELECT
        orig.ORIG_RETAIL_EVENT_SID
        ,tprl.LOCAL_PROD_NR
		,tprl.PROD_ENTRY_METHOD_CD
		,tprl.CANCEL_LINE_SEQ
		,ZEROIFNULL(tprl.PROD_VARIANT_CNT) + ZEROIFNULL(tprl.PROD_VARIANT_QTY) AS PROD_VARIANT_QTYX
        ,ROW_NUMBER() OVER (PARTITION BY orig.ORIG_RETAIL_EVENT_SID ORDER BY tprl.EVENT_START_TMSP, tprl.RETAIL_EVENT_LINE_SEQ) AS LINE_RN
    FROM original_receipts orig
        JOIN core_rel.T_PRODUCT_RETAIL_LINE_2 tprl
				ON orig.ORIG_RETAIL_EVENT_SID = tprl.RETAIL_EVENT_SID
)
-----------------------------------------------------------------
-- Doppeltipper - detect scanned product changes in original receipts
--
,doppeltipper_changes AS
(
    SELECT
        *
		--Doppeltipper: mark row if this and the previous row were scanned
		, CASE
			WHEN EQUAL_NULL(LAG(PROD_ENTRY_METHOD_CD) OVER(PARTITION BY ORIG_RETAIL_EVENT_SID ORDER BY LINE_RN), PROD_ENTRY_METHOD_CD)
				AND PROD_ENTRY_METHOD_CD = 'SC'
			THEN 1
			ELSE 0
			END AS CURR_AND_PREV_SCANNED_FG
		--Doppeltipper: mark row as not changed only when the item_2 and quantity are the same as in a previous row and when this is the consecutive scan
		, CASE 
			WHEN CURR_AND_PREV_SCANNED_FG = 1
				AND EQUAL_NULL(LAG(LOCAL_PROD_NR) OVER(PARTITION BY ORIG_RETAIL_EVENT_SID ORDER BY LINE_RN), LOCAL_PROD_NR)
				AND EQUAL_NULL(LAG(PROD_VARIANT_QTYX) OVER(PARTITION BY ORIG_RETAIL_EVENT_SID ORDER BY LINE_RN), PROD_VARIANT_QTYX)
			THEN 0
			ELSE 1
		END AS CHANGE_FG
    FROM doppeltipper_line_ranks
)
-----------------------------------------------------------------
-- Doppeltipper - calculate group IDs as series of scanned products
--
,event_lines_groups AS
(
    SELECT
        *
        ,SUM(CHANGE_FG) OVER (
				PARTITION BY ORIG_RETAIL_EVENT_SID 
				ORDER BY LINE_RN 
				ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
			) 					AS GROUP_ID
    FROM doppeltipper_changes
)
-----------------------------------------------------------------
-- Doppeltipper - keep only these products for original receipts that were scanned as a series of 2 scans or more
-- and were not corrected by cancellation (storno). If doppletipper is corrected by "storno" then there is no "excuse" for the Return Event, and it would be suspicious
--
,potential_doppeltippers AS
(
    SELECT
        ORIG_RETAIL_EVENT_SID
        ,LOCAL_PROD_NR
        ,PROD_VARIANT_QTYX
        ,GROUP_ID
    FROM event_lines_groups
    GROUP BY
        ORIG_RETAIL_EVENT_SID
        ,LOCAL_PROD_NR
        ,PROD_VARIANT_QTYX
        ,GROUP_ID
    HAVING
        COUNT(*) > 1
		and COUNT(CANCEL_LINE_SEQ) = 0
    QUALIFY
		-- sometimes there are two or more series of same products being scanned consecutively - this filter is to qualify just one series out of them
		-- regardless the number of same product series in original receipt, Doppeltipper qualification assumes only one line for a product returned, previously being scanned in any but just one of the series in original receipt
        GROUP_ID = MAX(GROUP_ID) OVER (PARTITION BY ORIG_RETAIL_EVENT_SID, LOCAL_PROD_NR, PROD_VARIANT_QTYX)
)
-----------------------------------------------------------------
-- the purchase that happened after the return
--
,purch_day_and_register_of_return as 
(
	select 	
		re.RETAIL_EVENT_SID
		,re.CASH_REGISTER_EVENT_NR
		,re.BUS_DT
		,re.CASH_REGISTER_SID
		,re.TXN_GROSS_VAL
		,ce.CASHIER_NR
	from core_rel.T_RETAIL_EVENT_2 re_2
		join core_app_fraud_detection.T_CASHIER_ENCRYPTION_2 ce
			on ce.CASHIER_HASH = re.CASHIER_HASH
	where 1=1
		AND re.RETAIL_EVENT_TYPE_CD = 'S'
		and re.turnover_relevant_fg = TRUE
		and exists 
		(
			select 1
			from returned_products rp
			where rp.ret_bus_dt = re.bus_dt
                AND rp.RET_CASH_REGISTER_SID = re.CASH_REGISTER_SID
				and rp.ret_COUNTRY_ORG_CD = re.COUNTRY_ORG_CD
		)
)
,purch_event_after_return AS 
-- "PAR" = Purchase After Return
(
    SELECT 
        rp.RET_RETAIL_EVENT_SID
        ,par.RETAIL_EVENT_SID 	AS PAR_RETAIL_EVENT_SID -- could get a NULL but rows like this will be eliminated in the joins
		,par.TXN_GROSS_VAL		AS PAR_TXN_GROSS_VAL
    FROM returned_products rp
        LEFT JOIN purch_day_and_register_of_return par
                -- next receipt from the same Cashier, in the same Store, same Day
                ON rp.RET_BUS_DT = par.BUS_DT 
                AND rp.RET_CASHIER_NR = par.CASHIER_NR
                AND rp.RET_CASH_REGISTER_SID = par.CASH_REGISTER_SID
                AND rp.RET_CASH_REGISTER_EVENT_NR < par.CASH_REGISTER_EVENT_NR

        
    QUALIFY ROW_NUMBER() OVER (PARTITION BY rp.RET_RETAIL_EVENT_SID ORDER BY par.CASH_REGISTER_EVENT_NR ASC) = 1
)
-----------------------------------------------------------------
-- extract distinctive retail_event_sid values for returns
-- returned_products CTE can have more than one row per retail_event_sid due to the returns having more than one product returned
,return_receipts AS
(
    SELECT DISTINCT
        RET_RETAIL_EVENT_SID
    FROM
        returned_products
)
-----------------------------------------------------------------
-- calculating lines gross value (Bonsumme) for next receipt's cash payment comparison as per "cash amount that is given for the next receipt is diferent that total amount of return receipt" requirement
-- business testing of this requirement in old ZKP revealed that such line calculation is more precise than just taking total receipt gross value (txn_gross_val in GF_2) from the header information
-- also calculating total number of lines together with returned deposits - not possible in returned_products CTE as deposit return lines are filtered out in that CTE
-- such total number was used for filtering in old system
,calc_bonsumme AS 
(
    SELECT
		rr.RET_RETAIL_EVENT_SID
		,SUM(ABS(tprl.RETAIL_LINE_GROSS_VAL)) AS RET_BONSUMME
        ,COUNT(*) AS RET_TOTAL_LINES
    FROM return_receipts rr
        JOIN core_rel.T_PRODUCT_RETAIL_LINE_2 tprl
                ON rr.RET_RETAIL_EVENT_SID = tprl.RETAIL_EVENT_SID
	WHERE
		tprl.RETAIL_EVENT_LINE_SCENARIO_ID BETWEEN 140 AND 149	--For the Bonsumme purposes: only return lines...
		OR tprl.RETAIL_EVENT_LINE_SCENARIO_ID = 120				--...and deposit return lines
	GROUP BY
		rr.RET_RETAIL_EVENT_SID
)
-----------------------------------------------------------------
-- first cash payment within a returned receipt - kept as a separate CTE to avoid the risk of mutually exclusive QUALIFY statements within other CTEs
-- for the comparison with return's Bonsumme value as per "cash amount that is given for the next receipt is diferent that total amount of return receipt" requirement
,purch_event_after_return_cash_payment AS 
(
    SELECT
		par.RET_RETAIL_EVENT_SID
        ,par.PAR_RETAIL_EVENT_SID
		,tpl.LOCAL_PAYM_VAL
    FROM purch_event_after_return par
        JOIN core_rel.T_PAYMENT_LINE_2 tpl
                ON par.PAR_RETAIL_EVENT_SID = tpl.RETAIL_EVENT_SID
				AND tpl.PAYM_TYPE_ID = 11		--payments in cash only
				AND tpl.PAYM_LINE_TYPE_CD = 'P'	--customer payments only
    
	--take only the first cash payment (FOR EACH RETURN*) information based on the payment event line sequence
	-- if two or more returns are made one after another, then the "Next Purchase Event" for all of them will be the same, and have same PAR_RETAIL_EVENT_SID
    QUALIFY ROW_NUMBER() OVER (PARTITION BY par.RET_RETAIL_EVENT_SID, par.PAR_RETAIL_EVENT_SID ORDER BY tpl.RETAIL_EVENT_LINE_SEQ ASC) = 1
)
,purch_products_after_return_event AS
-- PAR_P = PAR P = Purchase After Return - Products
(
    SELECT 
        par.RET_RETAIL_EVENT_SID
        ,par.PAR_RETAIL_EVENT_SID
        ,prl.LOCAL_PROD_NR                 AS PAR_LOCAL_PROD_NR

        ,any_value(par.PAR_TXN_GROSS_VAL)     AS PAR_TXN_GROSS_VAL
        ,SUM(COALESCE(prl.PROD_VARIANT_QTY, prl.PROD_VARIANT_CNT))     AS PAR_PROD_QTY
		,SUM(PAR_PROD_QTY) OVER (PARTITION BY par.RET_RETAIL_EVENT_SID, par.PAR_RETAIL_EVENT_SID) AS PAR_TOTAL_QTY

        -- how many distinct products exist in the "Purchase After the Return" - used in some scenarios
        ,COUNT(DISTINCT prl.LOCAL_PROD_NR) OVER (
                    PARTITION BY par.RET_RETAIL_EVENT_SID, par.PAR_RETAIL_EVENT_SID)  AS PAR_DISTINCT_PROD_CNT
        
    FROM purch_event_after_return par
        JOIN core_rel.T_PRODUCT_RETAIL_LINE_2 prl
                ON prl.RETAIL_EVENT_SID = par.PAR_RETAIL_EVENT_SID
    WHERE 1=1
        -- Lines of purchases that happen on the same day AS the return
        AND prl.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT 
    GROUP BY 
        par.RET_RETAIL_EVENT_SID
        ,par.PAR_RETAIL_EVENT_SID
        ,prl.LOCAL_PROD_NR
)
-----------------------------------------------------------------
-- purchase that happened after the original purchase, could be empty dataset if no original receipt exists
--
,purch_day_and_register_of_orig as 
(
	select 	
		re.RETAIL_EVENT_SID
		,re.CASH_REGISTER_EVENT_NR
		,re.BUS_DT
		,re.CASH_REGISTER_SID
		,re.TXN_GROSS_VAL
		,ce.CASHIER_NR
	from core_rel.T_RETAIL_EVENT_2 re_2
		join core_app_fraud_detection.T_CASHIER_ENCRYPTION_2 ce
			on ce.CASHIER_HASH = re.CASHIER_HASH
	where 1=1
		AND re.RETAIL_EVENT_TYPE_CD = 'S'
		and re.turnover_relevant_fg = TRUE
		and exists 
		(
			select 1
			from returned_products rp
			where rp.orig_bus_dt = re.bus_dt
                AND rp.ORIG_CASH_REGISTER_SID = re.CASH_REGISTER_SID
				and rp.RET_COUNTRY_ORG_CD = re.COUNTRY_ORG_CD
		)
)
,purch_event_after_orig_purch AS
-- PAOP - Purchase After the Original Purchase
(
    SELECT 
        rp.RET_RETAIL_EVENT_SID
        ,rp.ORIG_RETAIL_EVENT_SID
        ,paop.retail_event_sid          AS PAOP_RETAIL_EVENT_SID
        ,paop.txn_gross_val
    FROM returned_products rp
        LEFT JOIN purch_day_and_register_of_orig paop
                -- next receipt after the original purchase
				-- from the same Cashier, in the same Store, same Day
				ON rp.orig_bus_dt = paop.BUS_DT 
                AND rp.orig_CASHIER_NR = paop.CASHIER_NR
				AND rp.ORIG_CASH_REGISTER_SID = paop.CASH_REGISTER_SID
                AND rp.ORIG_CASH_REGISTER_EVENT_NR < paop.CASH_REGISTER_EVENT_NR


    QUALIFY ROW_NUMBER() OVER (PARTITION BY rp.ORIG_RETAIL_EVENT_SID, rp.RET_RETAIL_EVENT_SID ORDER BY paop.CASH_REGISTER_EVENT_NR asc) = 1
)
-----------------------------------------------------------------
, common_scenarios AS 
(
    SELECT  
        rp.RET_RETAIL_EVENT_SID
        ,rp.RET_LOCAL_PROD_NR
        
    	,rp.RET_CASH_REGISTER_EVENT_NR
    	,rp.RET_EVENT_START_TMSP
    	,rp.RET_BUS_DT
    	,rp.RET_CASH_REGISTER_SID
    	,rp.RET_STORE_SID
        ,rp.RET_COUNTRY_ORG_CD
    	,rp.RET_CASHIER_HASH
    	,rp.RET_CASHIER_NR
    	,rp.RET_TXN_NET_VAL
    	,rp.RET_TXN_GROSS_VAL
    	,rp.RET_CURR_CD
    	,rp.RET_AUTH_BY_HASH_EVT
        ,rp.ORIG_BUS_DT
        ,rp.ORIG_CASHIER_HASH
        ,rp.ORIG_CASHIER_NR
		,rp.ORIG_RETAIL_EVENT_SID
		,rp.ORIG_STORE_SID
		,rp.RET_PROD_AUTH_LINES_CNT
		,rp.RET_PROD_LINES_GROSS_AMOUNT
   
        ,rp.IS_KE_INPUT_FG
		,rp.IS_DV_INPUT_FG
		,rp.IS_LS_INPUT_FG			
        
        ,rp.RET_PROD_QTY
        ,ABS(rp.RET_PROD_QTY) AS ABS_RET_PROD_QTY   -- absolute returned prod qty (calculation usage only)
        ,rp.RET_TOTAL_QTY
        ,ABS(rp.RET_TOTAL_QTY) AS ABS_RET_TOTAL_QTY	-- absolute returned total qty (calculation usage only)
        ,DECODE(rp.RET_LOCAL_PROD_NR, par_p.PAR_LOCAL_PROD_NR, par_p.PAR_PROD_QTY, 0) AS PAR_SAME_PROD_QTY	--return the quantity of a product from receipt's follower (PAR_P) if the product is also in the return receipt, otherwise leave it as 0
        ,COALESCE(par_p.PAR_TOTAL_QTY, 0) AS PAR_TOTAL_QTY
		,cb.RET_TOTAL_LINES
        
        -- how many different Products exist in the Purchase after the Return
        -- this is already calculated on Retail Event level in "PAR_P"
        ,COALESCE(par_p.PAR_DISTINCT_PROD_CNT, 0) AS PAR_DISTINCT_PROD_CNT

		-- how many lines for return exist in the return receipt (total, not per ProdVariant)
		-- this is already calculated in returned_products CTE
        ,rp.RET_LINES_CNT
		
		-- how many different Products are returned
		,COUNT(DISTINCT rp.RET_LOCAL_PROD_NR) OVER (PARTITION BY rp.RET_RETAIL_EVENT_SID) 		AS RET_DISTINCT_PROD_CNT 
		
		-- how many different Products exist in the Return Receipt AND in the Purchase after the return receipt
		-- this logic replaced former one with additional join condition on products to purch_products_after_return_event CTE
        ,SUM(CASE
                WHEN rp.RET_LOCAL_PROD_NR = par_p.PAR_LOCAL_PROD_NR THEN 1
                ELSE 0
            END) OVER (PARTITION BY rp.RET_RETAIL_EVENT_SID) AS RET_AND_PURCH_DISTINCT_PROD_CNT
                
        
		-- this value is on Event-level - it is the same for all rows of the same Event, so MAX function is ok
		-- but in case we get nothing from the left join this will be null.
		,max(par_p.PAR_TXN_GROSS_VAL) over (partition by rp.RET_RETAIL_EVENT_SID) as PAR_TXN_GROSS_VAL_1
    FROM returned_products rp
		
		-- return - Bonsumme
		JOIN calc_bonsumme cb
				ON rp.RET_RETAIL_EVENT_SID = cb.RET_RETAIL_EVENT_SID
		
		-- purchase after return - cash payments
		LEFT JOIN purch_event_after_return_cash_payment par_cp
				ON rp.RET_RETAIL_EVENT_SID = par_cp.RET_RETAIL_EVENT_SID
	
		-- purchase after original purchase 
        LEFT JOIN purch_event_after_orig_purch paop
                ON rp.RET_RETAIL_EVENT_SID = paop.RET_RETAIL_EVENT_SID
    
        -- purchase after return - Products
        LEFT JOIN purch_products_after_return_event par_p
                ON rp.RET_RETAIL_EVENT_SID = par_p.RET_RETAIL_EVENT_SID
                --AND rp.RET_LOCAL_PROD_NR = par_p.PAR_LOCAL_PROD_NR
					--Condition removed - the flag IS_QUANTITY_SUSPICIOUS_FG should evaluate records in the final query regardless the product is in both return and following sales_2 receipt or not
					--When this was enabled we were discarding lots of receipts that had their followers without the matching products - receipts being normally qualified in old system that didn't evaluate if the products are matching or not
					--Matched products' evaluation is actually needed only in two related places in this CTE and this is in RET_AND_PURCH_DISTINCT_PROD_CNT field logic and in a QUALIFY filter that utilizes this field (RET_DISTINCT_PROD_CNT <> RET_AND_PURCH_DISTINCT_PROD_CNT) - added this condition in field's logic
					--As an unnecessary outcome of skipping this condition, the records are being multiplied in this CTE (number of different products in return X number of different products in follower) - to assure that we have only one row per each receipt/product combination from returned_products CTE there is a ROW_NUMBER filter in QUALIFY section
				
    WHERE 
        -- SCENARIO_CONDITION: "value of the cash refund (receipt total) is not the same as 
		--  the receipt total of the subsequent receipt according to the corresponding original receipt"
        -- we are also including the situation when there is no original receipt or there is original receipt but not following
        (paop.PAOP_RETAIL_EVENT_SID IS NULL
        OR ABS(rp.RET_TXN_GROSS_VAL) <> paop.TXN_GROSS_VAL)
		
		-- SCENARIO_CONDITION: "cash amount that is given for the next receipt is diferent that total amount of return receipt"
        -- Putting LOCAL_PAYM_VAL in COALESCE function in case there is no purchase after return (i.e. last receipt of the day)
		-- Such case is also treated as suspicious as there is no chance to exclude this return by the following purchase with the same cash payment as Bonsumme
		AND cb.RET_BONSUMME <> COALESCE(par_cp.LOCAL_PAYM_VAL, -1)
    
    QUALIFY 1=1
		
		-- SCENARIO_CONDITION: "ALL items in the Return are NOT in the following Purchase after the Return (some could be)""
		-- if all returned prods are purchased next, left join will not return NULLs for par_pv.PAR_LOCAL_PROD_NR.
		-- then the two counts will be equal, which is fine - no suspicion for a fraud
		AND RET_DISTINCT_PROD_CNT <> RET_AND_PURCH_DISTINCT_PROD_CNT

        -- SCENARIO_CONDITION: The value of the cash refund (receipt total) is not the same as the receipt total of the subsequent receipt
		-- we must use LEFT join because of the condition above.
		-- so this condition must be evaluated in the QUALIFY part. Cannot be evaluated in the JOIN or in WHERE
		AND (PAR_TXN_GROSS_VAL_1 is null or PAR_TXN_GROSS_VAL_1 <> ABS(rp.RET_TXN_GROSS_VAL))
		
		--Filter to remove unnecessary duplicated records from this CTE and keep only one row per each receipt/product combination from returned_products CTE with option to include the same product quantity from purchase after return
		--Ordering by PAR_SAME_PROD_QTY descending and keeping nulls last during sorting just in case (PAR_SAME_PROD_QTY has COALESCE function)
		--If there is 0 in PAR_SAME_PROD_QTY, regardless it's due to the lack of purchase after return or lack of matching products in purchase after return, then this row should be last for qualifying - preference is for matching products
        AND ROW_NUMBER() OVER (PARTITION BY rp.RET_RETAIL_EVENT_SID, rp.RET_LOCAL_PROD_NR ORDER BY PAR_SAME_PROD_QTY DESC NULLS LAST) = 1
	
)
SELECT 
	cs.RET_RETAIL_EVENT_SID
	,cs.RET_LOCAL_PROD_NR
	
	,cs.RET_CASH_REGISTER_EVENT_NR
	,cs.RET_EVENT_START_TMSP
	,cs.RET_BUS_DT
	,cs.RET_CASH_REGISTER_SID
	,cs.RET_STORE_SID
	,cs.RET_COUNTRY_ORG_CD
	,cs.RET_CASHIER_HASH
	,cs.RET_TXN_NET_VAL
	,cs.RET_TXN_GROSS_VAL
	,cs.RET_CURR_CD
	,cs.RET_AUTH_BY_HASH_EVT
	
	,cs.ORIG_BUS_DT
	,cs.ORIG_CASHIER_HASH
	,cs.ORIG_RETAIL_EVENT_SID
	,cs.IS_KE_INPUT_FG
	,cs.IS_DV_INPUT_FG
	,cs.IS_LS_INPUT_FG				   
	
	,cs.RET_PROD_QTY 					-- returned prod qty
	,cs.PAR_SAME_PROD_QTY				-- "purchased after return" same prod qty
	,cs.PAR_DISTINCT_PROD_CNT 			-- how many different Prods exist in the Purchase after the Return
	,cs.RET_LINES_CNT					-- how many lines for return exist in the return receipt (total, not per ProdVariant)
	,cs.RET_DISTINCT_PROD_CNT 			-- how many different Prods are returned
	,cs.RET_AND_PURCH_DISTINCT_PROD_CNT	-- how many different Prods exist both in the Return Receipt AND in the Purchase after the return receipt
	,cs.RET_TOTAL_LINES                 -- how many lines for return exist in the return receipt together with deposit return lines
	,cs.RET_PROD_LINES_GROSS_AMOUNT		-- return amount of a Product Variant calculated using only return lines
	
	,IFF(RET_CASHIER_NR = ORIG_CASHIER_NR and RET_STORE_SID = ORIG_STORE_SID, 1, 0) as IS_SAME_CASHIER_FG		-- same cashier(employee_2) on original purchase and the return receipt
	
	-- Aditional Condition used in several scenarios
	-- (English translation): "and if the follow-up receipt (after Return) contains only 1 product, 
	--     it is not permitted to have the same number of sold pieces like on the Return receipt (unless the number is 1.0)" 
	-- (Original in German): wenn der Folgebon nach der Geldrückgabe nur 1 Artikel_2 enthält, darf dieser nicht in der gleichen
	--     Anzahl verkauft werden, wie der Artikel_2 auf der Geldrückgabe (außer die Anzahl ist 1,0)
	,CASE 
			-- if next receipt has more that 1 Prod it is suspicious
			WHEN PAR_DISTINCT_PROD_CNT > 1 THEN 1

            -- if return has more than 1 line - suspicious
            WHEN cs.RET_LINES_CNT > 1 THEN 1

			-- if next receipt has 1 Prod, but the quantity of this Prod is different than the total quantity in the Return - suspicious
			WHEN PAR_TOTAL_QTY <> ABS_RET_TOTAL_QTY THEN 1
			
			-- if next receipt has 1 PV, quantities are the same, but they are 1 in both receipts - suspicious
			WHEN PAR_TOTAL_QTY = 1 AND ABS_RET_TOTAL_QTY = 1 THEN 1
			
			-- everything else is fine
			ELSE 0
		END AS IS_QUANTITY_SUSPICIOUS_FG
	
	-- Doppeltipper:
	-- If any of the products within a return cannot be considered as a Doppeltipper then the whole receipt cannot be qualified as a Doppeltipper
	-- This is slightly different than the Doppeltipper logic in storno scenarios but this is intentional and discussed with business
    ,MIN(DECODE(pd.ORIG_RETAIL_EVENT_SID, NULL, 0, 1)) OVER (PARTITION BY cs.RET_RETAIL_EVENT_SID) AS IS_DOPPELTIPPER_FG
	
	-- If all lines were returned without authorization then set flag to 1, otherwise set to 0
	,DECODE(cs.RET_PROD_AUTH_LINES_CNT, 0, 1, 0) AS IS_ALL_PROD_LINES_NO_AUTH_FG
	
FROM common_scenarios cs
    left join potential_doppeltippers pd_2
            on pd.ORIG_RETAIL_EVENT_SID = cs.ORIG_RETAIL_EVENT_SID  -- Doppeltipper: same original receipt
            and pd.LOCAL_PROD_NR = cs.RET_LOCAL_PROD_NR             -- Doppeltipper: same product in both return and original receipt
            and pd.PROD_VARIANT_QTYX = cs.ABS_RET_PROD_QTY          -- Doppeltipper: same product quantity in both return and original receipt
            and cs.RET_LINES_CNT = cs.RET_DISTINCT_PROD_CNT         -- Doppeltipper: total number of lines in return same as the total number of distinctive products - guarantees one line per product
;
-----------------------------------------------------------------------------------------







-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Step 2.1 
-- "Same Cashier Return" - main scenario and sub-scenarios
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
	,curr_cd
	
	,RETURN_SAME_CASHIER_FG
	,RETURN_SAME_CASHIER_DIFF_DAY_FG
	,RETURN_SAME_CASHIER_AND_DAY_FG
	,RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG
	,RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG
	,RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG
	,RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG
	,RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG									  
)
WITH 
mat_params AS
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2
    WHERE SCENARIO_ID = 12 --  (US: 33395) Geldrückgabe - Originalbon gleicher Tag_2, gleicher Bediene - name should be fixed to be the name of "main scenario"
)
,eval_flags AS
(
    SELECT 
        src.*
		,SUM(ABS(src.RET_PROD_LINES_GROSS_AMOUNT)) OVER(PARTITION BY src.RET_RETAIL_EVENT_SID) AS RET_TOTAL_LINES_GROSS_AMOUNT
		
		--subscenario: same cashier, different day
		,CASE
                WHEN src.RET_BUS_DT <> src.ORIG_BUS_DT THEN 1
                ELSE 0 
            END              AS LINE_RETURN_SAME_CASHIER_DIFF_DAY_FG
		
		--subscenario: same cashier, same day
        ,CASE
                WHEN src.RET_BUS_DT = src.ORIG_BUS_DT THEN 1
																				 
                ELSE 0 
            END              AS LINE_RETURN_SAME_CASHIER_AND_DAY_FG
		
		--subscenario: same cashier, same day, total value under authorization limit
		,CASE
                WHEN src.RET_BUS_DT = src.ORIG_BUS_DT 
                    AND RET_TOTAL_LINES_GROSS_AMOUNT BETWEEN s12_rvnal.PARAM_VAL_QTY AND s12_rvnau.PARAM_VAL_QTY THEN 1
                ELSE 0 
            END              AS LINE_RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG
		
		--subscenario: same cashier, same day, manual input without DV
		,CASE
                WHEN src.RET_BUS_DT = src.ORIG_BUS_DT 
                    AND src.IS_KE_INPUT_FG THEN 1
                ELSE 0 
            END              AS LINE_RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG
		
		--subscenario: same cashier, same day with display selection
		,CASE
                WHEN src.RET_BUS_DT = src.ORIG_BUS_DT 
                    AND src.IS_LS_INPUT_FG THEN 1
                ELSE 0 
            END              AS LINE_RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG
          
    FROM ${FWRK_WORK_DB}.T_FRAUD_DETECTION_RETURNS_COMMON src -- granularity: 1 row per ProdVariant in ReturnReceipt (RET_RETAIL_EVENT_SID, RET_PROD_VARIANT_SID)
        
        JOIN mat_params s12_rv    -- Scenario 12, parameter "Refund Value (lower bound)"
            ON  s12_rv.COUNTRY_ORG_CD = src.RET_COUNTRY_ORG_CD
            AND s12_rv.SCENARIO_ID = 12
            AND s12_rv.PARAM_ID = 35
			and s12_rv.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
			
		JOIN mat_params s12_rvnal    -- Scenario 12, parameter "Refund Value not requiring authorization (lower bound)"
            ON  s12_rvnal.COUNTRY_ORG_CD = src.RET_COUNTRY_ORG_CD
            AND s12_rvnal.SCENARIO_ID = 12
            AND s12_rvnal.PARAM_ID = 36
			and s12_rvnal.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
		
		JOIN mat_params s12_rvnau    -- Scenario 12, parameter "Refund Value not requiring authorization (upper bound)"
            ON  s12_rvnau.COUNTRY_ORG_CD = src.RET_COUNTRY_ORG_CD
            AND s12_rvnau.SCENARIO_ID = 12
            AND s12_rvnau.PARAM_ID = 37
			and s12_rvnau.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
	
	WHERE 1=1
		and src.IS_QUANTITY_SUSPICIOUS_FG = 1
		and src.IS_SAME_CASHIER_FG = 1
		and abs(src.RET_TXN_GROSS_VAL) >= s12_rv.PARAM_VAL_QTY
		and src.IS_DOPPELTIPPER_FG = 0
)
,payment_types AS
(
	SELECT
		RETAIL_EVENT_SID
		,SUM(DECODE(PAYM_TYPE_ID, 11, 1, 0)) AS CASH_PAYM_LINES
		,SUM(DECODE(PAYM_TYPE_ID, 12, 1, 0)) AS CARD_PAYM_LINES
	FROM core_rel.T_PAYMENT_LINE_2
	WHERE							--not filtering on PAYM_TYPE_ID IN (11, 12) - there are other cash refund methods in use apart from cash and card, when they are picked both PAYM_LINES fields will have 0 for such receipts
		PAYM_LINE_TYPE_CD = 'R'		--only the amount returned from cashier to customer
		AND BUS_DT BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt --Delta date logic
	GROUP BY
		RETAIL_EVENT_SID
)
SELECT 
	ef.RET_RETAIL_EVENT_SID						AS CASH_REGISTER_EVENT_SID
	,any_value(ef.RET_CASH_REGISTER_EVENT_NR)	AS CASH_REGISTER_EVENT_NR
	,any_value(ef.RET_EVENT_START_TMSP)			AS EVENT_START_TMSP
	,any_value(ef.RET_BUS_DT)					AS BUS_DT
	,any_value(ef.RET_CASH_REGISTER_SID)		AS CASH_REGISTER_SID
	,any_value(cr.CASH_REGISTER_NR)				AS CASH_REGISTER_NR
	,any_value(ef.RET_STORE_SID)				AS STORE_SID
	,any_value(ef.RET_CASHIER_HASH)				AS CASHIER_HASH
	,any_value(ef.RET_TXN_NET_VAL)				AS TXN_NET_VAL
	,any_value(ef.RET_TXN_GROSS_VAL)			AS TXN_GROSS_VAL
	,any_value(ef.RET_CURR_CD)					AS CURR_CD

	,any_value(ef.IS_SAME_CASHIER_FG)			AS RETURN_SAME_CASHIER_FG
	,IFF(SUM(LINE_RETURN_SAME_CASHIER_DIFF_DAY_FG)>0,1,0)					AS RETURN_SAME_CASHIER_DIFF_DAY_FG
	,IFF(SUM(LINE_RETURN_SAME_CASHIER_AND_DAY_FG)>0,1,0)					AS RETURN_SAME_CASHIER_AND_DAY_FG
	,IFF(SUM(LINE_RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG)>0,1,0)		AS RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG
	,IFF(SUM(LINE_RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG)>0,1,0)				AS RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG
	,IFF(SUM(LINE_RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG)>0,1,0)		AS RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG
	
	--subscenario: same cashier, same day, refund made in cash
	,CASE
			WHEN RETURN_SAME_CASHIER_AND_DAY_FG = 1
				AND any_value(pt.CASH_PAYM_LINES) > 0 THEN 1
			ELSE 0
		END																	AS RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG
	
	--subscenario: same cashier, same day, refund made on card
	,CASE
			WHEN RETURN_SAME_CASHIER_AND_DAY_FG = 1
				AND any_value(pt.CARD_PAYM_LINES) > 0 THEN 1
			ELSE 0
		END																	AS RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG

FROM eval_flags ef
	JOIN core_rel.T_CASH_REGISTER_2 cr
		ON ef.RET_CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE
	JOIN payment_types pt
		ON ef.RET_RETAIL_EVENT_SID = pt.RETAIL_EVENT_SID
GROUP BY 
	RET_RETAIL_EVENT_SID	
;
-----------------------------------------------------------------------------------------






-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Step 2.2
-- "Multiple products Return" - main scenario and sub-scenarios
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
	,curr_cd
	
	,RETURN_MULT_PROD_FG
	,RETURN_MULT_PROD_FULL_QTY_FG
	,RETURN_MULT_PROD_SAME_CASHIER_FG
)
WITH 
mat_params AS
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2
    WHERE SCENARIO_ID = 14	--	(US: 33408) Geldrückgabe mehrerer Artikel_2 eines Originalbons 
)
,orig_purch_prod_variants as
(
	SELECT 
        prl.RETAIL_EVENT_SID			as ORIG_RETAIL_EVENT_SID
        ,prl.LOCAL_PROD_NR           	as ORIG_LOCAL_PROD_NR
        ,SUM(COALESCE(prl.PROD_VARIANT_QTY, prl.PROD_VARIANT_CNT))     AS ORIG_PROD_QTY
		
		-- how many different Prods are purchased with the original receipt
		,count(distinct prl.LOCAL_PROD_NR) over (partition by prl.RETAIL_EVENT_SID) as ORIG_DIFF_PROD_CNT
    FROM core_rel.T_PRODUCT_RETAIL_LINE_2 prl

    WHERE 1=1
	    and prl.PROD_RETAIL_LINE_TYPE_CD in ('S', 'SD')
        and prl.turnover_relevant_fg = TRUE
        and exists
		(
			SELECT 1
			FROM ${FWRK_WORK_DB}.T_FRAUD_DETECTION_RETURNS_COMMON src
			WHERE 1=1
				and src.ORIG_RETAIL_EVENT_SID = prl.RETAIL_EVENT_SID
				and src.ORIG_BUS_DT = prl.BUS_DT 
				and src.RET_COUNTRY_ORG_CD = prl.COUNTRY_ORG_CD
		)
    GROUP BY 
        prl.RETAIL_EVENT_SID
        ,prl.LOCAL_PROD_NR
)
,main_scenario AS
(
    SELECT 
        ret_p.*
            
        -- flag RETURN_MULT_PROD_FG - Main Scenario  
        ,1	AS LINE_RETURN_MULT_PROD_FG
		
    FROM ${FWRK_WORK_DB}.T_FRAUD_DETECTION_RETURNS_COMMON ret_p -- returned products

        JOIN mat_params s14_rv    -- Scenario 14, parameter "Refund Value (lower bound)"
				ON  s14_rv.COUNTRY_ORG_CD = ret_p.RET_COUNTRY_ORG_CD
				AND s14_rv.SCENARIO_ID = 14
				AND s14_rv.PARAM_ID = 41
				and s14_rv.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
        JOIN mat_params s14_lc    -- Scenario 14, parameter "Lines Count" - number of lines for returns
				ON  s14_lc.COUNTRY_ORG_CD = ret_p.RET_COUNTRY_ORG_CD
				AND s14_lc.SCENARIO_ID = 14
				AND s14_lc.PARAM_ID = 40
				and s14_lc.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
			
	WHERE 1=1
		-- conditions for main scenario "Return Multiple Products"
		-- they are valid for all sub-scenarios of this scenario
		-- "RET_TOTAL_LINES" and "RET_TXN_GROSS_VAL" are total values for the whole return event. (not value per ProdVariant)
		and ret_p.RET_TOTAL_LINES >= s14_lc.PARAM_VAL_QTY
		and abs(ret_p.RET_TXN_GROSS_VAL) >= s14_rv.PARAM_VAL_QTY
		-- IS_QUANTITY_SUSPICIOUS_FG filter applied on the request of Lucas
		and ret_p.IS_QUANTITY_SUSPICIOUS_FG = 1
		-- check if original receipt exists by verifying if the bus_dt is null or not
        -- sometimes cashiers enter dummy_2 value into orig_sales_event_sid even when the original receipt is not available
        and ret_p.ORIG_BUS_DT IS NOT NULL
)
,sub_scenarios as 
(
	SELECT 
		ret_p.*
		
		,IFF(abs(ret_p.RET_PROD_QTY) = pur_p.ORIG_PROD_QTY, 1, 0) IS_PROD_FULLY_RETURNED_FG
			
		-- how many of the purchased product variants are fully returned (all quantities are returned) in a single return event. 
		,sum(IS_PROD_FULLY_RETURNED_FG) over (
				partition by pur_p.ORIG_RETAIL_EVENT_SID, ret_p.RET_RETAIL_EVENT_SID) as FULLY_RETURNED_PROD_CNT
				
		,IFF(pur_p.ORIG_DIFF_PROD_CNT = FULLY_RETURNED_PROD_CNT, 1, 0) as RETURN_MULT_PROD_FULL_QTY_FG
	FROM main_scenario ret_p -- returned products
		full outer join orig_purch_prod_variants pur_p -- products in the original purchase
				on pur_p.ORIG_RETAIL_EVENT_SID = ret_p.ORIG_RETAIL_EVENT_SID
				and pur_p.ORIG_LOCAL_PROD_NR = ret_p.RET_LOCAL_PROD_NR
)
SELECT 
	ef.RET_RETAIL_EVENT_SID						AS CASH_REGISTER_EVENT_SID
	,any_value(ef.RET_CASH_REGISTER_EVENT_NR)	AS CASH_REGISTER_EVENT_NR
	,any_value(ef.RET_EVENT_START_TMSP)			AS EVENT_START_TMSP
	,any_value(ef.RET_BUS_DT)					AS BUS_DT
	,any_value(ef.RET_CASH_REGISTER_SID)		AS CASH_REGISTER_SID
	,any_value(cr.CASH_REGISTER_NR)				AS CASH_REGISTER_NR
	,any_value(ef.RET_STORE_SID)				AS STORE_SID
	,any_value(ef.RET_CASHIER_HASH)				AS CASHIER_HASH
	,any_value(ef.RET_TXN_NET_VAL)				AS TXN_NET_VAL
	,any_value(ef.RET_TXN_GROSS_VAL)			AS TXN_GROSS_VAL
	,any_value(ef.RET_CURR_CD)				AS CURR_CD

	,IFF(SUM(LINE_RETURN_MULT_PROD_FG)>0,1,0)		AS RETURN_MULT_PROD_FG -- main scenario
	,IFF(SUM(RETURN_MULT_PROD_FULL_QTY_FG)>0,1,0)		AS RETURN_MULT_PROD_FULL_QTY_FG -- sub-scenario
	,IFF(SUM(ef.IS_SAME_CASHIER_FG)>0,1,0)		        AS RETURN_MULT_PROD_SAME_CASHIER_FG -- sub-scenario

FROM sub_scenarios ef
	JOIN core_rel.T_CASH_REGISTER_2 cr
		ON ef.RET_CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE
GROUP BY 
	RET_RETAIL_EVENT_SID
HAVING RETURN_MULT_PROD_FG = 1
;
-----------------------------------------------------------------------------------------





-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Step 2.3 
-- "Return without authorization" and "Return without original receipt"
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
	,curr_cd

	,RETURN_WITHOUT_AUTH_FG
)
WITH 
mat_params AS
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2
    WHERE SCENARIO_ID = 7       --  (US: 33396) Geldrückgabe nicht autorisierungspflichtig 
)
,eval_flags AS
(
    SELECT
        src.*

        ,CASE
                WHEN 
                    abs(src.RET_TXN_GROSS_VAL) >= s7_rv_min.PARAM_VAL_QTY 
                    AND src.IS_DOPPELTIPPER_FG = 0
                    AND src.IS_ALL_PROD_LINES_NO_AUTH_FG = 1
                    AND src.RET_AUTH_BY_HASH_EVT IS NULL THEN 1 
                ELSE 0 
            END              AS LINE_RETURN_WITHOUT_AUTH_FG 
    
    FROM ${FWRK_WORK_DB}.T_FRAUD_DETECTION_RETURNS_COMMON src -- granularity: 1 row per Prod in ReturnReceipt (RET_RETAIL_EVENT_SID, RET_LOCAL_PROD_NR)
    
        JOIN mat_params s7_rv_min    -- Scenario 7, parameter "Refund Value (lower bound)"
            ON  s7_rv_min.COUNTRY_ORG_CD = src.RET_COUNTRY_ORG_CD
            AND s7_rv_min.SCENARIO_ID = 7
            AND s7_rv_min.PARAM_ID = 21
			and s7_rv_min.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE

	WHERE 1=1
		and src.IS_QUANTITY_SUSPICIOUS_FG = 1
)
SELECT 
	ef.RET_RETAIL_EVENT_SID						AS CASH_REGISTER_EVENT_SID
	,any_value(ef.RET_CASH_REGISTER_EVENT_NR)	AS CASH_REGISTER_EVENT_NR
	,any_value(ef.RET_EVENT_START_TMSP)			AS EVENT_START_TMSP
	,any_value(ef.RET_BUS_DT)					AS BUS_DT
	,any_value(ef.RET_CASH_REGISTER_SID)		AS CASH_REGISTER_SID
	,any_value(cr.CASH_REGISTER_NR)				AS CASH_REGISTER_NR
	,any_value(ef.RET_STORE_SID)				AS STORE_SID
	,any_value(ef.RET_CASHIER_HASH)				AS CASHIER_HASH
	,any_value(ef.RET_TXN_NET_VAL)				AS TXN_NET_VAL
	,any_value(ef.RET_TXN_GROSS_VAL)			AS TXN_GROSS_VAL
	,any_value(ef.RET_CURR_CD)					AS CURR_CD

	,IFF(SUM(LINE_RETURN_WITHOUT_AUTH_FG) = any_value(ef.RET_DISTINCT_PROD_CNT),1,0)        AS RETURN_WITHOUT_AUTH_FG -- all the lines for all products have no authorisation, mark the receipt

FROM eval_flags ef
	JOIN core_rel.T_CASH_REGISTER_2 cr
		ON ef.RET_CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE
GROUP BY 
	RET_RETAIL_EVENT_SID
HAVING RETURN_WITHOUT_AUTH_FG = 1
;




-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Step 2.4
-- "Return without original receipt"
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
	,curr_cd

	,RETURN_WITHOUT_RECEIPT_FG
	,RETURN_WITHOUT_RECEIPT_KE_INPUT_FG
	,RETURN_WITHOUT_RECEIPT_DV_INPUT_FG
)
WITH 
mat_params AS
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2
    WHERE SCENARIO_ID = 13	    --	(US: 33407, 56048) Geldrückgabe ohne Originalbon (manuell), Geldrückgaben ohne Originalbon mit Erfassungsart "DV"  																																						 
)
,eval_flags AS
(
    SELECT
        src.*
    
        -- flag RETURN_WITHOUT_RECEIPT_KE_INPUT_FG - main scenarioID = 13
        -- (US: 33407) Geldrückgabe ohne Originalbon (manuell)
        ,CASE
                WHEN 
                    abs(src.RET_TXN_GROSS_VAL) >= s13_rv.PARAM_VAL_QTY
                    AND src.ORIG_BUS_DT IS NULL THEN 1 -- no original receipt found
                ELSE 0 
            END				AS LINE_RETURN_WITHOUT_RECEIPT_FG
			
        -- flag RETURN_WITHOUT_RECEIPT_KE_INPUT_FG - main scenarioID = 13
        -- (US: 33407) Geldrückgabe ohne Originalbon (manuell)
        ,CASE
                WHEN 
                    abs(src.RET_TXN_GROSS_VAL) >= s13_rv.PARAM_VAL_QTY
                    AND src.ORIG_BUS_DT IS NULL -- no original receipt found
                    AND src.IS_KE_INPUT_FG THEN 1
                ELSE 0 
            END              AS LINE_RETURN_WITHOUT_RECEIPT_KE_FG
			
        -- flag RETURN_WITHOUT_RECEIPT_DV_INPUT_FG - main scenarioID = 13
        -- (US: 56048) Geldrückgaben ohne Originalbon mit Erfassungsart "DV"
        ,CASE
                WHEN 
                    abs(src.RET_TXN_GROSS_VAL) >= s13_rv.PARAM_VAL_QTY
                    AND src.ORIG_BUS_DT IS NULL -- no original receipt found
                    AND src.IS_DV_INPUT_FG THEN 1
                ELSE 0 
            END              AS LINE_RETURN_WITHOUT_RECEIPT_DV_FG
    
    FROM ${FWRK_WORK_DB}.T_FRAUD_DETECTION_RETURNS_COMMON src -- granularity: 1 row per Prod in ReturnReceipt (RET_RETAIL_EVENT_SID, RET_LOCAL_PROD_NR)

        JOIN mat_params s13_rv    -- Scenario 13, parameter "Refund Value (lower bound)"
            ON  s13_rv.COUNTRY_ORG_CD = src.RET_COUNTRY_ORG_CD
            AND s13_rv.SCENARIO_ID = 13
            AND s13_rv.PARAM_ID = 39	
			and s13_rv.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
	WHERE 1=1
		and src.IS_QUANTITY_SUSPICIOUS_FG = 1
)
SELECT 
	ef.RET_RETAIL_EVENT_SID						AS CASH_REGISTER_EVENT_SID
	,any_value(ef.RET_CASH_REGISTER_EVENT_NR)	AS CASH_REGISTER_EVENT_NR
	,any_value(ef.RET_EVENT_START_TMSP)			AS EVENT_START_TMSP
	,any_value(ef.RET_BUS_DT)					AS BUS_DT
	,any_value(ef.RET_CASH_REGISTER_SID)		AS CASH_REGISTER_SID
	,any_value(cr.CASH_REGISTER_NR)				AS CASH_REGISTER_NR
	,any_value(ef.RET_STORE_SID)				AS STORE_SID
	,any_value(ef.RET_CASHIER_HASH)				AS CASHIER_HASH
	,any_value(ef.RET_TXN_NET_VAL)				AS TXN_NET_VAL
	,any_value(ef.RET_TXN_GROSS_VAL)			AS TXN_GROSS_VAL
	,any_value(ef.RET_CURR_CD)					AS CURR_CD

	,IFF(SUM(LINE_RETURN_WITHOUT_RECEIPT_FG)>0,1,0)			                AS RETURN_WITHOUT_RECEIPT_FG
	,IFF(SUM(LINE_RETURN_WITHOUT_RECEIPT_KE_FG)>0,1,0)      	        	AS RETURN_WITHOUT_RECEIPT_KE_INPUT_FG	
	,IFF(SUM(LINE_RETURN_WITHOUT_RECEIPT_DV_FG)>0,1,0)	        	        AS RETURN_WITHOUT_RECEIPT_DV_INPUT_FG
FROM eval_flags ef
	JOIN core_rel.T_CASH_REGISTER_2 cr
		ON ef.RET_CASH_REGISTER_SID = cr.CASH_REGISTER_SID
		AND cr.DWH_VALID_FG = TRUE
GROUP BY 
	RET_RETAIL_EVENT_SID
-- at least one flag is true
HAVING RETURN_WITHOUT_RECEIPT_FG = 1
;
