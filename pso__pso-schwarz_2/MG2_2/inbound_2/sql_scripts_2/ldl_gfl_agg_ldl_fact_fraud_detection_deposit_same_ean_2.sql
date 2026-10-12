/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_deposit_same_ean.sql
#----------------------------------------------------------------------------
# History:
#  1.0  05.09.2024  Martin Lysik       ZKP GF_2 - script for scenario Deposit receipts with same EAN_2
#                                      Flag DEPOSIT_SAME_EAN_FG
#                                      https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/33401

#  1.1  21.11.2024  Mihail Ivanov      no logic changes. Just restructuring the code to make it more readable
#  1.2  12.12.2024  Kamil Roszczyk     ZKP GF_2 - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/58183
#										Change log:
#											- moved the qualification of one line per receipt to a separate CTE due to the Snowflake not applying QUALIFY filters in an order as applied in the code


#  1.3  26.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenaio is enabled in a country_2 (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/63803
							
#  1.4  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script

#  1.5  16.05.2025  Kamil Roszczyk - Changes:
						Added filtering for multiple lines coming from same deposit return EAN_2 number within a single receipt
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-int/_workitems/edit/70656
*/

-- we are looking for repeatin EAN_2 (by same cashier, in same store) in this time interval
 SET sv_dt_from = (select to_char(CURRENT_DATE - DayOfWeek(CURRENT_DATE) - (7*13-1), 'YYYY-MM_2-DD') from dual);
 SET sv_dt_to = (select to_char(CURRENT_DATE, 'YYYY-MM_2-DD') from dual);

	  
INSERT INTO ${FWRK_WORK_DB}.t_fact_fraud_detection_by_cash_register_event_final
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

  , deposit_same_ean_fg
)
WITH
mat_params AS
(
    SELECT *
    FROM CORE_APP_FRAUD_DETECTION.V_FRAUD_DETECTION_PARAMETER_CURRENT_VALUE_2
    WHERE SCENARIO_ID = 2 
)
,calc_ean_groups AS
(
-- Evaluate receipt lines from the calculation scope.
-- Return receipts which contains (empty) deposit return line with repeated EAN_2 within a {store, cashier}.
-- Only EANs of length 19 or 24 are considered and evaluated separately for duplicates.
--   If the EAN_2 length is 19, then we consider the first 13 numbers.
--   If the EAN_2 length is 24, then we consider the first 3 and last 10 numbers.
--
--This and next two CTEs have QUALIFY filters that have to be evaluated each in a single CTE
--That's because Snowflake does not assure the QUALIFY filter execution order if more than one QUALIFY filter is placed within a single query
--Conflicting QUALIFY filters within a same query can lead to unexpected filtering being applied
    SELECT
		re.retail_event_sid                     AS cash_register_event_sid
		,re.cash_register_event_nr
		,rln.retail_event_line_seq
		,re.event_start_tmsp
		,re.event_end_tmsp
		,re.bus_dt
		,re.cash_register_sid
		,cr.cash_register_nr
		,re.store_sid
		,re.cashier_hash
		,re.txn_net_val
		,re.txn_gross_val
		,re.curr_cd
		,re.country_org_cd
		,ce.cashier_nr

		,CASE
				  /* Add length to the end to keep the information about it in the grouping.
					 Lenghts 19 and 24 are to be evaluated independently. */
				  WHEN LENGTH(rln.prod_variant_input_nr) = 19 THEN SUBSTRING(rln.prod_variant_input_nr, 1, 13) || '19'
				  WHEN LENGTH(rln.prod_variant_input_nr) = 24 THEN SUBSTRING(rln.prod_variant_input_nr, 1, 3) || SUBSTRING(rln.prod_variant_input_nr, 15, 10) || '24'
				  ELSE NULL
            END ean_group
		, COUNT(DISTINCT re.retail_event_sid) OVER(PARTITION BY re.store_sid, ce.cashier_nr, ean_group) AS receipts_per_group
      
    FROM core_rel.T_PRODUCT_RETAIL_LINE_2 AS rln  
		INNER JOIN CORE_REL.T_RETAIL_EVENT_2 AS re_2
				ON  rln.retail_event_sid = re.retail_event_sid

		INNER JOIN core_rel.T_CASH_REGISTER_2 AS cr
				ON  re.cash_register_sid = cr.cash_register_sid
				AND cr.dwh_valid_fg = True

		INNER JOIN core_app_fraud_detection.T_CASHIER_ENCRYPTION_2 ce
				ON  rln.cashier_hash = ce.cashier_hash


    WHERE 1=1
		and rln.bus_dt BETWEEN $sv_dt_from AND $sv_dt_to
		and rln.turnover_relevant_fg = True
		and rln.prod_retail_line_type_cd = 'D' /* Deposit Return Receipt */
		and Length(rln.prod_variant_input_nr) in (19,24)
      
    QUALIFY 1=1
		and receipts_per_group > 1
)
, qualify_distinct_receipts AS
(
	SELECT
        cash_register_event_sid
      , cash_register_event_nr
	  , retail_event_line_seq
      , event_start_tmsp
      , bus_dt
      , cash_register_sid
      , cash_register_nr
      , store_sid
      , cashier_hash
      , txn_net_val
      , txn_gross_val
      , curr_cd

	  --Ranking receipts by order of issueing. In the next CTE all receipts apart from the first one based on this ranking will be marked as suspicious
	  --In this CTE it's still possible that more than one line is available per receipt/ean_group combination so RANK() can produce more than one same rank number for these lines
	  --However it's fine in this case: it doesn't really matter if, say, second receipt in order has rank number of 3 due to the first receipt having two lines at this level
	  --That first receipt will be discarded anyways as both lines will have rank number 1 and second will be qualified as rank number 3 is greater than 1
	  , RANK() OVER(PARTITION BY ean_group ORDER BY event_end_tmsp) AS receipt_sort_nr
    FROM calc_ean_groups
	WHERE
		-- only evaluate receipts for countries where the scenario is enabled
		-- filter moved from calc_ean_groups CTE as it usually caused severe performance issues during testing when it was in calc_ean_groups
		COUNTRY_ORG_CD in (
			SELECT 
				DISTINCT 
				mp.COUNTRY_ORG_CD
			FROM mat_params mp
			WHERE mp.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
		)
	QUALIFY
		receipt_sort_nr > 1
)
, qualify_single_row AS
(
	SELECT
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
	  
      , True AS deposit_same_ean_fg
    FROM qualify_distinct_receipts
	QUALIFY
		--List the receipt just once, even when more deposit return lines have a duplicate EAN_2
		ROW_NUMBER() OVER(PARTITION BY cash_register_event_sid ORDER BY retail_event_line_seq) = 1
)
-- All receipts flagged in any previous flag calculation will get the flag set to False.
-- Unless it will be flagged as True in the subquery calc_new_flags. In this case the True flag is preserved. */
-- this special logic is applied only for countrie where scenario is enabled (for countries where scenario is disabled the logic is more straight-forward and added in the end as UNION ALL)
, clean_old_flags AS
(
    SELECT
        f.cash_register_event_sid
      , f.cash_register_event_nr
      , f.event_start_tmsp
      , f.bus_dt
      , f.cash_register_sid
      , f.cash_register_nr
      , f.store_sid
      , f.cashier_hash
      , f.txn_net_val
      , f.txn_gross_val
      , f.curr_cd

      , False                                   AS deposit_same_ean_fg
      
    FROM CORE_DIM.t_fact_fraud_detection_by_cash_register_event_2 f
		join core_dim.T_DIM_INTERNAL_ORGANIZATION_2 io
				on f.STORE_SID = io.INT_ORG_SID
				and io.DWH_VALID_FG = TRUE	
	WHERE 1=1
		-- receipt has the flag for scenario
		and f.deposit_same_ean_fg = TRUE
		-- but scenario is disabled in the Country_2
		and io.COUNTRY_ORG_CD in (
			SELECT 
				DISTINCT 
				mp.COUNTRY_ORG_CD
			FROM mat_params mp
			WHERE mp.IS_SCENARIO_ENABLED_IN_COUNTRY_FG = TRUE
		)
    AND deposit_same_ean_fg = True
)
-- Combine the receipts where the flag needs to be cleaned and set.
-- Final flag value is calculated later using the Max aggregation.
, union_new_old AS
(
    SELECT
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
      , deposit_same_ean_fg
    FROM qualify_single_row
    UNION ALL
    SELECT
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
      , deposit_same_ean_fg
    FROM clean_old_flags
)
SELECT 
    cash_register_event_sid
  , Any_Value(cash_register_event_nr)     AS cash_register_event_nr
  , Any_Value(event_start_tmsp)           AS event_start_tmsp
  , Any_Value(bus_dt)                     AS bus_dt
  , Any_Value(cash_register_sid)          AS cash_register_sid
  , Any_Value(cash_register_nr)           AS cash_register_nr
  , Any_Value(store_sid)                  AS store_sid
  , Any_Value(cashier_hash)               AS cashier_hash
  , Any_Value(txn_net_val)                AS txn_net_val
  , Any_Value(txn_gross_val)              AS txn_gross_val
  , Any_Value(curr_cd)                    AS curr_cd
  , Max(deposit_same_ean_fg)              AS deposit_same_ean_fg
FROM union_new_old
GROUP BY
    cash_register_event_sid
;
