/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_deposit_same_ean.sql
#----------------------------------------------------------------------------
# History:
#  1.0  05.09.2024  Martin Lysik       ZKP GF - script for scenario Deposit receipts with same EAN
#                                      Flag DEPOSIT_SAME_EAN_FG
#                                      https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/33401
#
#  1.1  21.11.2024  Mihail Ivanov      no logic changes. Just restructuring the code to make it more readable
#  1.2  12.12.2024  Kamil Roszczyk     ZKP GF - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/58183
#                                        Change log:
#                                            - moved the qualification of one line per receipt to a separate CTE due to the Snowflake not applying QUALIFY filters in an order as applied in the code
#
#  1.3  26.03.2025  Mihail Ivanov  - Changes:
#                        - added logic to set the flag only in scenaio is enabled in a country (and remove the flag if scenario is disabled)
#                            https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63803
#
#  1.4  03.04.2025  Mihail Ivanov  - Changes:
#                        Removing flag if scenario is disabled is moved out of this script to the main script
#
#  1.5  16.05.2025  Kamil Roszczyk - Changes:
#                        Added filtering for multiple lines coming from same deposit return EAN number within a single receipt
#                            https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/70656
*/

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
    deposit_same_ean_fg
)
WITH
mat_params AS (
    SELECT *
    FROM ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value
    WHERE scenario_id = 2
),
calc_ean_groups AS (
    -- Evaluate receipt lines from the calculation scope.
-- Return receipts which contains (empty) deposit return line with repeated EAN within a {store, cashier_zzz.
-- Only EANs of length 19 or 24 are considered and evaluated separately for duplicates.
--   If the EAN length is 19, then we consider the first 13 numbers.
--   If the EAN length is 24, then we consider the first 3 and last 10 numbers.
--
--This and next two CTEs have QUALIFY filters that have to be evaluated each in a single CTE
--That's because Snowflake does not assure the QUALIFY filter execution order if more than one QUALIFY filter is placed within a single query
--Conflicting QUALIFY filters within a same query can lead to unexpected filtering being applied
    SELECT
        re.retail_event_sid AS cash_register_event_sid,
        re.cash_register_event_nr,
        rln.retail_event_line_seq,
        re.event_start_tmsp,
        re.event_end_tmsp,
        re.bus_dt,
        re.cash_register_sid,
        cr.cash_register_nr,
        re.store_sid,
        re.cashier_hash,
        re.txn_net_val,
        re.txn_gross_val,
        re.curr_cd,
        re.country_org_cd,
        ce.cashier_nr,

        CASE
            /* Add length to the end to keep the information about it in the grouping.
					 Lenghts 19 and 24 are to be evaluated independently. */
            WHEN LENGTH(rln.prod_variant_input_nr) = 19 THEN
                SUBSTR(rln.prod_variant_input_nr, 1, 13) || '19'
            WHEN LENGTH(rln.prod_variant_input_nr) = 24 THEN
                SUBSTR(rln.prod_variant_input_nr, 1, 3)
                || SUBSTR(rln.prod_variant_input_nr, 15, 10)
                || '24'
            ELSE NULL
        END AS ean_group,
        COUNT(DISTINCT re.retail_event_sid) OVER (
            PARTITION BY re.store_sid, ce.cashier_nr, ean_group
        ) AS receipts_per_group
    FROM ldl_data_production_core_rel.t_product_retail_line AS rln
    INNER JOIN ldl_data_production_core_rel.t_retail_event AS re
        ON rln.retail_event_sid = re.retail_event_sid
    INNER JOIN ldl_data_production_core_rel.t_cash_register AS cr
        ON re.cash_register_sid = cr.cash_register_sid
       AND cr.dwh_valid_fg = TRUE
    INNER JOIN ldl_data_production_core_app_fraud_detection.t_cashier_encryption AS ce
        ON rln.cashier_hash = ce.cashier_hash
    WHERE
        rln.bus_dt BETWEEN sv_dt_from AND sv_dt_to
        AND rln.turnover_relevant_fg = TRUE
        AND rln.prod_retail_line_type_cd = 'D' -- Deposit Return Receipt
        AND LENGTH(rln.prod_variant_input_nr) IN (19, 24)
    QUALIFY receipts_per_group > 1
),
qualify_distinct_receipts AS (
    SELECT
        cash_register_event_sid,
        cash_register_event_nr,
        retail_event_line_seq,
        event_start_tmsp,
        bus_dt,
        cash_register_sid,
        cash_register_nr,
        store_sid,
        cashier_hash,
        txn_net_val,
        txn_gross_val,
        curr_cd,
      --Ranking receipts by order of issueing. In the next CTE all receipts apart from the first one based on this ranking will be marked as suspicious
	  --In this CTE it's still possible that more than one line is available per receipt/ean_group combination so RANK() can produce more than one same rank number for these lines
	  --However it's fine in this case: it doesn't really matter if, say, second receipt in order has rank number of 3 due to the first receipt having two lines at this level
	  --That first receipt will be discarded anyways as both lines will have rank number 1 and second will be qualified as rank number 3 is greater than 1
        RANK() OVER (
            PARTITION BY ean_group
            ORDER BY event_end_tmsp
        ) AS receipt_sort_nr
    FROM calc_ean_groups
    WHERE 
      -- only evaluate receipts for countries where the scenario is enabled
	  -- filter moved from calc_ean_groups CTE as it usually caused severe performance issues during testing when it was in calc_ean_groups
    country_org_cd IN (
        SELECT DISTINCT country_org_cd
        FROM mat_params
        WHERE is_scenario_enabled_in_country_fg = TRUE
    )
    QUALIFY receipt_sort_nr > 1
),
qualify_single_row AS (
    SELECT
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
        TRUE AS deposit_same_ean_fg
    FROM qualify_distinct_receipts
    QUALIFY 
    --List the receipt just once, even when more deposit return lines have a duplicate EAN
    ROW_NUMBER() OVER (
        PARTITION BY cash_register_event_sid
        ORDER BY retail_event_line_seq
    ) = 1
),
-- All receipts flagged in any previous flag calculation will get the flag set to False.
-- Unless it will be flagged as True in the subquery calc_new_flags. In this case the True flag is preserved. */
-- this special logic is applied only for countrie where scenario is enabled (for countries where scenario is disabled the logic is more straight-forward and added in the end as UNION ALL)
clean_old_flags AS (
    SELECT
        f.cash_register_event_sid,
        f.cash_register_event_nr,
        f.event_start_tmsp,
        f.bus_dt,
        f.cash_register_sid,
        f.cash_register_nr,
        f.store_sid,
        f.cashier_hash,
        f.txn_net_val,
        f.txn_gross_val,
        f.curr_cd,
        FALSE AS deposit_same_ean_fg
    FROM ldl_data_production_core_dim.t_fact_fraud_detection_by_cash_register_event AS f
    JOIN ldl_data_production_core_dim.t_dim_internal_organization AS io
        ON f.store_sid = io.int_org_sid
       AND io.dwh_valid_fg = TRUE
    WHERE
    -- receipt has the flag for scenario
        f.deposit_same_ean_fg = TRUE
    -- but scenario is disabled in the Country
        AND io.country_org_cd IN (
            SELECT DISTINCT country_org_cd
            FROM mat_params
            WHERE is_scenario_enabled_in_country_fg = TRUE
        )
),
-- Combine the receipts where the flag needs to be cleaned and set.
-- Final flag value is calculated later using the Max aggregation.
union_new_old AS (
    SELECT
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
        deposit_same_ean_fg
    FROM qualify_single_row
    UNION ALL
    SELECT
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
        deposit_same_ean_fg
    FROM clean_old_flags
)
SELECT
    cash_register_event_sid,
    ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr,
    ANY_VALUE(event_start_tmsp) AS event_start_tmsp,
    ANY_VALUE(bus_dt) AS bus_dt,
    ANY_VALUE(cash_register_sid) AS cash_register_sid,
    ANY_VALUE(cash_register_nr) AS cash_register_nr,
    ANY_VALUE(store_sid) AS store_sid,
    ANY_VALUE(cashier_hash) AS cashier_hash,
    ANY_VALUE(txn_net_val) AS txn_net_val,
    ANY_VALUE(txn_gross_val) AS txn_gross_val,
    ANY_VALUE(curr_cd) AS curr_cd,
    MAX(deposit_same_ean_fg) AS deposit_same_ean_fg
FROM union_new_old
GROUP BY cash_register_event_sid;
