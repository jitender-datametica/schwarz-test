/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_by_cash_register_event.sql
#----------------------------------------------------------------------------
# History:

# 1.0  16.08.2024  Andrzej Wandtke  - ZKP GF_1 - script for loading the table t_fact_fraud_detection_by_cash_register_event_1
# 1.1  08.11.2024  Andrzej Wandtke  - ZKP GF_1 - add columns cancel_last_pos_highest_pos_fg, cancel_last_pos_outside_opening_hr_fg, cancel_last_and_other_pos_fg
# 1.2  14.11.2024  Andrzej Wandtke  - ZKP GF_1 - add columns for other sub-scenarios
# 1.3  15.11.2024  Andrzej Wandtke  - ZKP GF_1 - add flags for possible future use, set currently to FALSE
# 1.4  20.11.2024  Andrzej Wandtke  - ZKP GF_1 - add flags for possible future use, set currently to FALSE
# 1.5  27.11.2024  Mihail Ivanov    - ZKP GF_1 - add DELETE part in the MERGE statement to remove receipts if new evaluation considers them "not suspicious"
# 1.6  02.12.2024  Mihail Ivanov    - ZKP GF_1 - populate new cols CUST_SID and CUST_IDENT_TYPE_CD
# 1.7  20.11.2024  Andrzej Wandtke  - ZKP GF_1 - remove call to ldl_fact_fraud_detection_return_same_prod.sql (Bug 56757 - asked to deactivate this scenario)
# 1.8  20.11.2024  Mihail Ivanov  	- ZKP GF_1 - handle special cases for scenarios that evaluate receipts outside delta (requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/62548/)
# 1.9  19.02.2025  Mihail Ivanov  	- ZKP GF_1 - Added 4 columns
											3 of them are sub-scenarios requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63798/
											1 is EVENT_END_TMSP requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/64336
# 1.10 27.03.2025  Kamil Roszczyk	- ZKP GF_1 - removed relevant_cancel_gross_val and relevant_cancel_line_cnt column and replaced with 4 new columns according to the new data model
											https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/66945
# 1.11 02.04.2025  Andrzej Wandtke  - ZKP GF_1 - add condition final_cashier_hash IS NOT NULL, 
                                               add column return_mult_prod_same_cashier_fg
	
# 1.12 03.04.2025  Mihail Ivanov  	- ZKP GF_1 - Added UPDATEs at the end that set to FALSE any flag that was previously TRUE but the scenario is disabled in the country_1

# 1.13 25.04.2025  Andrzej Wandtke  - ZKP - 69046 - Exclude stores from Luxemburg - they belong technically do Belgium, but are based in Luxembourg
*/



/*
    Create working table. This table is not temporary because it has to be accessible outside of this script.
*/
CREATE OR REPLACE TRANSIENT TABLE ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final 
DATA_RETENTION_TIME_IN_DAYS = 0
AS
SELECT *
FROM CORE_DIM.t_fact_fraud_detection_by_cash_register_event_1
WHERE 1=2;


SELECT ${LOAD_ID}
FROM dual;


-- Exclude stores from Luxembourg
DELETE FROM ${FWRK_WORK_DB}.VT1
WHERE LOC_SID IN 
(SELECT INT_ORG_SID
 FROM   CORE_DIM.T_DIM_INTERNAL_ORGANIZATION_1
 WHERE  UPPER(SUBSTR(CURR_INT_ORG_NR,1,2)) = 'LU'
 AND    DWH_VALID_FG
);


------------------------------------------------------------------
/*
	Evaluation of scenarios which can affect receipts outside delta interval


	The following scenarios evaluate older receitps which could be outside of the delta interval
		- LDL_FACT_FRAUD_DETECTION_DEPOSIT_SAME_EAN.sql
		- LDL_FACT_FRAUD_DETECTION_RETURN_SAME_RECEIPT.sql
		
	If a receipt was marked in one of these scenarios and is not part of the delta, then the other flags are not revaluated and will all be false
	To avoid setting incorrectly the other flags to FALSE, we create a list(table) of the SIDs of the events and update only relevant flags for these SIDs
*/

##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_deposit_same_ean.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_return_same_receipt.sql


-- we could have two rows for same Event, if it was evaluated in both scenarios 
-- so we need to know in which scenario it was evaluated
CREATE OR REPLACE TEMPORARY TABLE ${FWRK_WORK_DB}.T_TMP_EVENTS_OUTSIDE_DELTA
AS
SELECT
	src.CASH_REGISTER_EVENT_SID
	,any_value(src.STORE_SID)	as STORE_SID
	,any_value(src.BUS_DT)		as BUS_DT
	
	-- if a flag is set to TRUE or FALSE then the EVENT was evaluated in the given scenario
	-- if a flag is has only NULL values then it was not evaluated
	-- "EOD" stands for "Event is Outside Delta"
	,sum(IFF(src.DEPOSIT_SAME_EAN_FG is not null, 1, 0)) > 0 		as IS_EOD_DEPOSIT_SAME_EAN_FG
	,sum(IFF(src.RETURN_SAME_RECEIPT_FG is not null, 1, 0)) > 0 	as IS_EOD_RETURN_SAME_RECEIPT_FG
	
FROM ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final src 
	left join ${FWRK_WORK_DB}.VT1 d -- delta
            on src.BUS_DT = d.DWH_CAL_DT
            and src.STORE_SID = d.LOC_SID
WHERE
	d.LOC_SID is NULL -- receipt is evaluated, but is not in delta range
GROUP BY 
	src.CASH_REGISTER_EVENT_SID
;
------------------------------------------------------------------


------------------------------------------------------------------
-- Remaining Scenarios Evaluation
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_abort_logoff_sale.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_cancel_in_favour.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_deposit_only_manual_input.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_last_position_cancel.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_price_info_mult.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_price_info_and_small_sale_or_logoff.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_return_common.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_return_no_orig_receipt.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_suspend_unresolved_logoff_sale.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_return_at_price_higher_than_orig.sql
##MACRO## $AI_SQL/zkp/ldl_fact_fraud_detection_suspended_and_cancelled.sql
------------------------------------------------------------------






/*
    Final rows preparation
*/


-- Create aggregated table (line per event) with no null values
CREATE OR REPLACE TABLE ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_agg_1 LIKE CORE_DIM.t_fact_fraud_detection_by_cash_register_event_1;

INSERT INTO ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_agg_1
(
     cash_register_event_sid
    ,cash_register_event_nr
    ,event_start_tmsp
	,event_end_tmsp
    ,bus_dt
    ,cash_register_sid
    ,cash_register_nr
    ,store_sid
    ,cashier_hash
    ,txn_net_val
    ,txn_gross_val
    ,cancel_last_pos_gross_val
	,cancel_in_favour_gross_val
    ,curr_cd
    ,cancel_last_pos_line_cnt
	,cancel_in_favour_line_cnt
    ,cust_sid
    ,cust_ident_type_cd
    ,cancel_last_pos_fg
    ,cancel_last_pos_alcohol_tobacco_fg
    ,cancel_last_pos_exact_paym_fg
    ,cancel_last_pos_after_subtotal_fg
	,cancel_last_pos_without_auth_fg
    ,cancel_last_pos_highest_pos_fg
    ,cancel_last_pos_outside_opening_hr_fg
    ,cancel_last_and_other_pos_fg
	,cancel_last_pos_single_pos_fg
    ,cancel_in_favour_fg
    ,cancel_in_favour_alcohol_tobacco_fg
    ,cancel_in_favour_exact_paym_fg
    ,cancel_in_favour_after_subtotal_fg
    ,cancel_in_favour_outside_opening_hr_fg
    ,cancel_in_favour_manual_discount_fg
    ,cancel_in_favour_without_auth_fg
    ,cancel_in_favour_highest_pos_fg
    ,cancel_in_favour_lidl_plus_fg
	,cancel_in_favour_single_pos_fg
    ,return_at_higher_than_sales_price_fg
    ,return_at_higher_than_official_price_fg
    ,return_same_prod_fg
    ,return_mult_prod_fg
    ,return_mult_prod_same_cashier_fg
    ,return_mult_prod_full_qty_fg
    ,return_same_receipt_fg
    ,return_same_receipt_full_qty_fg
    ,return_same_receipt_same_cashier_fg
    ,return_without_receipt_fg
    ,return_without_receipt_ke_input_fg
    ,return_without_receipt_dv_input_fg
    ,return_not_on_receipt_fg
    ,return_qty_invalid_fg
    ,return_without_auth_fg
    ,return_same_cashier_fg
    ,return_same_cashier_diff_day_fg
    ,return_same_cashier_and_day_fg
    ,return_same_cashier_and_day_card_paym_fg
    ,return_same_cashier_and_day_cash_paym_fg
    ,return_same_cashier_and_day_without_auth_fg
    ,return_same_cashier_and_day_manual_fg
    ,return_same_cashier_and_day_display_sel_fg
    ,deposit_and_one_prod_fg
    ,deposit_only_manual_input_fg
    ,deposit_same_ean_fg
    ,price_info_mult_fg
    ,price_info_and_small_sale_fg
    ,price_info_and_logoff_fg
    ,suspend_and_abort_fg
    ,suspend_and_line_cancel_fg
    ,suspend_and_extend_fg
    ,suspend_unresolved_and_sale_fg
    ,suspend_unresolved_and_logoff_fg
    ,abort_and_sale_fg
    ,abort_and_logoff_fg
    ,small_sale_fg
    
    ,dwh_created_tmsp
    ,dwh_updated_tmsp
    ,dwh_load_id
    ,dwh_node_cd)
SELECT 
	 f.cash_register_event_sid
	,CAST(f.cash_register_event_nr as INTEGER)
	,f.event_start_tmsp
	,COALESCE(re.event_end_tmsp, tcre.event_tmsp, pie.event_tmsp) as final_event_end_tmsp 
	,f.bus_dt
	,f.cash_register_sid
	,MAX(f.cash_register_nr) AS cash_register_nr --workaround unil data in T_CASH_REGISTER_1 is fixed
	,f.store_sid
	,COALESCE(re.cashier_hash, tcre.cashier_hash, pie.cashier_hash) as final_cashier_hash 
	,MAX(NVL(f.txn_net_val,0))
	,MAX(NVL(f.txn_gross_val,0))
	,MAX(NVL(f.cancel_last_pos_gross_val,0))
	,MAX(NVL(f.cancel_in_favour_gross_val,0))
	,f.curr_cd
	,MAX(NVL(f.cancel_last_pos_line_cnt,0))
	,MAX(NVL(f.cancel_in_favour_line_cnt,0))
	
	-- in core_dim we have dummy_1 values instead of nulls. CUST info is valid only for retail events
	,nvl(MAX(re.cust_sid), -1) 				
	,nvl(MAX(re.cust_ident_type_cd), '@')

	,MAX(NVL(cancel_last_pos_fg, false))
	,MAX(NVL(cancel_last_pos_alcohol_tobacco_fg, false))
	,MAX(NVL(cancel_last_pos_exact_paym_fg, false))
	,MAX(NVL(cancel_last_pos_after_subtotal_fg, false))
	,MAX(NVL(cancel_last_pos_without_auth_fg, false))
	,MAX(NVL(cancel_last_pos_highest_pos_fg, false))
	,MAX(NVL(cancel_last_pos_outside_opening_hr_fg, false))
	,MAX(NVL(cancel_last_and_other_pos_fg, false))
	,MAX(NVL(cancel_last_pos_single_pos_fg, false))
	,MAX(NVL(cancel_in_favour_fg, false))
	,MAX(NVL(cancel_in_favour_alcohol_tobacco_fg, false))
	,MAX(NVL(cancel_in_favour_exact_paym_fg, false))
	,MAX(NVL(cancel_in_favour_after_subtotal_fg, false))
	,MAX(NVL(cancel_in_favour_outside_opening_hr_fg, false))
	,MAX(NVL(cancel_in_favour_manual_discount_fg, false))
	,MAX(NVL(cancel_in_favour_without_auth_fg, false))
	,MAX(NVL(cancel_in_favour_highest_pos_fg, false))
	,MAX(NVL(cancel_in_favour_lidl_plus_fg, false))
	,MAX(NVL(cancel_in_favour_single_pos_fg, false))
	,MAX(NVL(return_at_higher_than_sales_price_fg, false))
	,MAX(NVL(return_at_higher_than_official_price_fg, false))
	,MAX(NVL(return_same_prod_fg, false))
	,MAX(NVL(return_mult_prod_fg, false))
	,MAX(NVL(return_mult_prod_same_cashier_fg, false))
	,MAX(NVL(return_mult_prod_full_qty_fg, false))
	,MAX(NVL(return_same_receipt_fg, false))-- older receipts could exist
	,MAX(NVL(return_same_receipt_full_qty_fg, false)) -- not implemented - ordered and then cancelled by business but for now we keep the col
	,MAX(NVL(return_same_receipt_same_cashier_fg, false))
	,MAX(NVL(return_without_receipt_fg, false))
	,MAX(NVL(return_without_receipt_ke_input_fg, false))
	,MAX(NVL(return_without_receipt_dv_input_fg, false))
	,MAX(NVL(return_not_on_receipt_fg, false))
	,MAX(NVL(return_qty_invalid_fg, false))
	,MAX(NVL(return_without_auth_fg, false))
	,MAX(NVL(return_same_cashier_fg, false))
	,MAX(NVL(return_same_cashier_diff_day_fg, false))
	,MAX(NVL(return_same_cashier_and_day_fg, false))
	,MAX(NVL(return_same_cashier_and_day_card_paym_fg, false))
	,MAX(NVL(return_same_cashier_and_day_cash_paym_fg, false))
	,MAX(NVL(return_same_cashier_and_day_without_auth_fg, false))
	,MAX(NVL(return_same_cashier_and_day_manual_fg, false))
	,MAX(NVL(return_same_cashier_and_day_display_sel_fg, false))
	,MAX(NVL(deposit_and_one_prod_fg, false))
	,MAX(NVL(deposit_only_manual_input_fg, false))
	,MAX(NVL(deposit_same_ean_fg, false)) -- older receipts could exist
	,MAX(NVL(price_info_mult_fg, false))
	,MAX(NVL(price_info_and_small_sale_fg, false))
	,MAX(NVL(price_info_and_logoff_fg, false))
	,MAX(NVL(suspend_and_abort_fg, false))
	,MAX(NVL(suspend_and_line_cancel_fg, false))
	,MAX(NVL(suspend_and_extend_fg, false))
	,MAX(NVL(suspend_unresolved_and_sale_fg, false))
	,MAX(NVL(suspend_unresolved_and_logoff_fg, false))
	,MAX(NVL(abort_and_sale_fg, false))
	,MAX(NVL(abort_and_logoff_fg, false))
	,MAX(NVL(small_sale_fg, false))

	,Current_Timestamp()
	,Current_Timestamp()
	,${LOAD_ID}
	,'CORE_REL'
FROM ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final f

    left join core_rel.T_PRICE_INFORMATION_EVENT_1 pie 
			on f.CASH_REGISTER_EVENT_SID = pie.PRICE_INFO_EVENT_SID
			and f.BUS_DT = pie.BUS_DT 
            
	left join core_rel.T_RETAIL_EVENT_1 re_1 
			on f.CASH_REGISTER_EVENT_SID = re.RETAIL_EVENT_SID
            -- absolutely ridiculous condition. Seems moronic and f.BUS_DT will never be null.
            -- but this way we are tricking snowflake to start first from "f", then "pie" and then "re_1"
            -- otherwise it starts with "re_1" and reads the full table 25B+ rows no filters, no pruning ...  
			and nvl(f.BUS_DT, pie.BUS_DT) = re.BUS_DT  
	left join core_rel.T_TECHNICAL_CASH_REGISTER_EVENT_1 tcre 
			on f.CASH_REGISTER_EVENT_SID = tcre.TECH_CASH_REGISTER_EVENT_SID
			and f.BUS_DT = tcre.BUS_DT 
WHERE final_cashier_hash IS NOT NULL
GROUP BY
	 f.cash_register_event_sid
	,CAST(f.cash_register_event_nr as INTEGER)
	,f.event_start_tmsp
	,final_event_end_tmsp
	,f.bus_dt
	,f.cash_register_sid
	--,cash_register_nr
	,f.store_sid
	,final_cashier_hash
	,f.curr_cd
;



-- Final merge with the destination table

MERGE INTO core_dim.t_fact_fraud_detection_by_cash_register_event_1 AS tgt
USING 
(
	select 
		n_rows.*
		,'NEW' as ROW_TYPE
		-- these flags could be TRUE/FALSE or NULL (becaue of left join). We have special case if they are TRUE
		,eod.IS_EOD_DEPOSIT_SAME_EAN_FG
		,eod.IS_EOD_RETURN_SAME_RECEIPT_FG
	from ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_agg_1 n_rows
		left join ${FWRK_WORK_DB}.T_TMP_EVENTS_OUTSIDE_DELTA eod
				on n_rows.CASH_REGISTER_EVENT_SID = eod.CASH_REGISTER_EVENT_SID
	
	union all
	
	-- receipts that currenty exist in the target, but we evaluated again the store for same period and now the receipt is not suspicious
	-- 		so, it should be deleted
	select
		o_rows.*
		,'OLD' as ROW_TYPE
		,NULL IS_EOD_DEPOSIT_SAME_EAN_FG
		,NULL IS_EOD_RETURN_SAME_RECEIPT_FG
	from core_dim.t_fact_fraud_detection_by_cash_register_event_1 o_rows
		left join ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_agg_1 n_rows
				on o_rows.cash_register_event_sid = n_rows.cash_register_event_sid
	where EXISTS
		(
			SELECT 1
			FROM ${FWRK_WORK_DB}.VT1
			WHERE 1=1
				and o_rows.BUS_DT = vt1.DWH_CAL_DT
				and o_rows.STORE_SID = vt1.LOC_SID
		)
		and n_rows.cash_register_event_sid is null
	
) src
	ON  tgt.cash_register_event_sid = src.cash_register_event_sid

WHEN MATCHED AND src.ROW_TYPE = 'OLD' 
    THEN DELETE
	
-- 3 SPECIAL cases for UPDATE - update only the relevant flags and the timestamp
WHEN MATCHED 											-- event exists in CORE_DIM
	AND src.ROW_TYPE = 'NEW' 							-- event was evaluated also this run
	AND src.IS_EOD_DEPOSIT_SAME_EAN_FG = TRUE			-- event is NOT in delta interval and was evaluated in this scenario
	AND src.IS_EOD_RETURN_SAME_RECEIPT_FG = TRUE		-- event is NOT in delta interval and was evaluated in this scenario
	THEN UPDATE SET
			return_same_receipt_fg 	= src.return_same_receipt_fg
			,deposit_same_ean_fg 	= src.deposit_same_ean_fg
			,dwh_updated_tmsp 		= Current_Timestamp()
			,dwh_load_id 			= ${LOAD_ID}
			
WHEN MATCHED 											-- event exists in CORE_DIM
	AND src.ROW_TYPE = 'NEW' 							-- event was evaluated also this run
	AND src.IS_EOD_DEPOSIT_SAME_EAN_FG = TRUE			-- event is NOT in delta interval and was evaluated in ONLY this scenario
	THEN UPDATE SET
			deposit_same_ean_fg 	= src.deposit_same_ean_fg
			,dwh_updated_tmsp 		= Current_Timestamp()
			,dwh_load_id 			= ${LOAD_ID}

WHEN MATCHED 											-- event exists in CORE_DIM
	AND src.ROW_TYPE = 'NEW' 							-- event was evaluated also this run
	AND src.IS_EOD_RETURN_SAME_RECEIPT_FG = TRUE		-- event is NOT in delta interval and was evaluated in ONLY this scenario
	THEN UPDATE SET	
			return_same_receipt_fg 	= src.return_same_receipt_fg
			,dwh_updated_tmsp 		= Current_Timestamp()
			,dwh_load_id 			= ${LOAD_ID}

-- GENERIC case for UPDATE (none of the conditions of special case is true)
-- we intentionally update all receipts even if nothing is changed, because we need to know when is the last time each receipt is evaluated"
-- 		this is why there is no comparison if "trg.cancel_last_pos_fg != src.cancel_last_pos_fg ... " and so on ....
WHEN MATCHED AND src.ROW_TYPE = 'NEW'
	THEN UPDATE SET
		 cash_register_event_nr                         = src.cash_register_event_nr
		,event_start_tmsp                               = src.event_start_tmsp
		,event_end_tmsp                               	= src.event_end_tmsp
		,bus_dt                                         = src.bus_dt
		,cash_register_sid                              = src.cash_register_sid
		,cash_register_nr                               = src.cash_register_nr
		,store_sid                                      = src.store_sid
		,cashier_hash                                   = src.cashier_hash
		,txn_net_val                                    = src.txn_net_val
		,txn_gross_val                                  = src.txn_gross_val
		,cancel_last_pos_gross_val                      = src.cancel_last_pos_gross_val
		,cancel_in_favour_gross_val                     = src.cancel_in_favour_gross_val
		,curr_cd                                        = src.curr_cd
		,cancel_last_pos_line_cnt                       = src.cancel_last_pos_line_cnt
		,cancel_in_favour_line_cnt                      = src.cancel_in_favour_line_cnt
		,cust_sid                       		= src.cust_sid
		,cust_ident_type_cd                     	= src.cust_ident_type_cd

		,cancel_last_pos_fg				= src.cancel_last_pos_fg									
		,cancel_last_pos_alcohol_tobacco_fg		= src.cancel_last_pos_alcohol_tobacco_fg
		,cancel_last_pos_exact_paym_fg			= src.cancel_last_pos_exact_paym_fg
		,cancel_last_pos_after_subtotal_fg		= src.cancel_last_pos_after_subtotal_fg
		,cancel_last_pos_without_auth_fg			= src.cancel_last_pos_without_auth_fg
		,cancel_last_pos_highest_pos_fg			= src.cancel_last_pos_highest_pos_fg
		,cancel_last_pos_outside_opening_hr_fg		= src.cancel_last_pos_outside_opening_hr_fg
		,cancel_last_and_other_pos_fg			= src.cancel_last_and_other_pos_fg
		,cancel_last_pos_single_pos_fg			= src.cancel_last_pos_single_pos_fg
		,cancel_in_favour_fg				= src.cancel_in_favour_fg
		,cancel_in_favour_alcohol_tobacco_fg		= src.cancel_in_favour_alcohol_tobacco_fg
		,cancel_in_favour_exact_paym_fg			= src.cancel_in_favour_exact_paym_fg
		,cancel_in_favour_after_subtotal_fg		= src.cancel_in_favour_after_subtotal_fg
		,cancel_in_favour_outside_opening_hr_fg		= src.cancel_in_favour_outside_opening_hr_fg
		,cancel_in_favour_manual_discount_fg		= src.cancel_in_favour_manual_discount_fg
		,cancel_in_favour_without_auth_fg		= src.cancel_in_favour_without_auth_fg
		,cancel_in_favour_highest_pos_fg		= src.cancel_in_favour_highest_pos_fg
		,cancel_in_favour_lidl_plus_fg                  = src.cancel_in_favour_lidl_plus_fg
		,cancel_in_favour_single_pos_fg                  = src.cancel_in_favour_single_pos_fg
		,return_at_higher_than_sales_price_fg		= src.return_at_higher_than_sales_price_fg
		,return_at_higher_than_official_price_fg	= src.return_at_higher_than_official_price_fg
		,return_same_prod_fg				= src.return_same_prod_fg
		,return_mult_prod_fg				= src.return_mult_prod_fg
		,return_mult_prod_same_cashier_fg               = src.return_mult_prod_same_cashier_fg
		,return_mult_prod_full_qty_fg			= src.return_mult_prod_full_qty_fg
		,return_same_receipt_fg				= src.return_same_receipt_fg
		,return_same_receipt_full_qty_fg		= src.return_same_receipt_full_qty_fg
		,return_same_receipt_same_cashier_fg		= src.return_same_receipt_same_cashier_fg
		,return_without_receipt_fg			= src.return_without_receipt_fg
		,return_without_receipt_ke_input_fg		= src.return_without_receipt_ke_input_fg
		,return_without_receipt_dv_input_fg		= src.return_without_receipt_dv_input_fg
		,return_not_on_receipt_fg			= src.return_not_on_receipt_fg
		,return_qty_invalid_fg				= src.return_qty_invalid_fg
		,return_without_auth_fg				= src.return_without_auth_fg
		,return_same_cashier_fg				= src.return_same_cashier_fg
		,return_same_cashier_diff_day_fg		= src.return_same_cashier_diff_day_fg
		,return_same_cashier_and_day_fg			= src.return_same_cashier_and_day_fg
		,return_same_cashier_and_day_card_paym_fg	= src.return_same_cashier_and_day_card_paym_fg
		,return_same_cashier_and_day_cash_paym_fg	= src.return_same_cashier_and_day_cash_paym_fg
		,return_same_cashier_and_day_without_auth_fg	= src.return_same_cashier_and_day_without_auth_fg
		,return_same_cashier_and_day_manual_fg		= src.return_same_cashier_and_day_manual_fg
		,return_same_cashier_and_day_display_sel_fg	= src.return_same_cashier_and_day_display_sel_fg
		,deposit_and_one_prod_fg			= src.deposit_and_one_prod_fg
		,deposit_only_manual_input_fg			= src.deposit_only_manual_input_fg
		,deposit_same_ean_fg				= src.deposit_same_ean_fg
		,price_info_mult_fg				= src.price_info_mult_fg
		,price_info_and_small_sale_fg			= src.price_info_and_small_sale_fg
		,price_info_and_logoff_fg			= src.price_info_and_logoff_fg
		,suspend_and_abort_fg				= src.suspend_and_abort_fg
		,suspend_and_line_cancel_fg			= src.suspend_and_line_cancel_fg
		,suspend_and_extend_fg				= src.suspend_and_extend_fg
		,suspend_unresolved_and_sale_fg			= src.suspend_unresolved_and_sale_fg
		,suspend_unresolved_and_logoff_fg		= src.suspend_unresolved_and_logoff_fg
		,abort_and_sale_fg				= src.abort_and_sale_fg
		,abort_and_logoff_fg				= src.abort_and_logoff_fg
		,small_sale_fg					= src.small_sale_fg
		,dwh_updated_tmsp                               = Current_Timestamp()
		,dwh_load_id                                    = ${LOAD_ID}
		
WHEN NOT MATCHED THEN 
	INSERT
	(
		 cash_register_event_sid
		,cash_register_event_nr
		,event_start_tmsp
		,event_end_tmsp
		,bus_dt
		,cash_register_sid
		,cash_register_nr
		,store_sid
		,cashier_hash
		,txn_net_val
		,txn_gross_val
		,cancel_last_pos_gross_val
		,cancel_in_favour_gross_val
		,curr_cd
		,cancel_last_pos_line_cnt
		,cancel_in_favour_line_cnt
		,cust_sid
		,cust_ident_type_cd

		,cancel_last_pos_fg
		,cancel_last_pos_alcohol_tobacco_fg
		,cancel_last_pos_exact_paym_fg
		,cancel_last_pos_after_subtotal_fg
		,cancel_last_pos_without_auth_fg
		,cancel_last_pos_highest_pos_fg
		,cancel_last_pos_outside_opening_hr_fg
		,cancel_last_and_other_pos_fg
		,cancel_last_pos_single_pos_fg
		,cancel_in_favour_fg
		,cancel_in_favour_alcohol_tobacco_fg
		,cancel_in_favour_exact_paym_fg
		,cancel_in_favour_after_subtotal_fg
		,cancel_in_favour_outside_opening_hr_fg
		,cancel_in_favour_manual_discount_fg
		,cancel_in_favour_without_auth_fg
		,cancel_in_favour_highest_pos_fg
		,cancel_in_favour_lidl_plus_fg
		,cancel_in_favour_single_pos_fg
		,return_at_higher_than_sales_price_fg
		,return_at_higher_than_official_price_fg
		,return_same_prod_fg
		,return_mult_prod_fg
		,return_mult_prod_same_cashier_fg
		,return_mult_prod_full_qty_fg
		,return_same_receipt_fg
		,return_same_receipt_full_qty_fg
		,return_same_receipt_same_cashier_fg
		,return_without_receipt_fg
		,return_without_receipt_ke_input_fg
		,return_without_receipt_dv_input_fg
		,return_not_on_receipt_fg
		,return_qty_invalid_fg
		,return_without_auth_fg
		,return_same_cashier_fg
		,return_same_cashier_diff_day_fg
		,return_same_cashier_and_day_fg
		,return_same_cashier_and_day_card_paym_fg
		,return_same_cashier_and_day_cash_paym_fg
		,return_same_cashier_and_day_without_auth_fg
		,return_same_cashier_and_day_manual_fg
		,return_same_cashier_and_day_display_sel_fg
		,deposit_and_one_prod_fg
		,deposit_only_manual_input_fg
		,deposit_same_ean_fg
		,price_info_mult_fg
		,price_info_and_small_sale_fg
		,price_info_and_logoff_fg
		,suspend_and_abort_fg
		,suspend_and_line_cancel_fg
		,suspend_and_extend_fg
		,suspend_unresolved_and_sale_fg
		,suspend_unresolved_and_logoff_fg
		,abort_and_sale_fg
		,abort_and_logoff_fg
		,small_sale_fg
		,dwh_created_tmsp
		,dwh_updated_tmsp
		,dwh_load_id
		,dwh_node_cd
	)
	VALUES
	(
		 cash_register_event_sid
		,cash_register_event_nr
		,event_start_tmsp
		,event_end_tmsp
		,bus_dt
		,cash_register_sid
		,cash_register_nr
		,store_sid
		,cashier_hash
		,txn_net_val
		,txn_gross_val
		,cancel_last_pos_gross_val
		,cancel_in_favour_gross_val
		,curr_cd
		,cancel_last_pos_line_cnt
		,cancel_in_favour_line_cnt
		,cust_sid 
		,cust_ident_type_cd

		,cancel_last_pos_fg
		,cancel_last_pos_alcohol_tobacco_fg
		,cancel_last_pos_exact_paym_fg
		,cancel_last_pos_after_subtotal_fg
		,cancel_last_pos_without_auth_fg
		,cancel_last_pos_highest_pos_fg
		,cancel_last_pos_outside_opening_hr_fg
		,cancel_last_and_other_pos_fg
		,cancel_last_pos_single_pos_fg
		,cancel_in_favour_fg
		,cancel_in_favour_alcohol_tobacco_fg
		,cancel_in_favour_exact_paym_fg
		,cancel_in_favour_after_subtotal_fg
		,cancel_in_favour_outside_opening_hr_fg
		,cancel_in_favour_manual_discount_fg
		,cancel_in_favour_without_auth_fg
		,cancel_in_favour_highest_pos_fg
		,cancel_in_favour_lidl_plus_fg
		,cancel_in_favour_single_pos_fg
		,return_at_higher_than_sales_price_fg
		,return_at_higher_than_official_price_fg
		,return_same_prod_fg
		,return_mult_prod_fg
		,return_mult_prod_same_cashier_fg
		,return_mult_prod_full_qty_fg
		,return_same_receipt_fg
		,return_same_receipt_full_qty_fg
		,return_same_receipt_same_cashier_fg
		,return_without_receipt_fg
		,return_without_receipt_ke_input_fg
		,return_without_receipt_dv_input_fg
		,return_not_on_receipt_fg
		,return_qty_invalid_fg
		,return_without_auth_fg
		,return_same_cashier_fg
		,return_same_cashier_diff_day_fg
		,return_same_cashier_and_day_fg
		,return_same_cashier_and_day_card_paym_fg
		,return_same_cashier_and_day_cash_paym_fg
		,return_same_cashier_and_day_without_auth_fg
		,return_same_cashier_and_day_manual_fg
		,return_same_cashier_and_day_display_sel_fg
		,deposit_and_one_prod_fg
		,deposit_only_manual_input_fg
		,deposit_same_ean_fg
		,price_info_mult_fg
		,price_info_and_small_sale_fg
		,price_info_and_logoff_fg
		,suspend_and_abort_fg
		,suspend_and_line_cancel_fg
		,suspend_and_extend_fg
		,suspend_unresolved_and_sale_fg
		,suspend_unresolved_and_logoff_fg
		,abort_and_sale_fg
		,abort_and_logoff_fg
		,small_sale_fg 
		,Current_Timestamp()
		,Current_Timestamp()
		,${LOAD_ID}
		,'CORE_REL'
	);






----------------------------------------------------------------
-- the following updates will affect rows only once when scenario status_1 is changed from Enabled to Disabled for given country_1
-- otherwise they will not update any rows, and not change anything - so no need to worry that we are doing many UPDATEs on one table (which would be bad if it were true)



--------------------------------------------------------------
-- SCENARIO_ID: 2	Gleiche Pfandbon-EAN_1-Nr.
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		DEPOSIT_SAME_EAN_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and DEPOSIT_SAME_EAN_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 2
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 4	Pfandbon manuell + rein
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		DEPOSIT_ONLY_MANUAL_INPUT_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and DEPOSIT_ONLY_MANUAL_INPUT_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 4
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 5	Mehrfachepreisanzeige in Folge
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		PRICE_INFO_MULT_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and PRICE_INFO_MULT_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 5
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 6	Preisanzeige + Kleinstbon oder Abmeldung Kasse
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		PRICE_INFO_AND_SMALL_SALE_FG = FALSE
		,PRICE_INFO_AND_LOGOFF_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and (PRICE_INFO_AND_SMALL_SALE_FG = TRUE or PRICE_INFO_AND_LOGOFF_FG = TRUE)
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 6
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 7	Geldrückgabe nicht autorisierungspflichtig
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		RETURN_WITHOUT_AUTH_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and RETURN_WITHOUT_AUTH_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 7
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 8	Mehrfache Geldrückgabe mit gleichem Originalbon
--	
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		RETURN_SAME_RECEIPT_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and RETURN_SAME_RECEIPT_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 8
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 10	Rückgabe nicht auf Originalbon oder häufiger mit gleichem Originalbon
--	
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		RETURN_NOT_ON_RECEIPT_FG = FALSE
		,RETURN_QTY_INVALID_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and (RETURN_NOT_ON_RECEIPT_FG = TRUE or RETURN_QTY_INVALID_FG = TRUE)
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 10
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;




--------------------------------------------------------------
-- SCENARIO_ID: 11	Rücknahmepreis größer höchster Wawi-Preis
--	
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		RETURN_AT_HIGHER_THAN_SALES_PRICE_FG = FALSE
		,RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and (RETURN_AT_HIGHER_THAN_SALES_PRICE_FG = TRUE or RETURN_AT_HIGHER_THAN_OFFICIAL_PRICE_FG = TRUE)
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 11
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;	
	
	

--------------------------------------------------------------
-- SCENARIO_ID: 12	Geldrückgabe - Originalbon gleicher Tag_1, gleicher Bediener
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		RETURN_SAME_CASHIER_FG = FALSE
		,RETURN_SAME_CASHIER_DIFF_DAY_FG = FALSE
		,RETURN_SAME_CASHIER_AND_DAY_FG = FALSE
		,RETURN_SAME_CASHIER_AND_DAY_WITHOUT_AUTH_FG = FALSE
		,RETURN_SAME_CASHIER_AND_DAY_MANUAL_FG = FALSE
		,RETURN_SAME_CASHIER_AND_DAY_DISPLAY_SEL_FG = FALSE
		,RETURN_SAME_CASHIER_AND_DAY_CASH_PAYM_FG = FALSE
		,RETURN_SAME_CASHIER_AND_DAY_CARD_PAYM_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and RETURN_SAME_CASHIER_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 12
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;




--------------------------------------------------------------
-- SCENARIO_ID: 13	Geldrückgabe ohne Originalbon (manuell)
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		RETURN_WITHOUT_RECEIPT_FG = FALSE
		,RETURN_WITHOUT_RECEIPT_KE_INPUT_FG = FALSE
		,RETURN_WITHOUT_RECEIPT_DV_INPUT_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and RETURN_WITHOUT_RECEIPT_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 13
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 14	Geldrückgabe mehrerer Artikel_1 eines Originalbons
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		RETURN_MULT_PROD_FG = FALSE
		,RETURN_MULT_PROD_FULL_QTY_FG = FALSE
		,RETURN_MULT_PROD_SAME_CASHIER_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and RETURN_MULT_PROD_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 14
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;




--------------------------------------------------------------
-- SCENARIO_ID: 15	Bonrückstellung mit Bonabbruch/Storno
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		SUSPEND_AND_ABORT_FG = FALSE
		,SUSPEND_AND_LINE_CANCEL_FG = FALSE
		,SUSPEND_AND_EXTEND_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and (SUSPEND_AND_ABORT_FG = TRUE or SUSPEND_AND_LINE_CANCEL_FG = TRUE or SUSPEND_AND_EXTEND_FG = TRUE)
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 15
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 16	Offene Bonrückstellung + Kleinstbon o. Abmeldung Kasse
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		SUSPEND_UNRESOLVED_AND_LOGOFF_FG = FALSE
		,SUSPEND_UNRESOLVED_AND_SALE_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and (SUSPEND_UNRESOLVED_AND_LOGOFF_FG = TRUE or SUSPEND_UNRESOLVED_AND_SALE_FG = TRUE)
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 16
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 17	Bonabbruch + Kleinstbon oder Abmeldung Kasse
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		ABORT_AND_SALE_FG = FALSE
		,ABORT_AND_LOGOFF_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and (ABORT_AND_SALE_FG = TRUE or ABORT_AND_LOGOFF_FG = TRUE)
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 17
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;



--------------------------------------------------------------
-- SCENARIO_ID: 18	Storno an letzter Position
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
		CANCEL_LAST_POS_FG = FALSE
		,CANCEL_LAST_POS_AFTER_SUBTOTAL_FG = FALSE
		,CANCEL_LAST_POS_EXACT_PAYM_FG = FALSE
		,CANCEL_LAST_POS_ALCOHOL_TOBACCO_FG = FALSE
		,CANCEL_LAST_POS_HIGHEST_POS_FG = FALSE
		,CANCEL_LAST_POS_OUTSIDE_OPENING_HR_FG = FALSE
		,CANCEL_LAST_AND_OTHER_POS_FG = FALSE
		,CANCEL_LAST_POS_WITHOUT_AUTH_FG = FALSE
		,CANCEL_LAST_POS_SINGLE_POS_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and CANCEL_LAST_POS_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 18
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;




--------------------------------------------------------------
-- SCENARIO_ID: 19	Storno Begünstigungskauf
--
UPDATE core_dim.T_FACT_FRAUD_DETECTION_BY_CASH_REGISTER_EVENT_1
    set 	
        CANCEL_IN_FAVOUR_FG = FALSE
        ,CANCEL_IN_FAVOUR_ALCOHOL_TOBACCO_FG = FALSE
        ,CANCEL_IN_FAVOUR_OUTSIDE_OPENING_HR_FG = FALSE
        ,CANCEL_IN_FAVOUR_WITHOUT_AUTH_FG = FALSE
        ,CANCEL_IN_FAVOUR_MANUAL_DISCOUNT_FG = FALSE
        ,CANCEL_IN_FAVOUR_AFTER_SUBTOTAL_FG = FALSE
        ,CANCEL_IN_FAVOUR_HIGHEST_POS_FG = FALSE
        ,CANCEL_IN_FAVOUR_SINGLE_POS_FG = FALSE
        ,CANCEL_IN_FAVOUR_EXACT_PAYM_FG = FALSE
        ,CANCEL_IN_FAVOUR_LIDL_PLUS_FG = FALSE
		
		,DWH_LOAD_ID = ${LOAD_ID}
		,DWH_UPDATED_TMSP = CURRENT_TIMESTAMP()
WHERE 1=1
    and CANCEL_IN_FAVOUR_FG = TRUE
    -- stores from countries where the scneario is disabled
    and STORE_SID in (
        SELECT DISTINCT io.INT_ORG_SID 
        FROM core_dim.T_DIM_INTERNAL_ORGANIZATION_1 io
            join CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_1 v 
                on io.COUNTRY_ORG_CD = v.COUNTRY_ORG_CD
        WHERE 1=1
            and v.SCENARIO_ID = 19
            and v.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = FALSE
            and io.DWH_VALID_FG = TRUE
            and io.INT_ORG_TYPE_CD = 'STORE'
    )
;


