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
		US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/33408/
		"money refund with more than on item for the original receipt" / "Geldrückgabe mehrerer Artikel eines Originalbons"
		flag: RETURN_MULT_PROD_FG
		
        US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/33396/
		"Geldrückgabe nicht autorisierungspflichtig"
		flag: RETURN_WITHOUT_AUTH_FG 
        
		US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/33395/ 
		"Geldrückgabe - Originalbon gleicher Tag, gleicher Bediene"
		flag: RETURN_SAME_CASHIER_AND_DAY_FG 
        
		US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/33407/
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
	
					US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/56040/
					"ZKP: Money refund with all item for the original receipt / Geldrückgabe aller Artikel eines Originalbons"
					flag: RETURN_MULT_PROD_FULL_QTY_FG
				
#  2.1  	11.11.2024  Mihail Ivanov  - adding sub-scenarios 
			
			flag: RETURN_WITHOUT_RECEIPT_FG - changed logic
			flag: RETURN_WITHOUT_RECEIPT_KE_INPUT_FG  is added - which is actually specified in 
				US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/33407/
				"Geldrückgabe ohne Originalbon (manuell)" 
			
				
			
			Added sub-scenario for Return Without Receipt:
			US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/56048
			"ZKP:  money refund without original receipt "DV" / Geldrückgaben ohne Originalbon mit Erfassungsart "DV""
			flag: RETURN_WITHOUT_RECEIPT_DV_INPUT_FG

#  2.2  	13.11.2024  Mihail Ivanov  - bugfixes in WHERE/QUALIFY conditions in  step1.0 (t_fraud_detection_returns_common)

#  2.3		13.11.2024  Kamil Roszczyk - added IS_PV_LS_INPUT_FG flag to the temporary table definition in step 1.0,
										 added sub-scenarios to step 2.1:
			
			US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/56001
			"ZKP: money refund / Geldrückgabe – sub scenarios to Originalbon gleicher Tag, gleicher Bediener"
			flag: RETURN_SAME_CASHIER_FG - new flag
			flag: RETURN_SAME_CASHIER_DIFF_DAY_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_FG - enhanced logic
			flag: RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG - new flag
			flag: RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG - new flag


#  2.4  	21.11.2024  Mihail Ivanov  - bugfixes: next receipt taken by ordering CASH_REGISTER_EVENT_NR for same day and CASH_REGISTER_SID
										as defined here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/53633
										
										bugfix: flag IS_SAME_CASHIER_FG is evaluated based on CASHIER_NR and STORE_SID now (not CASHIER_HASH, because same cashier has new hash every day)
	
	
	
#	
#	2.5		03.12.2024  Mihail Ivanov  - bugfix 
#				Products matched by LOCAL_PROD_NR instead of PROD_VARIANT_SID
#				as required for fix in other scenarios in this bug: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/59294/
#				the logic should be consistent so we apply same logic here
#
#  	2.6		15.01.2025  Kamil Roszczyk - added new rules to the logic
			US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/61201
				- added IS_QUANTITY_SUSPICIOUS_FG filter to "Multiple products Return" scenario temp table query
				- added the logic and the filter to load only these return receipts data where the return's Bonsumme value is different than the first payment in cash for the following receipt - added in t_fraud_detection_returns_common temp table as it's a common filter
				- added Doppeltipper logic - detect and exclude returns if they are classified as with mistakenly scanned product lines. Logic added to t_fraud_detection_returns_common temp table, filters added to "Same Cashier Return" and "Return without authorization" scenarios temp tables

#  	2.7		20.01.2025	Kamil Roszczyk - bugfixing
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/62194
				Modified temp table in step 1.0:
					- renamed PAR_PROD_QTY column to PAR_SAME_PROD_QTY
					- removed the join condition to purch_products_after_return_event set in common_scenarios CTE
					- adjusted all existing calculations within common_scenarios CTE to the lack of aforementioned join condition
					- changed the method of calculating IS_QUANTITY_SUSPICIOUS_FG to reflect the old ZKP system algorithms, minor changes of other CTEs to get the data for the needs of IS_QUANTITY_SUSPICIOUS_FG changes
			
#	2.8		21.01.2025  Mihail Ivanov  - changes
					"Return amount   (upper bound)" Threshold for Return without authorizartion (step 2.3) is removed as requested here:
					https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/55225


			
#	2.9		12.02.2025  Andrzej Wandtke  - 64557 : change for flag RETURN_WITHOUT_AUTH_FG - add condition on t_retail_event.auth_by_hash as to exclude receipts with an approval on event level

#	2.10	19.02.2025  Kamil Roszczyk - bugfixing
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/64336
				- added RET_TOTAL_LINES attribute to t_fraud_detection_returns_common; replaced RET_LINES_CNT with RET_TOTAL_LINES in step 2.2 comparison with parameter
				- fixed multiplication of Bonsumme values by adding return_receipts CTE
				- added filter in step 2.2 main_scenario CTE for excluding returns without original receipt
				- removed PROD_RETAIL_LINE_TYPE_CD filter in t_fraud_detection_returns_common

#	2.11	24.02.2025  Kamil Roszczyk - bugfixing
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/64557
				- removed RET_AUTH_BY_HASH from t_fraud_detection_returns_common and all references to this column
				- added IS_ALL_PROD_LINES_NO_AUTH_FG flag - it indicates if all lines for same product in return receipt were not authorized
				- modified the RETURN_WITHOUT_AUTH_FG logic in step 2.3 so it can handle situation with multiple lines for same product having different authorization status

#	2.12	26.02.2025	Kamil Roszczyk - bugfixing
			https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/64688
				- in common_scenarios CTE of t_fraud_detection_returns_common temp table added COALESCE functions to few fields originating from purchase after returns to make sure they are not null but 0 in case there is no purchase after return available (same was done in old system)
				- modified one of QUALIFY conditions in common_scenarios CTE

#	2.13	06.03.2025  Mihail Ivanov  - some window functions had only the SID of "Purchase After Return" in the "partition by",
							but this SID will be the same for many returns if they are done immediately after each other.
							If the take 1 row per "Purchase after retunr SID" we will take only 1 of many Returns, the other will be eliminated.
							So now the "partition by" includes SID of the Return + SID of the Next Purchase Event ( where this is necessary)
                                                        reported here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/65894				
				
#	2.14	10.03.2025  Mihail Ivanov  - Changes in "Doppletipper" logic 
							requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/66175
				

#  2.15  	26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenario is enabled in a country (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
						- Using CASHIER_NR to determine next receipt by same employee. This is necessary because sometimes we get two hashes for same Store+Day+CashierNR			

#  2.16  	02.04.2025  Andrzej Wandtke  - Changes: populate the flag RETURN_MULT_PROD_SAME_CASHIER_FG
                                              https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/66944

#  2.17  	03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  2.18		12.05.2025  Kamil Roszczyk  - Bugfixing:
							- added RET_PROD_LINES_GROSS_AMOUNT column to t_fraud_detection_returns_common
							- replaced header gross value with lines gross value based on RET_PROD_LINES_GROSS_AMOUNT calculation in a logic for RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG in step 2.1
								https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/70166
*/



-- step 1.0 - create temp table with all receipts that satisfy the common conditions
CREATE OR REPLACE TEMP TABLE t_fraud_detection_returns_common
(
       ret_retail_event_sid
      ,ret_local_prod_nr -- ret_prod_variant_sid        
    	,ret_cash_register_event_nr
    	,ret_event_start_tmsp
    	,ret_bus_dt
    	,ret_cash_register_sid
    	,ret_store_sid
      ,ret_country_org_cd
    	,ret_cashier_hash
    	,ret_txn_net_val
    	,ret_txn_gross_val
    	,ret_curr_cd
    	,ret_auth_by_hash_evt
      ,orig_bus_dt
      ,orig_cashier_hash
		  ,orig_retail_event_sid
		  ,is_ke_input_fg
		  ,is_dv_input_fg
		  ,is_ls_input_fg		
      ,ret_prod_qty 					-- returned prod qty
      ,par_same_prod_qty				-- "purchased after return" same prod qty
      ,par_distinct_prod_cnt 			-- how many different Products exist in the Purchase after the Return
		  ,ret_lines_cnt					-- how many lines for return exist in the return receipt (total, not per ProdVariant)
		  ,ret_distinct_prod_cnt 			-- how many different Products are returned 
		  ,ret_and_purch_distinct_prod_cnt	-- how many different Products exist both in the Return Receipt AND in the Purchase after the return receipt
		  ,ret_total_lines                -- how many lines for return exist in the return receipt together with deposit return lines
		  ,ret_prod_lines_gross_amount	-- return amount of a Product Variant calculated using only return lines
		  ,is_same_cashier_fg				-- same cashier(employee) on original purchase and the return receipt
		  ,is_quantity_suspicious_fg		-- *see below how column is calculated
      ,is_doppeltipper_fg				-- return is a correction of an accidental double scan in original receipt (Doppeltipper)
		  ,is_all_prod_lines_no_auth_fg	-- all lines for a product variant are not authorized when returned
)
AS
WITH
returned_products AS 
-- prefix RET_ stands for "Return" not "Retail"
(SELECT
		re.retail_event_sid           		AS ret_retail_event_sid
		,prl.local_prod_nr           		AS ret_local_prod_nr
		,ANY_VALUE(re.event_start_tmsp)			AS ret_event_start_tmsp
		,ANY_VALUE(re.bus_dt)                	AS ret_bus_dt
		,ANY_VALUE(re.country_org_cd)        	AS ret_country_org_cd
		,ANY_VALUE(re.store_sid)             	AS ret_store_sid
		,ANY_VALUE(re.cash_register_sid)     	AS ret_cash_register_sid
		,ANY_VALUE(re.cash_register_event_nr)	AS ret_cash_register_event_nr
		,ANY_VALUE(re.cashier_hash)          	AS ret_cashier_hash
		,ANY_VALUE(ce.cashier_nr)          		AS ret_cashier_nr
		,ANY_VALUE(re.txn_gross_val)         	AS ret_txn_gross_val
		,ANY_VALUE(re.txn_net_val)           	AS ret_txn_net_val
		,ANY_VALUE(re.curr_cd)               	AS ret_curr_cd
		,ANY_VALUE(re.auth_by_hash)           	AS ret_auth_by_hash_evt -- authorization on event level (can be different from the line level)
    ,SUM(COALESCE(prl.prod_variant_qty, prl.prod_variant_cnt))   AS ret_prod_qty -- returned Product Variant quantity
    ,SUM(SUM(COALESCE(prl.prod_variant_qty, prl.prod_variant_cnt))) OVER (PARTITION BY re.retail_event_sid)   AS RET_TOTAL_QTY -- returned total quantity
    ,COUNT(*)                               AS ret_prod_lines_cnt -- how many lines exist on the return receipt for this Product Variant
    ,SUM(COUNT(*)) OVER (PARTITION BY re.retail_event_sid) AS ret_lines_cnt   --how many lines exists in the whole receipt
		,SUM(CASE WHEN prl.auth_by_hash IS NULL THEN 0 ELSE 1 END) AS ret_prod_auth_lines_cnt	--how many lines for a product variant have been authorized in return receipt
		,SUM(prl.retail_line_gross_val) AS ret_prod_lines_gross_amount	-- return amount of a Product Variant calculated using only return lines
        ,SUM(CASE WHEN prl.prod_entry_method_cd = 'KE' THEN 1 ELSE 0 END) AS is_ke_input_fg
		,SUM(CASE WHEN prl.prod_entry_method_cd = 'DV' THEN 1 ELSE 0 END) AS is_dv_input_fg
		,SUM(CASE WHEN prl.prod_entry_method_cd = 'LS' THEN 1 ELSE 0 END) AS is_ls_input_fg
    ,ANY_VALUE(prl.orig_sales_event_sid)	    AS orig_retail_event_sid
    ,ANY_VALUE(orig_re.bus_dt) 				AS orig_bus_dt
		,ANY_VALUE(orig_re.country_org_cd) 			AS orig_country_org_cd
		,ANY_VALUE(orig_re.store_sid) 				AS orig_store_sid
		,ANY_VALUE(orig_re.cashier_hash)           	AS orig_cashier_hash
		,ANY_VALUE(orig_ce.cashier_nr)           	AS orig_cashier_nr
    ,ANY_VALUE(orig_re.event_start_tmsp)       	AS orig_event_start_tmsp
    ,ANY_VALUE(orig_re.cash_register_sid) 		AS orig_cash_register_sid
		,ANY_VALUE(orig_re.cash_register_event_nr)	AS orig_cash_register_event_nr
FROM ldl_data_production_${fwrk_work_db}.vt1
JOIN ldl_data_production_core_rel.t_retail_event re
		ON re.store_sid = vt1.loc_sid
       AND re.country_org_cd = vt1.country_cd
       AND re.bus_dt = vt1.dwh_cal_dt
JOIN ldl_data_production_core_rel.t_product_retail_line prl
		ON prl.retail_event_sid = re.retail_event_sid
       AND prl.store_sid = re.store_sid
       AND prl.country_org_cd = re.country_org_cd
       AND prl.bus_dt = re.bus_dt
JOIN ldl_data_production_core_app_fraud_detection.t_cashier_encryption ce
		ON ce.cashier_hash = re.cashier_hash
LEFT JOIN ldl_data_production_core_rel.t_retail_event orig_re
		ON orig_re.retail_event_sid = prl.orig_sales_event_sid
       AND orig_re.retail_event_type_cd = 'S'
LEFT JOIN ldl_data_production_core_app_fraud_detection.t_cashier_encryption orig_ce
		ON orig_ce.cashier_hash = orig_re.cashier_hash

WHERE 1=1
        AND re.retail_event_type_cd = 'R'
        AND re.turnover_relevant_fg = TRUE
		AND re.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt --Delta date logic

        AND prl.retail_event_line_scenario_id BETWEEN 140 AND 149	--Return receipt lines
        --AND prl.PROD_RETAIL_LINE_TYPE_CD in ('R', 'RD')	--Filter removed - not all lines with scenario ID between 140 and 149 are marked as retail line type 'R' or 'RD'. Change compliant with old system
		AND prl.bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt --Delta date logic

GROUP BY
		-- we might have several lines for returning same product (3 lines for returning Chips for example)
		-- we want to evaluate conditions based on LOCAL_PROD_NR, the quantity and amounts for them
		re.retail_event_sid
		,prl.local_prod_nr
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
(SELECT
    orig_retail_event_sid
FROM
    returned_products
WHERE 
    orig_retail_event_sid IS NOT NULL
GROUP BY 
    orig_retail_event_sid
HAVING 
    COUNT(DISTINCT ret_retail_event_sid) = 1
)

-----------------------------------------------------------------
-- Doppeltipper - calculate line rankings and product quantity
--
,doppeltipper_line_ranks AS
(SELECT
        orig.orig_retail_event_sid,
        tprl.local_prod_nr,
        tprl.prod_entry_method_cd,
        tprl.cancel_line_seq,
        COALESCE(tprl.prod_variant_cnt, 0)
          + COALESCE(tprl.prod_variant_qty, 0) AS prod_variant_qtyx,
        ROW_NUMBER() OVER (
            PARTITION BY orig.orig_retail_event_sid
            ORDER BY tprl.event_start_tmsp, tprl.retail_event_line_seq
        ) AS line_rn
FROM original_receipts orig
JOIN ldl_data_production_core_rel.t_product_retail_line tprl
    ON orig.orig_retail_event_sid = tprl.retail_event_sid
)
-----------------------------------------------------------------
-- Doppeltipper - detect scanned product changes in original receipts
--
,doppeltipper_changes AS
(SELECT
        *
        --Doppeltipper: mark row if this and the previous row were scanned
        , CASE
            WHEN (LAG(prod_entry_method_cd) OVER (PARTITION BY orig_retail_event_sid ORDER BY line_rn)
                  IS NOT DISTINCT FROM prod_entry_method_cd)
                 AND prod_entry_method_cd = 'SC'
            THEN 1
            ELSE 0
          END AS curr_and_prev_scanned_fg
        --Doppeltipper: mark row as not changed only when the item and quantity are the same as in a previous row and when this is the consecutive scan
        , CASE
            WHEN curr_and_prev_scanned_fg = 1
                 AND (LAG(local_prod_nr) OVER (PARTITION BY orig_retail_event_sid ORDER BY line_rn)
                      IS NOT DISTINCT FROM local_prod_nr)
                 AND (LAG(prod_variant_qtyx) OVER (PARTITION BY orig_retail_event_sid ORDER BY line_rn)
                      IS NOT DISTINCT FROM prod_variant_qtyx)
            THEN 0
            ELSE 1
          END AS change_fg
FROM doppeltipper_line_ranks
)
-----------------------------------------------------------------
-- Doppeltipper - calculate group IDs as series of scanned products
--
,event_lines_groups AS
(SELECT
        *,
        SUM(change_fg) OVER (
            PARTITION BY orig_retail_event_sid
            ORDER BY line_rn
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS group_id
FROM doppeltipper_changes
)
-----------------------------------------------------------------
-- Doppeltipper - keep only these products for original receipts that were scanned as a series of 2 scans or more
-- and were not corrected by cancellation (storno). If doppletipper is corrected by "storno" then there is no "excuse" for the Return Event, and it would be suspicious
--
,potential_doppeltippers AS
(SELECT
        orig_retail_event_sid,
        local_prod_nr,
        prod_variant_qtyx,
        group_id
FROM event_lines_groups
GROUP BY
        orig_retail_event_sid,
        local_prod_nr,
        prod_variant_qtyx,
        group_id
HAVING
        COUNT(*) > 1
    AND COUNT(cancel_line_seq) = 0
QUALIFY
    -- sometimes there are two or more series of same products being scanned consecutively - this filter is to qualify just one series out of them
    -- regardless the number of same product series in original receipt, Doppeltipper qualification assumes only one line for a product returned, previously being scanned in any but just one of the series in original receipt
    group_id = MAX(group_id) OVER (
        PARTITION BY orig_retail_event_sid, local_prod_nr, prod_variant_qtyx)
)
-----------------------------------------------------------------
-- the purchase that happened after the return
--
,purch_day_and_register_of_return as 
(SELECT
        re.retail_event_sid,
        re.cash_register_event_nr,
        re.bus_dt,
        re.cash_register_sid,
        re.txn_gross_val,
        ce.cashier_nr
FROM ldl_data_production_core_rel.t_retail_event re
JOIN ldl_data_production_core_app_fraud_detection.t_cashier_encryption ce
    ON ce.cashier_hash = re.cashier_hash
WHERE 1 = 1
  AND re.retail_event_type_cd = 'S'
  AND re.turnover_relevant_fg = TRUE
  AND EXISTS (
        SELECT 1
        FROM returned_products rp
        WHERE rp.ret_bus_dt = re.bus_dt
          AND rp.ret_cash_register_sid = re.cash_register_sid
          AND rp.ret_country_org_cd = re.country_org_cd
    )
)
,purch_event_after_return AS 
-- "PAR" = Purchase After Return
(SELECT
        rp.ret_retail_event_sid,
        par.retail_event_sid      AS par_retail_event_sid -- could get a NULL but rows like this will be eliminated in the joins
        ,par.txn_gross_val        AS par_txn_gross_val
FROM returned_products rp
LEFT JOIN purch_day_and_register_of_return par
        -- next receipt from the same Cashier, in the same Store, same Day
        ON rp.ret_bus_dt = par.bus_dt
       AND rp.ret_cashier_nr = par.cashier_nr
       AND rp.ret_cash_register_sid = par.cash_register_sid
       AND rp.ret_cash_register_event_nr < par.cash_register_event_nr
QUALIFY ROW_NUMBER() OVER (
            PARTITION BY rp.ret_retail_event_sid
            ORDER BY par.cash_register_event_nr ASC
        ) = 1
)
-----------------------------------------------------------------
-- extract distinctive retail_event_sid values for returns
-- returned_products CTE can have more than one row per retail_event_sid due to the returns having more than one product returned
,return_receipts AS
(SELECT DISTINCT ret_retail_event_sid
FROM returned_products
)
-----------------------------------------------------------------
-- calculating lines gross value (Bonsumme) for next receipt's cash payment comparison as per "cash amount that is given for the next receipt is diferent that total amount of return receipt" requirement
-- business testing of this requirement in old ZKP revealed that such line calculation is more precise than just taking total receipt gross value (txn_gross_val in GF) from the header information
-- also calculating total number of lines together with returned deposits - not possible in returned_products CTE as deposit return lines are filtered out in that CTE
-- such total number was used for filtering in old system
,calc_bonsumme AS 
(SELECT
    rr.ret_retail_event_sid,
    SUM(ABS(tprl.retail_line_gross_val)) AS ret_bonsumme,
    COUNT(*) AS ret_total_lines
FROM return_receipts rr
JOIN ldl_data_production_core_rel.t_product_retail_line tprl
    ON rr.ret_retail_event_sid = tprl.retail_event_sid
WHERE
    tprl.retail_event_line_scenario_id BETWEEN 140 AND 149  --For the Bonsumme purposes: only return lines...
    OR tprl.retail_event_line_scenario_id = 120             --...and deposit return lines
GROUP BY
    rr.ret_retail_event_sid
)
-----------------------------------------------------------------
-- first cash payment within a returned receipt - kept as a separate CTE to avoid the risk of mutually exclusive QUALIFY statements within other CTEs
-- for the comparison with return's Bonsumme value as per "cash amount that is given for the next receipt is diferent that total amount of return receipt" requirement
,purch_event_after_return_cash_payment AS 
(SELECT
        par.ret_retail_event_sid,
        par.par_retail_event_sid,
        tpl.local_paym_val
FROM purch_event_after_return par
JOIN ldl_data_production_core_rel.t_payment_line tpl
        ON par.par_retail_event_sid = tpl.retail_event_sid
       AND tpl.paym_type_id = 11        --payments in cash only
       AND tpl.paym_line_type_cd = 'P'  --customer payments only

--take only the first cash payment (FOR EACH RETURN*) information based on the payment event line sequence
-- if two or more returns are made one after another, then the "Next Purchase Event" for all of them will be the same, and have same PAR_RETAIL_EVENT_SID
QUALIFY ROW_NUMBER() OVER (
            PARTITION BY par.ret_retail_event_sid, par.par_retail_event_sid
            ORDER BY tpl.retail_event_line_seq ASC
        ) = 1
)
,purch_products_after_return_event AS
-- PAR_P = PAR P = Purchase After Return - Products
(SELECT 
        par.ret_retail_event_sid,
        par.par_retail_event_sid,
        prl.local_prod_nr                 AS par_local_prod_nr,
        any_value(par.par_txn_gross_val)     AS par_txn_gross_val,
        SUM(COALESCE(prl.prod_variant_qty, prl.prod_variant_cnt))     AS par_prod_qty,
        SUM(
            SUM(COALESCE(prl.prod_variant_qty, prl.prod_variant_cnt))
        ) OVER (
            PARTITION BY par.ret_retail_event_sid, par.par_retail_event_sid
        ) AS par_total_qty,
        -- how many distinct products exist in the "Purchase After the Return" - used in some scenarios
        COUNT(DISTINCT prl.local_prod_nr) OVER (
            PARTITION BY par.ret_retail_event_sid, par.par_retail_event_sid
        )  AS par_distinct_prod_cnt

FROM purch_event_after_return par
JOIN ldl_data_production_core_rel.t_product_retail_line prl
    ON prl.retail_event_sid = par.par_retail_event_sid
WHERE 1 = 1
    -- Lines of purchases that happen on the same day AS the return
    AND prl.bus_dt BETWEEN $MIN_DWH_CAL_DT AND $MAX_DWH_CAL_DT 
GROUP BY 
        par.ret_retail_event_sid,
        par.par_retail_event_sid,
        prl.local_prod_nr
)
-----------------------------------------------------------------
-- purchase that happened after the original purchase, could be empty dataset if no original receipt exists
--
,purch_day_and_register_of_orig as 
(SELECT
    re.retail_event_sid,
    re.cash_register_event_nr,
    re.bus_dt,
    re.cash_register_sid,
    re.txn_gross_val,
    ce.cashier_nr
FROM ldl_data_production_core_rel.t_retail_event re
JOIN ldl_data_production_core_app_fraud_detection.t_cashier_encryption ce
    ON ce.cashier_hash = re.cashier_hash
WHERE 1 = 1
  AND re.retail_event_type_cd = 'S'
  AND re.turnover_relevant_fg = TRUE
  AND EXISTS (
        SELECT 1
        FROM returned_products rp
        WHERE rp.orig_bus_dt = re.bus_dt
          AND rp.orig_cash_register_sid = re.cash_register_sid
          AND rp.ret_country_org_cd = re.country_org_cd)
,purch_event_after_orig_purch AS
-- PAOP - Purchase After the Original Purchase
(SELECT 
        rp.ret_retail_event_sid,
        rp.orig_retail_event_sid,
        paop.retail_event_sid          AS paop_retail_event_sid,
        paop.txn_gross_val
FROM returned_products rp
LEFT JOIN purch_day_and_register_of_orig paop
        -- next receipt after the original purchase
        -- from the same Cashier, in the same Store, same Day
        ON rp.orig_bus_dt = paop.bus_dt 
       AND rp.orig_cashier_nr = paop.cashier_nr
       AND rp.orig_cash_register_sid = paop.cash_register_sid
       AND rp.orig_cash_register_event_nr < paop.cash_register_event_nr
QUALIFY ROW_NUMBER() OVER (
            PARTITION BY rp.orig_retail_event_sid, rp.ret_retail_event_sid
            ORDER BY paop.cash_register_event_nr ASC) = 1
)
-----------------------------------------------------------------
, common_scenarios AS 
(SELECT  
        rp.ret_retail_event_sid,
        rp.ret_local_prod_nr,
        rp.ret_cash_register_event_nr,
        rp.ret_event_start_tmsp,
        rp.ret_bus_dt,
        rp.ret_cash_register_sid,
        rp.ret_store_sid,
        rp.ret_country_org_cd,
        rp.ret_cashier_hash,
        rp.ret_cashier_nr,
        rp.ret_txn_net_val,
        rp.ret_txn_gross_val,
        rp.ret_curr_cd,
        rp.ret_auth_by_hash_evt,
        rp.orig_bus_dt,
        rp.orig_cashier_hash,
        rp.orig_cashier_nr,
        rp.orig_retail_event_sid,
        rp.orig_store_sid,
        rp.ret_prod_auth_lines_cnt,
        rp.ret_prod_lines_gross_amount,
        rp.is_ke_input_fg,
        rp.is_dv_input_fg,
        rp.is_ls_input_fg,
        rp.ret_prod_qty,
        ABS(rp.ret_prod_qty) AS abs_ret_prod_qty,   -- absolute returned prod qty (calculation usage only)
        rp.ret_total_qty,
        ABS(rp.ret_total_qty) AS abs_ret_total_qty,	-- absolute returned total qty (calculation usage only)
        CASE 
            WHEN rp.ret_local_prod_nr = par_p.par_local_prod_nr 
            THEN par_p.par_prod_qty 
            ELSE 0
        END AS par_same_prod_qty,	--return the quantity of a product from receipt's follower (PAR_P) if the product is also in the return receipt, otherwise leave it as 0

        COALESCE(par_p.par_total_qty, 0) AS par_total_qty,
        cb.ret_total_lines,
        -- how many different Products exist in the Purchase after the Return
        -- this is already calculated on Retail Event level in "PAR_P"
        COALESCE(par_p.par_distinct_prod_cnt, 0) AS par_distinct_prod_cnt,
        -- how many lines for return exist in the return receipt (total, not per ProdVariant)
        -- this is already calculated in returned_products CTE
        rp.ret_lines_cnt,
        -- how many different Products are returned
        COUNT(DISTINCT rp.ret_local_prod_nr) OVER (PARTITION BY rp.ret_retail_event_sid) AS ret_distinct_prod_cnt,
        -- how many different Products exist in the Return Receipt AND in the Purchase after the return receipt
        -- this logic replaced former one with additional join condition on products to purch_products_after_return_event CTE
        SUM(
            CASE
                WHEN rp.ret_local_prod_nr = par_p.par_local_prod_nr THEN 1
                ELSE 0
            END
        ) OVER (PARTITION BY rp.ret_retail_event_sid) AS ret_and_purch_distinct_prod_cnt,
        -- this value is on Event-level - it is the same for all rows of the same Event, so MAX is ok
        -- but in case we get nothing from the left join this will be null.
        MAX(par_p.par_txn_gross_val) OVER (PARTITION BY rp.ret_retail_event_sid) AS par_txn_gross_val_1
FROM returned_products rp
    -- return - Bonsumme
    JOIN calc_bonsumme cb
        ON rp.ret_retail_event_sid = cb.ret_retail_event_sid
    -- purchase after return - cash payments
    LEFT JOIN purch_event_after_return_cash_payment par_cp
        ON rp.ret_retail_event_sid = par_cp.ret_retail_event_sid
    -- purchase after original purchase
    LEFT JOIN purch_event_after_orig_purch paop
        ON rp.ret_retail_event_sid = paop.ret_retail_event_sid
    -- purchase after return - Products
    LEFT JOIN purch_products_after_return_event par_p
        ON rp.ret_retail_event_sid = par_p.ret_retail_event_sid
        -- Condition removed based on original logic comments
WHERE
    -- SCENARIO_CONDITION: "value of the cash refund (receipt total) is not the same as 
    --  the receipt total of the subsequent receipt according to the corresponding original receipt"
    -- we are also including the situation when there is no original receipt or there is original receipt but not following
    (paop.paop_retail_event_sid IS NULL
     OR ABS(rp.ret_txn_gross_val) <> paop.txn_gross_val)
    -- SCENARIO_CONDITION: "cash amount that is given for the next receipt is different than total amount of return receipt"
    -- Putting local_paym_val in COALESCE function in case there is no purchase after return (i.e., last receipt of the day)
    -- Such case is also treated as suspicious as there is no chance to exclude this return by the following purchase with the same cash payment as Bonsumme
    AND cb.ret_bonsumme <> COALESCE(par_cp.local_paym_val, -1)
QUALIFY
    1 = 1
    -- SCENARIO_CONDITION: "ALL items in the Return are NOT in the following Purchase after the Return (some could be)"
    -- if all returned products are purchased next, left join will not return NULLs for par_p.par_local_prod_nr.
    -- then the two counts will be equal, which is fine - no suspicion for a fraud
    AND ret_distinct_prod_cnt <> ret_and_purch_distinct_prod_cnt
    -- SCENARIO_CONDITION: The value of the cash refund (receipt total) is not the same as the receipt total of the subsequent receipt
    -- we must use LEFT join because of the condition above.
    -- so this condition must be evaluated in the QUALIFY part. Cannot be evaluated in the JOIN or in WHERE
    AND (
        par_txn_gross_val_1 IS NULL
        OR par_txn_gross_val_1 <> ABS(rp.ret_txn_gross_val)
    )
    -- Filter to remove unnecessary duplicated records from this CTE and keep only one row per each receipt/product combination from returned_products CTE
    -- Ordering by par_same_prod_qty descending and keeping nulls last during sorting just in case (par_same_prod_qty has COALESCE function)
    -- If there is 0 in par_same_prod_qty, regardless it's due to the lack of purchase after return or lack of matching products in purchase after return, then this row should be last for qualifying - preference is for matching products
    AND ROW_NUMBER() OVER (
            PARTITION BY rp.ret_retail_event_sid, rp.ret_local_prod_nr
            ORDER BY par_same_prod_qty DESC NULLS LAST
        ) = 1
)
SELECT 
    cs.ret_retail_event_sid,
    cs.ret_local_prod_nr,
    cs.ret_cash_register_event_nr,
    cs.ret_event_start_tmsp,
    cs.ret_bus_dt,
    cs.ret_cash_register_sid,
    cs.ret_store_sid,
    cs.ret_country_org_cd,
    cs.ret_cashier_hash,
    cs.ret_txn_net_val,
    cs.ret_txn_gross_val,
    cs.ret_curr_cd,
    cs.ret_auth_by_hash_evt,
    cs.orig_bus_dt,
    cs.orig_cashier_hash,
    cs.orig_retail_event_sid,
    cs.is_ke_input_fg,
    cs.is_dv_input_fg,
    cs.is_ls_input_fg,				   
    cs.ret_prod_qty,					-- returned prod qty
    cs.par_same_prod_qty,				-- "purchased after return" same prod qty
    cs.par_distinct_prod_cnt, 			-- how many different Prods exist in the Purchase after the Return
    cs.ret_lines_cnt,					-- how many lines for return exist in the return receipt (total, not per ProdVariant)
    cs.ret_distinct_prod_cnt, 			-- how many different Prods are returned
    cs.ret_and_purch_distinct_prod_cnt,	-- how many different Prods exist both in the Return Receipt AND in the Purchase after the return receipt
    cs.ret_total_lines,                 -- how many lines for return exist in the return receipt together with deposit return lines
    cs.ret_prod_lines_gross_amount,		-- return amount of a Product Variant calculated using only return lines
    IF(
        cs.ret_cashier_nr = cs.orig_cashier_nr
        AND cs.ret_store_sid = cs.orig_store_sid,
        1,
        0
    ) AS is_same_cashier_fg,		-- same cashier(employee) on original purchase and the return receipt
    -- Aditional Condition used in several scenarios
    -- (English translation): "and if the follow-up receipt (after Return) contains only 1 product, 
    --     it is not permitted to have the same number of sold pieces like on the Return receipt (unless the number is 1.0)" 
    -- (Original in German): wenn der Folgebon nach der Geldrückgabe nur 1 Artikel enthält, darf dieser nicht in der gleichen
    --     Anzahl verkauft werden, wie der Artikel auf der Geldrückgabe (außer die Anzahl ist 1,0)
    CASE
        -- if next receipt has more that 1 Prod it is suspicious
        WHEN cs.par_distinct_prod_cnt > 1 THEN 1

        -- if return has more than 1 line - suspicious
        WHEN cs.ret_lines_cnt > 1 THEN 1

        -- if next receipt has 1 Prod, but the quantity of this Prod is different than the total quantity in the Return - suspicious
        WHEN cs.par_total_qty <> cs.abs_ret_total_qty THEN 1

        -- if next receipt has 1 PV, quantities are the same, but they are 1 in both receipts - suspicious
        WHEN cs.par_total_qty = 1 AND cs.abs_ret_total_qty = 1 THEN 1

        -- everything else is fine
        ELSE 0
    END AS is_quantity_suspicious_fg,

    -- Doppeltipper:
    -- If any of the products within a return cannot be considered as a Doppeltipper then the whole receipt cannot be qualified as a Doppeltipper
    -- This is slightly different than the Doppeltipper logic in storno scenarios but this is intentional and discussed with business
    MIN(
        CASE WHEN pd.orig_retail_event_sid IS NULL THEN 0 ELSE 1 END
    ) OVER (PARTITION BY cs.ret_retail_event_sid) AS is_doppeltipper_fg,

    -- If all lines were returned without authorization then set flag to 1, otherwise set to 0
    CASE WHEN cs.ret_prod_auth_lines_cnt = 0 THEN 1 ELSE 0 END AS is_all_prod_lines_no_auth_fg

FROM common_scenarios cs
LEFT JOIN potential_doppeltippers pd
    ON pd.orig_retail_event_sid = cs.orig_retail_event_sid  -- Doppeltipper: same original receipt
    AND pd.local_prod_nr = cs.ret_local_prod_nr             -- Doppeltipper: same product in both return and original receipt
    AND pd.prod_variant_qtyx = cs.abs_ret_prod_qty          -- Doppeltipper: same product quantity in both return and original receipt
    AND cs.ret_lines_cnt = cs.ret_distinct_prod_cnt         -- Doppeltipper: total number of lines in return same as the total number of distinctive products - guarantees one line per product
	;
-----------------------------------------------------------------------------------------







-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Step 2.1 
-- "Same Cashier Return" - main scenario and sub-scenarios
INSERT INTO ldl_data_production_${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final
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

    ,return_same_cashier_fg
    ,return_same_cashier_diff_day_fg
    ,return_same_cashier_and_day_fg
    ,return_same_cashier_and_day_without_auth_fg
    ,return_same_cashier_and_day_manual_fg
    ,return_same_cashier_and_day_display_sel_fg
    ,return_same_cashier_and_day_cash_paym_fg
    ,return_same_cashier_and_day_card_paym_fg                                    
)
WITH 
mat_params AS
(
    SELECT *
    FROM ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value
    WHERE scenario_id = 12 --  (US: 33395) Geldrückgabe - Originalbon gleicher Tag, gleicher Bediene - name should be fixed to be the name of "main scenario"
)
,eval_flags AS
(
    SELECT 
        src.*
        ,SUM(ABS(src.ret_prod_lines_gross_amount)) OVER(PARTITION BY src.ret_retail_event_sid) AS ret_total_lines_gross_amount

        --subscenario: same cashier, different day
        ,CASE
             WHEN src.ret_bus_dt <> src.orig_bus_dt THEN 1
             ELSE 0 
         END AS line_return_same_cashier_diff_day_fg

        --subscenario: same cashier, same day
        ,CASE
             WHEN src.ret_bus_dt = src.orig_bus_dt THEN 1
             ELSE 0 
         END AS line_return_same_cashier_and_day_fg

        --subscenario: same cashier, same day, total value under authorization limit
        ,CASE
             WHEN src.ret_bus_dt = src.orig_bus_dt 
                  AND ret_total_lines_gross_amount BETWEEN s12_rvnal.param_val_qty AND s12_rvnau.param_val_qty THEN 1
             ELSE 0 
         END AS line_return_same_cashier_and_day_without_auth_fg

        --subscenario: same cashier, same day, manual input without DV
        ,CASE
             WHEN src.ret_bus_dt = src.orig_bus_dt 
                  AND src.is_ke_input_fg THEN 1
             ELSE 0 
         END AS line_return_same_cashier_and_day_manual_fg

        --subscenario: same cashier, same day with display selection
        ,CASE
             WHEN src.ret_bus_dt = src.orig_bus_dt 
                  AND src.is_ls_input_fg THEN 1
             ELSE 0 
         END AS line_return_same_cashier_and_day_display_sel_fg

    FROM t_fraud_detection_returns_common src -- granularity: 1 row per ProdVariant in ReturnReceipt (RET_RETAIL_EVENT_SID, RET_PROD_VARIANT_SID)
        
        JOIN mat_params s12_rv    -- Scenario 12, parameter "Refund Value (lower bound)"
            ON s12_rv.country_org_cd = src.ret_country_org_cd
           AND s12_rv.scenario_id = 12
           AND s12_rv.param_id = 35
           AND s12_rv.is_scenario_enabled_in_country_fg = TRUE
            
        JOIN mat_params s12_rvnal    -- Scenario 12, parameter "Refund Value not requiring authorization (lower bound)"
            ON s12_rvnal.country_org_cd = src.ret_country_org_cd
           AND s12_rvnal.scenario_id = 12
           AND s12_rvnal.param_id = 36
           AND s12_rvnal.is_scenario_enabled_in_country_fg = TRUE
        
        JOIN mat_params s12_rvnau    -- Scenario 12, parameter "Refund Value not requiring authorization (upper bound)"
            ON s12_rvnau.country_org_cd = src.ret_country_org_cd
           AND s12_rvnau.scenario_id = 12
           AND s12_rvnau.param_id = 37
           AND s12_rvnau.is_scenario_enabled_in_country_fg = TRUE
    
    WHERE 
        src.is_quantity_suspicious_fg = 1
        AND src.is_same_cashier_fg = 1
        AND ABS(src.ret_txn_gross_val) >= s12_rv.param_val_qty
        AND src.is_doppeltipper_fg = 0
)
,payment_types AS
(
    SELECT
        retail_event_sid
        ,SUM(CASE WHEN paym_type_id = 11 THEN 1 ELSE 0 END) AS cash_paym_lines
        ,SUM(CASE WHEN paym_type_id = 12 THEN 1 ELSE 0 END) AS card_paym_lines
    FROM ldl_data_production_core_rel.t_payment_line
    WHERE                            --not filtering on PAYM_TYPE_ID IN (11, 12) - there are other cash refund methods in use apart from cash and card, when they are picked both PAYM_LINES fields will have 0 for such receipts
        paym_line_type_cd = 'R'     --only the amount returned from cashier to customer
        AND bus_dt BETWEEN $min_dwh_cal_dt AND $max_dwh_cal_dt --Delta date logic
    GROUP BY
        retail_event_sid
)
SELECT 
    ef.ret_retail_event_sid                    AS cash_register_event_sid
    ,ANY_VALUE(ef.ret_cash_register_event_nr)   AS cash_register_event_nr
    ,ANY_VALUE(ef.ret_event_start_tmsp)         AS event_start_tmsp
    ,ANY_VALUE(ef.ret_bus_dt)                   AS bus_dt
    ,ANY_VALUE(ef.ret_cash_register_sid)        AS cash_register_sid
    ,ANY_VALUE(cr.cash_register_nr)             AS cash_register_nr
    ,ANY_VALUE(ef.ret_store_sid)                AS store_sid
    ,ANY_VALUE(ef.ret_cashier_hash)             AS cashier_hash
    ,ANY_VALUE(ef.ret_txn_net_val)              AS txn_net_val
    ,ANY_VALUE(ef.ret_txn_gross_val)            AS txn_gross_val
    ,ANY_VALUE(ef.ret_curr_cd)                  AS curr_cd
    ,ANY_VALUE(ef.is_same_cashier_fg)           AS return_same_cashier_fg
    ,IF(SUM(line_return_same_cashier_diff_day_fg) > 0, 1, 0)                  AS return_same_cashier_diff_day_fg
    ,IF(SUM(line_return_same_cashier_and_day_fg) > 0, 1, 0)                  AS return_same_cashier_and_day_fg
    ,IF(SUM(line_return_same_cashier_and_day_without_auth_fg) > 0, 1, 0)     AS return_same_cashier_and_day_without_auth_fg
    ,IF(SUM(line_return_same_cashier_and_day_manual_fg) > 0, 1, 0)           AS return_same_cashier_and_day_manual_fg
    ,IF(SUM(line_return_same_cashier_and_day_display_sel_fg) > 0, 1, 0)     AS return_same_cashier_and_day_display_sel_fg
    --subscenario: same cashier, same day, refund made in cash
    ,CASE
         WHEN return_same_cashier_and_day_fg = 1
             AND ANY_VALUE(pt.cash_paym_lines) > 0 THEN 1
         ELSE 0
     END                                                                  AS return_same_cashier_and_day_cash_paym_fg
    --subscenario: same cashier, same day, refund made on card
    ,CASE
         WHEN return_same_cashier_and_day_fg = 1
             AND ANY_VALUE(pt.card_paym_lines) > 0 THEN 1
         ELSE 0
     END                                                                  AS return_same_cashier_and_day_card_paym_fg
FROM eval_flags ef
JOIN ldl_data_production_core_rel.t_cash_register cr
    ON ef.ret_cash_register_sid = cr.cash_register_sid
   AND cr.dwh_valid_fg = TRUE
JOIN payment_types pt
    ON ef.ret_retail_event_sid = pt.retail_event_sid
GROUP BY 
    ret_retail_event_sid;
-----------------------------------------------------------------------------------------






-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Step 2.2
-- "Multiple products Return" - main scenario and sub-scenarios
INSERT INTO ldl_data_production_${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final
(
    cash_register_event_sid,
    cash_register_event_nr,
    event_start_tmsp,
    bus_dt,
    cash_register_sid,
    cash_register_nr,
    store_sid,
    cashier_hash,
    txn_net_val,
    txn_gross_val,
    curr_cd,
    return_mult_prod_fg,
    return_mult_prod_full_qty_fg,
    return_mult_prod_same_cashier_fg
)
WITH 
mat_params AS
(
    SELECT *
    FROM ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value
    WHERE scenario_id = 14 --  (US: 33408) Geldrückgabe mehrerer Artikel eines Originalbons 
)
,orig_purch_prod_variants AS
(
    SELECT 
        prl.retail_event_sid AS orig_retail_event_sid,
        prl.local_prod_nr   AS orig_local_prod_nr,
        SUM(COALESCE(prl.prod_variant_qty, prl.prod_variant_cnt)) AS orig_prod_qty,
        
        -- how many different Prods are purchased with the original receipt
        COUNT(DISTINCT prl.local_prod_nr) OVER (PARTITION BY prl.retail_event_sid) AS orig_diff_prod_cnt
    FROM ldl_data_production_core_rel.t_product_retail_line prl
    WHERE 1 = 1
        AND prl.prod_retail_line_type_cd IN ('S', 'SD')
        AND prl.turnover_relevant_fg = TRUE
        AND EXISTS
        (
            SELECT 1
            FROM t_fraud_detection_returns_common src
            WHERE src.orig_retail_event_sid = prl.retail_event_sid
              AND src.orig_bus_dt = prl.bus_dt
              AND src.ret_country_org_cd = prl.country_org_cd
        )
    GROUP BY 
        prl.retail_event_sid,
        prl.local_prod_nr
)
,main_scenario AS
(
    SELECT 
        ret_p.*,
            
        -- flag RETURN_MULT_PROD_FG - Main Scenario  
        1 AS line_return_mult_prod_fg
    FROM t_fraud_detection_returns_common ret_p
        JOIN mat_params s14_rv    -- Scenario 14, parameter "Refund Value (lower bound)"
            ON s14_rv.country_org_cd = ret_p.ret_country_org_cd
           AND s14_rv.scenario_id = 14
           AND s14_rv.param_id = 41
           AND s14_rv.is_scenario_enabled_in_country_fg = TRUE
        JOIN mat_params s14_lc    -- Scenario 14, parameter "Lines Count" - number of lines for returns
            ON s14_lc.country_org_cd = ret_p.ret_country_org_cd
           AND s14_lc.scenario_id = 14
           AND s14_lc.param_id = 40
           AND s14_lc.is_scenario_enabled_in_country_fg = TRUE
    WHERE 1 = 1
        -- conditions for main scenario "Return Multiple Products"
        -- they are valid for all sub-scenarios of this scenario
        -- "RET_TOTAL_LINES" and "RET_TXN_GROSS_VAL" are total values for the whole return event. (not value per ProdVariant)
        AND ret_p.ret_total_lines >= s14_lc.param_val_qty
        AND ABS(ret_p.ret_txn_gross_val) >= s14_rv.param_val_qty
        -- IS_QUANTITY_SUSPICIOUS_FG filter applied on the request of Lucas
        AND ret_p.is_quantity_suspicious_fg = 1
        -- check if original receipt exists by verifying if the bus_dt is null or not
        -- sometimes cashiers enter dummy value into orig_sales_event_sid even when the original receipt is not available
        AND ret_p.orig_bus_dt IS NOT NULL
)
,sub_scenarios AS 
(
    SELECT 
        ret_p.*,
        
        IF(ABS(ret_p.ret_prod_qty) = pur_p.orig_prod_qty, 1, 0) AS is_prod_fully_returned_fg,
            
        -- how many of the purchased product variants are fully returned (all quantities are returned) in a single return event. 
        SUM(IF(ABS(ret_p.ret_prod_qty) = pur_p.orig_prod_qty, 1, 0)) OVER (
            PARTITION BY pur_p.orig_retail_event_sid, ret_p.ret_retail_event_sid
        ) AS fully_returned_prod_cnt,
                
        IF(pur_p.orig_diff_prod_cnt = 
            SUM(IF(ABS(ret_p.ret_prod_qty) = pur_p.orig_prod_qty, 1, 0)) OVER (
                PARTITION BY pur_p.orig_retail_event_sid, ret_p.ret_retail_event_sid
            ), 1, 0) AS return_mult_prod_full_qty_fg
    FROM main_scenario ret_p
    FULL OUTER JOIN orig_purch_prod_variants pur_p
        ON pur_p.orig_retail_event_sid = ret_p.orig_retail_event_sid
       AND pur_p.orig_local_prod_nr = ret_p.ret_local_prod_nr
)
SELECT 
    ef.ret_retail_event_sid                   AS cash_register_event_sid,
    ANY_VALUE(ef.ret_cash_register_event_nr)   AS cash_register_event_nr,
    ANY_VALUE(ef.ret_event_start_tmsp)         AS event_start_tmsp,
    ANY_VALUE(ef.ret_bus_dt)                   AS bus_dt,
    ANY_VALUE(ef.ret_cash_register_sid)        AS cash_register_sid,
    ANY_VALUE(cr.cash_register_nr)             AS cash_register_nr,
    ANY_VALUE(ef.ret_store_sid)                AS store_sid,
    ANY_VALUE(ef.ret_cashier_hash)             AS cashier_hash,
    ANY_VALUE(ef.ret_txn_net_val)              AS txn_net_val,
    ANY_VALUE(ef.ret_txn_gross_val)            AS txn_gross_val,
    ANY_VALUE(ef.ret_curr_cd)                  AS curr_cd,
    IF(SUM(line_return_mult_prod_fg) > 0, 1, 0)                   AS return_mult_prod_fg,             -- main scenario
    IF(SUM(return_mult_prod_full_qty_fg) > 0, 1, 0)               AS return_mult_prod_full_qty_fg,    -- sub-scenario
    IF(SUM(ef.is_same_cashier_fg) > 0, 1, 0)                      AS return_mult_prod_same_cashier_fg -- sub-scenario
FROM sub_scenarios ef
JOIN ldl_data_production_core_rel.t_cash_register cr
    ON ef.ret_cash_register_sid = cr.cash_register_sid
   AND cr.dwh_valid_fg = TRUE
GROUP BY 
    ret_retail_event_sid
HAVING return_mult_prod_fg = 1;
-----------------------------------------------------------------------------------------





-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Step 2.3 
-- "Return without authorization" and "Return without original receipt"
INSERT INTO ldl_data_production_${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final
(
    cash_register_event_sid,
    cash_register_event_nr,
    event_start_tmsp,
    bus_dt,
    cash_register_sid,
    cash_register_nr,
    store_sid,
    cashier_hash,
    txn_net_val,
    txn_gross_val,
    curr_cd,
    return_without_auth_fg
)
WITH 
mat_params AS
(
    SELECT *
    FROM ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value
    WHERE scenario_id = 7       --  (US: 33396) Geldrückgabe nicht autorisierungspflichtig 
)
,eval_flags AS
(
    SELECT
        src.*,

        CASE
            WHEN 
                ABS(src.ret_txn_gross_val) >= s7_rv_min.param_val_qty 
                AND src.is_doppeltipper_fg = 0
                AND src.is_all_prod_lines_no_auth_fg = 1
                AND src.ret_auth_by_hash_evt IS NULL THEN 1 
            ELSE 0 
        END AS line_return_without_auth_fg 
    
    FROM t_fraud_detection_returns_common src -- granularity: 1 row per Prod in ReturnReceipt (RET_RETAIL_EVENT_SID, RET_LOCAL_PROD_NR)
    
    JOIN mat_params s7_rv_min    -- Scenario 7, parameter "Refund Value (lower bound)"
        ON s7_rv_min.country_org_cd = src.ret_country_org_cd
       AND s7_rv_min.scenario_id = 7
       AND s7_rv_min.param_id = 21
       AND s7_rv_min.is_scenario_enabled_in_country_fg = TRUE

    WHERE 1 = 1
      AND src.is_quantity_suspicious_fg = 1
)
SELECT 
    ef.ret_retail_event_sid                     AS cash_register_event_sid,
    ANY_VALUE(ef.ret_cash_register_event_nr)     AS cash_register_event_nr,
    ANY_VALUE(ef.ret_event_start_tmsp)           AS event_start_tmsp,
    ANY_VALUE(ef.ret_bus_dt)                     AS bus_dt,
    ANY_VALUE(ef.ret_cash_register_sid)          AS cash_register_sid,
    ANY_VALUE(cr.cash_register_nr)               AS cash_register_nr,
    ANY_VALUE(ef.ret_store_sid)                  AS store_sid,
    ANY_VALUE(ef.ret_cashier_hash)               AS cashier_hash,
    ANY_VALUE(ef.ret_txn_net_val)                AS txn_net_val,
    ANY_VALUE(ef.ret_txn_gross_val)              AS txn_gross_val,
    ANY_VALUE(ef.ret_curr_cd)                    AS curr_cd,

    IF(
        SUM(line_return_without_auth_fg) = ANY_VALUE(ef.ret_distinct_prod_cnt),
        1,
        0
    ) AS return_without_auth_fg -- all the lines for all products have no authorisation, mark the receipt

FROM eval_flags ef
JOIN ldl_data_production_core_rel.t_cash_register cr
    ON ef.ret_cash_register_sid = cr.cash_register_sid
   AND cr.dwh_valid_fg = TRUE
GROUP BY 
    ret_retail_event_sid
HAVING return_without_auth_fg = 1
;




-----------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------
-- Step 2.4
-- "Return without original receipt"
INSERT INTO ldl_data_production_${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final
(
    cash_register_event_sid,
    cash_register_event_nr,
    event_start_tmsp,
    bus_dt,
    cash_register_sid,
    cash_register_nr,
    store_sid,
    cashier_hash,
    txn_net_val,
    txn_gross_val,
    curr_cd,
    return_without_receipt_fg,
    return_without_receipt_ke_input_fg,
    return_without_receipt_dv_input_fg
)
WITH 
mat_params AS
(
    SELECT *
    FROM ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value
    WHERE scenario_id = 13        --  (US: 33407, 56048) Geldrückgabe ohne Originalbon (manuell), Geldrückgaben ohne Originalbon mit Erfassungsart "DV"                                                                    
)
,eval_flags AS
(
    SELECT
        src.*,

        -- flag RETURN_WITHOUT_RECEIPT_KE_INPUT_FG - main scenarioID = 13
        -- (US: 33407) Geldrückgabe ohne Originalbon (manuell)
        CASE
            WHEN 
                ABS(src.ret_txn_gross_val) >= s13_rv.param_val_qty
                AND src.orig_bus_dt IS NULL THEN 1 -- no original receipt found
            ELSE 0 
        END AS line_return_without_receipt_fg,
        
        -- flag RETURN_WITHOUT_RECEIPT_KE_INPUT_FG - main scenarioID = 13
        -- (US: 33407) Geldrückgabe ohne Originalbon (manuell)
        CASE
            WHEN 
                ABS(src.ret_txn_gross_val) >= s13_rv.param_val_qty
                AND src.orig_bus_dt IS NULL -- no original receipt found
                AND src.is_ke_input_fg THEN 1
            ELSE 0 
        END AS line_return_without_receipt_ke_fg,
        
        -- flag RETURN_WITHOUT_RECEIPT_DV_INPUT_FG - main scenarioID = 13
        -- (US: 56048) Geldrückgaben ohne Originalbon mit Erfassungsart "DV"
        CASE
            WHEN 
                ABS(src.ret_txn_gross_val) >= s13_rv.param_val_qty
                AND src.orig_bus_dt IS NULL -- no original receipt found
                AND src.is_dv_input_fg THEN 1
            ELSE 0 
        END AS line_return_without_receipt_dv_fg
    
    FROM t_fraud_detection_returns_common src -- granularity: 1 row per Prod in ReturnReceipt (RET_RETAIL_EVENT_SID, RET_LOCAL_PROD_NR)
    JOIN mat_params s13_rv    -- Scenario 13, parameter "Refund Value (lower bound)"
        ON s13_rv.country_org_cd = src.ret_country_org_cd
       AND s13_rv.scenario_id = 13
       AND s13_rv.param_id = 39    
       AND s13_rv.is_scenario_enabled_in_country_fg = TRUE
    WHERE
        src.is_quantity_suspicious_fg = 1
)
SELECT 
    ef.ret_retail_event_sid                      AS cash_register_event_sid,
    ANY_VALUE(ef.ret_cash_register_event_nr)     AS cash_register_event_nr,
    ANY_VALUE(ef.ret_event_start_tmsp)           AS event_start_tmsp,
    ANY_VALUE(ef.ret_bus_dt)                     AS bus_dt,
    ANY_VALUE(ef.ret_cash_register_sid)          AS cash_register_sid,
    ANY_VALUE(cr.cash_register_nr)               AS cash_register_nr,
    ANY_VALUE(ef.ret_store_sid)                  AS store_sid,
    ANY_VALUE(ef.ret_cashier_hash)               AS cashier_hash,
    ANY_VALUE(ef.ret_txn_net_val)                AS txn_net_val,
    ANY_VALUE(ef.ret_txn_gross_val)              AS txn_gross_val,
    ANY_VALUE(ef.ret_curr_cd)                    AS curr_cd,

    IF(SUM(line_return_without_receipt_fg) > 0, 1, 0)         AS return_without_receipt_fg,
    IF(SUM(line_return_without_receipt_ke_fg) > 0, 1, 0)      AS return_without_receipt_ke_input_fg,
    IF(SUM(line_return_without_receipt_dv_fg) > 0, 1, 0)      AS return_without_receipt_dv_input_fg

FROM eval_flags ef
JOIN ldl_data_production_core_rel.t_cash_register cr
    ON ef.ret_cash_register_sid = cr.cash_register_sid
   AND cr.dwh_valid_fg = TRUE
GROUP BY
    ret_retail_event_sid
-- at least one flag is true
HAVING return_without_receipt_fg = 1;








