/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_cash_register_receipt_print.sql
#----------------------------------------------------------------------------
# History:
# 1.0  12.09.2024  Piotr Kleysa    - ZKP - t_retail_receipt_print  - intial version
# 1.1  18.09.2024  Andrzej Wandtke - ZKP - set destination table to t_cash_register_print
# 1.2  22.10.2024  Andrzej Wandtke - ZKP - add delete part
# 1.3  27.11.2024  Andrzej Wandtke - ZKP - use table T_STORES_QUALIFIED, add price info, subtotals, technical events
# 1.4  29.11.2024  Andrzej Wandtke - ZKP - add condition ch.cashier_hash IS NOT NULL
# 1.5  05.12.2024  Mihail Ivanov   - ZKP - setting default value -1 to parent_line_seq, becasue it is not part of the PK
										 - Added code for Tax Lines (source core_rel.T_TAX_LINE)
										 - Added code to populate new column DISCOUNT_FG
										 - Added code to populate new column CASH_REGISTER_EVENT_SCENARIO_ID
										 - Replaced column DISPLAYED_PROD_VARIANT_NAME with PROD_NAME
# 1.6  29.01.2025  Andrzej Wandtke - ZKP - fixing duplicates issue: cte retail_events: only the original receipts from the last batch
# 1.7  13.02.2025  Kamil Roszczyk  - ZKP - added code for discount lines (source: core_rel.t_discount_line)
										 - https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63807
# 1.8  25.02.2025  Kamil Roszczyk  - ZKP - fixed retail_event_line_seq value in tech events subquery (changed from cash_register_event_nr to 1)
										 - https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/65149
										 
# 1.9  05.03.2025  Mihail Ivanov   - ZKP - bugfix: changed DELETE statement for print table.
											This way original purchases that were outside of the analysis period are also deleted
											if they are referenced by returns that are part of the analysis.
											
# 1.10  26.03.2025  Mihail Ivanov  - Changes: 
						- Using CASHIER_NR to determine receipts by same employee. This is necessary because sometimes we get two hashes for same Store+Day+CashierNR
						
						Requested here: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/67501
							- Added new columns with detail for Original Reciept (meaning the "purchase receipt" in case of "receipts for Returns")
							- column AUTH_BY_NR renamed to EVENT_AUTH_BY_NR. Added column LINE_AUTH_BY_NR - this way we can show approvers of headers and positions

# 1.11  02.04.2025  Mihail Ivanov  - Bugfix: 
						- Changed how original purchases are selected for the DELETE statement

# 1.12  28.04.2025  Kamil Roszczyk - bugfix:
						- renamed columns: txn_gross_val to tax_line_gross_val and txn_vat_val to tax_line_val
						- adjusted sourcing for both columns and set the values to null for the types of lines not being tax ones
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/68764

# 1.13  30.04.2025  Kamil Roszczyk - change:
						- added product name load for price information event lines
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/68624

							
# 1.14  12.05.2025  Mihail Ivanov - change:
						- added column FIRST_LINE_OF_EVENT_FG - applicable only for RetailEvents and only for ProductRetail Lines of such events. (hard-coded FALSE for other events/line types)
							TRUE only for the ProductRetail line of each event that has the lowest RETAIL_EVENT_LINE_SEQ
							requested here (point1): https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/69364 

# 1.15  14.05.2025  Mihail Ivanov - change:
						- column FIRST_LINE_OF_EVENT_FG hard-coded to TRUE for "Price Info" and "Technical" events
						- replaced value NULL with t_price_information_event.PROD_PRICE in column "UNIT_PRICE" for lines of PriceInfo events
						
# 1.16  20.08.2025  Mihail Ivanov  - Changes:
						- Add filter to exclude training receipts - as of this time TRAINING_FG is not correctly set in CORE_REL tables so we use retail_event_scenario_id
						  https://jira.schwarz/browse/NEOGFPL-71572	
						- Change logic how product name is taken for product retail lines
						  https://jira.schwarz/browse/NEOGFPL-71574

					  
# 1.17  16.10.2025  Mihail Ivanov  - bugfix:
						- make sure TMP_RELEVANT includes also other Returns, that are outside proofing period, but are related to Returns that are in the proofing period
						  https://jira.schwarz/browse/NEOGFPL-71657

# 1.18  27.10.2025  Andrzej Wandtke  - bugfix:
						- put local_prod_nr as local_prod_nr for price info lines
						  https://jira.schwarz/browse/NEOGFPL-71668
# 1.19  04.11.2025  Andrzej Wandtke  - bugfix:
						- put T_DIM_SALES_VARIANT.sales_variant_nr as local_prod_nr for price info lines
						  https://jira.schwarz/browse/NEOGFPL-71668
# 1.20  26.01.2026  Andrzej Wandtke  - change:
						- add column last_line_of_event_fg
						  https://jira.schwarz/browse/NEOGFPL-71667

*/

--!SET exit_on_error=True;
BEGIN
DECLARE sv_min_dt DATE;
DECLARE sv_max_dt DATE;
DECLARE nb_days_orig_receipt INT64;
SET sv_min_dt = (
  SELECT
      min(t_stores_qualified.bus_dt)
    from
      ldl_data_etl.t_stores_qualified 
);
SET sv_max_dt = (
  SELECT
      max(t_stores_qualified.bus_dt)
    from
      ldl_data_etl.t_stores_qualified
);
SET nb_days_orig_receipt = 360;

CREATE OR REPLACE TEMPORARY TABLE tmp_relevant AS WITH RETAIL_EVENTS AS (
   -- All the receipts from the proofing scope: needed for Bonumfeld
   SELECT RE.retail_event_sid AS cash_register_event_sid,
    RE.store_sid,
    RE.cash_register_sid,
    RE.cashier_hash,
    RE.bus_dt,
    RE.real_estate_sid,
    RE.event_end_tmsp AS event_tmsp
   FROM ldl_data_core_rel.t_retail_event AS RE
    INNER JOIN ldl_data_etl.t_stores_qualified AS SQ ON RE.store_sid = SQ.store_sid AND RE.bus_dt = SQ.bus_dt
   WHERE SQ.is_directly_ordered = 1 
    -- exclude training receipts
    AND RE.retail_event_scenario_id NOT IN (101, 151, 201, 251, 301, 351)
   UNION DISTINCT
   -- Add original (purchase) receipts for the predefined period before the start date of proofing period
   -- No join to ETL.T_STORES_QUALIFIED because original receipts can come from a store outside of proofing scope
   SELECT O_RE.retail_event_sid AS cash_register_event_sid,
    O_RE.store_sid,
    O_RE.cash_register_sid,
    O_RE.cashier_hash,
    O_RE.bus_dt,
    O_RE.real_estate_sid,
    O_RE.event_end_tmsp AS event_tmsp
   FROM ldl_data_etl.t_stores_qualified AS SQ
    INNER JOIN ldl_data_core_rel.t_retail_event AS Q_RE -- qualified retail events (returns - only they have original receipt)
    ON SQ.store_sid = Q_RE.store_sid AND SQ.bus_dt = Q_RE.bus_dt AND
      Q_RE.retail_event_type_cd = 'R'
    INNER JOIN ldl_data_core_app_fraud_detection.t_cash_register_event_relationship AS ER ON Q_RE.retail_event_sid = ER
      .cash_register_event_sid AND ER.cash_register_event_rel_type_cd IN ('ORIGINAL', 'RETURN_SAME_ORIGINAL')
    INNER JOIN ldl_data_core_rel.t_retail_event AS O_RE -- original purchases
    ON ER.rel_cash_register_event_sid = O_RE.retail_event_sid
   WHERE 
    -- exclude training receipts
    Q_RE.retail_event_scenario_id NOT IN (101, 151, 201, 251, 301, 351)
    AND O_RE.retail_event_scenario_id NOT IN (101, 151, 201, 251, 301, 351)
    -- will uncomment this only if performance requires it.
	--where re.bus_dt between dateadd(day, -1 * $NB_DAYS_ORIG_RECEIPT, $SV_MIN_DT) AND $SV_MAX_DT
    ), PRICE_INFO_EVENTS AS (SELECT PIE.price_info_event_sid
    AS cash_register_event_sid,
   PIE.store_sid,
   PIE.cash_register_sid,
   PIE.cashier_hash,
   PIE.bus_dt,
   PIE.real_estate_sid,
   PIE.event_tmsp
  FROM ldl_data_core_rel.t_price_information_event AS PIE
   INNER JOIN ldl_data_etl.t_stores_qualified AS SQ ON PIE.store_sid = SQ.store_sid AND PIE.bus_dt = SQ.bus_dt
  WHERE SQ.is_directly_ordered = 1), TECH_EVENTS AS (SELECT TCRE.tech_cash_register_event_sid AS cash_register_event_sid
   ,
   TCRE.store_sid,
   TCRE.cash_register_sid,
   TCRE.cashier_hash,
   TCRE.bus_dt,
   TCRE.real_estate_sid,
   TCRE.event_tmsp
  FROM ldl_data_core_rel.t_technical_cash_register_event AS TCRE
   INNER JOIN ldl_data_etl.t_stores_qualified AS SQ ON TCRE.store_sid = SQ.store_sid AND TCRE.bus_dt = SQ.bus_dt
  WHERE SQ.is_directly_ordered = 1), ALL_EVENTS AS (SELECT cash_register_event_sid,
    store_sid,
    cash_register_sid,
    cashier_hash,
    bus_dt,
    real_estate_sid,
    event_tmsp,
    'RE' AS event_type_cd
   FROM RETAIL_EVENTS AS re
   UNION ALL
   SELECT cash_register_event_sid,
    store_sid,
    cash_register_sid,
    cashier_hash,
    bus_dt,
    real_estate_sid,
    event_tmsp,
    'PIE' AS event_type_cd
   FROM PRICE_INFO_EVENTS AS pie
   UNION ALL
   SELECT cash_register_event_sid,
    store_sid,
    cash_register_sid,
    cashier_hash,
    bus_dt,
    real_estate_sid,
    event_tmsp,
    'TE' AS event_type_cd
   FROM TECH_EVENTS AS te) (
 SELECT ae.cash_register_event_sid
   ,
   ae.store_sid,
   ae.cash_register_sid,
   ae.cashier_hash,
   ae.bus_dt,
   ae.event_type_cd,
   ae.real_estate_sid,
   ae.event_tmsp,
   CE.cashier_nr,
   ROW_NUMBER() OVER (PARTITION BY ae.store_sid , ae.bus_dt, CE.cashier_nr ORDER BY ae.event_tmsp IS NULL
      , ae.event_tmsp) AS row_nr
  FROM ALL_EVENTS AS ae
   INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS CE ON ae.cashier_hash = CE.cashier_hash);


DELETE FROM ldl_data_core_app_fraud_detection.t_cash_register_print
WHERE cash_register_event_sid IN (SELECT cash_register_event_sid
  FROM tmp_relevant);


INSERT INTO ldl_data_core_app_fraud_detection.t_cash_register_print
(cash_register_event_sid, cash_register_event_nr, cashier_nr, cash_register_event_line_seq, event_auth_by_nr,
 line_auth_by_nr, parent_line_seq, first_line_of_event_fg, last_line_of_event_fg, cash_register_event_scenario_id,
 retail_event_line_scenario_id, event_start_tmsp, event_end_tmsp, event_line_start_tmsp, event_line_end_tmsp, bus_dt,
 store_sid, store_nr, country_org_cd, cash_register_nr, prod_retail_line_type_cd, prod_variant_sid, local_prod_nr,
 prod_variant_input_nr, prod_variant_input_nr_type_cd, prod_name, prod_entry_method_cd, price_entry_method_cd,
 paym_line_type_cd, paym_type_id, fraud_detection_relevant_fg, prod_return_reason_sid, return_txt,
 parent_retail_event_sid, discount_fg, unit_price, prod_variant_cnt, prod_variant_qty, base_gross_val,
 retail_line_gross_val, retail_line_vat_val, local_paym_val, tax_line_gross_val, tax_pct, tax_line_val,
 cash_register_event_seq, orig_country_org_cd, orig_store_nr, orig_bus_dt, orig_cash_register_nr,
 orig_cash_register_event_nr, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
WITH RECEIPTS AS (
   -- pick up the regular lines ( t_product_retail_line)
   SELECT FD.cash_register_event_sid,
     E.cash_register_event_nr,
     L.retail_event_line_seq,
     IFNULL(L.parent_line_seq, - 1) AS parent_line_seq,
     IF(L.retail_event_line_seq = (MIN(L.retail_event_line_seq) OVER (PARTITION BY FD.cash_register_event_sid
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), TRUE, FALSE) AS first_line_of_event_fg,
     IF(L.retail_event_line_seq = (MAX(L.retail_event_line_seq) OVER (PARTITION BY FD.cash_register_event_sid
           RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)), TRUE, FALSE) AS last_line_of_event_fg,
     E.retail_event_scenario_id AS cash_register_event_scenario_id,
     L.retail_event_line_scenario_id,
     E.event_start_tmsp,
     E.event_end_tmsp,
     L.event_start_tmsp AS event_line_start_tmsp,
     L.event_end_tmsp AS event_line_end_tmsp,
     L.bus_dt,
     L.store_sid,
     NULL AS store_nr,
     L.country_org_cd,
     L.cash_register_sid,
     NULL AS cash_register_nr,
     E.cashier_hash,
     E.auth_by_hash AS event_auth_by_hash,
     L.auth_by_hash AS line_auth_by_hash,
     L.prod_retail_line_type_cd,
     L.prod_variant_sid,
     L.local_prod_nr,
     L.prod_variant_input_nr,
     L.prod_variant_input_nr_type_cd,
     IFNULL(LOC_PROD.local_prod_name, PV.prod_name) AS prod_name,
     L.prod_entry_method_cd,
     L.price_entry_method_cd,
     CAST(NULL AS STRING) AS paym_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS paym_type_id,
     L.return_txt,
     L.unit_price,
     L.prod_return_reason_sid,
     L.prod_variant_cnt,
     L.prod_variant_qty,
     L.base_gross_val,
     L.retail_line_gross_val,
     L.retail_line_vat_val,
     CAST(NULL AS BIGNUMERIC) AS local_paym_val,
     L.tax_pct,
     CAST(NULL AS BIGNUMERIC) AS tax_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS tax_line_val,
     FD.row_nr,
     L.discount_fg,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, cast(SUBSTR(SUBSTR(SAFE_CAST(L.orig_sales_event_sid
           as STRING), 1, 39), 9, 2)as string) || cast(SUBSTR(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39), 11, 2)
        as string), NULL) AS orig_country_org_cd,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(L.orig_sales_event_sid AS STRING)
          , 1, 39), 13, 8) as BIGNUMERIC), 0), NULL) AS orig_store_nr,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, DATE(SUBSTR(SUBSTR(SAFE_CAST(L.orig_sales_event_sid
          as STRING), 1, 39), 1, 8)), NULL) AS orig_bus_dt,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(L.orig_sales_event_sid AS STRING)
          , 1, 39), 21, 4) as BIGNUMERIC), 0), NULL) AS orig_cash_register_nr,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(L.orig_sales_event_sid AS STRING)
          , 1, 39), 25) as BIGNUMERIC), 0), NULL) AS orig_cash_register_event_nr
    FROM tmp_relevant AS FD
     INNER JOIN ldl_data_core_rel.t_retail_event AS E ON FD.cash_register_event_sid = E.retail_event_sid AND FD.bus_dt =
         E.bus_dt AND FD.store_sid = E.store_sid AND FD.cashier_hash = E.cashier_hash
     INNER JOIN ldl_data_core_rel.t_product_retail_line AS L ON FD.cash_register_event_sid = L.retail_event_sid AND FD.bus_dt
          = L.bus_dt AND FD.store_sid = L.store_sid AND FD.cashier_hash = L.cashier_hash
     -- this is second (fall back) option for product name ( the international product name)
     LEFT JOIN ldl_data_core_dim.t_dim_sales_variant AS PV ON L.prod_variant_sid = PV.sales_variant_sid AND PV.dwh_valid_fg
     -- if we have local name in German for the product we always try to show it. It has higher priority (change 1.16)
     -- yes, German name even for receipts in France, Italy, Spain and so on... this is the requirement
     LEFT JOIN ldl_data_core_dim.t_dim_local_product AS LOC_PROD ON PV.prod_sid = LOC_PROD.prod_sid AND LOC_PROD.dwh_valid_fg
        AND LOC_PROD.country_org_cd = 'DE'
    WHERE FD.event_type_cd = 'RE'
    UNION ALL
    -- pick up the voided(storno) lines ( t_cancellation_line)
    SELECT FD.cash_register_event_sid,
     E.cash_register_event_nr,
     CL.retail_event_line_seq,
     L.retail_event_line_seq AS parent_line_seq,
     FALSE AS first_line_of_event_fg,
     FALSE AS last_line_of_event_fg,
     E.retail_event_scenario_id AS cash_register_event_scenario_id,
     CL.retail_event_line_scenario_id,
     E.event_start_tmsp,
     E.event_end_tmsp,
     CL.event_tmsp AS event_line_start_tmsp,
     CL.event_tmsp AS event_line_end_tmsp,
     CL.bus_dt,
     CL.store_sid,
     NULL AS store_nr,
     CL.country_org_cd,
     L.cash_register_sid,
     NULL AS cash_register_nr,
     E.cashier_hash,
     E.auth_by_hash AS event_auth_by_hash,
     CL.auth_by_hash AS line_auth_by_hash,
     L.prod_retail_line_type_cd,
     L.prod_variant_sid,
     L.local_prod_nr,
     L.prod_variant_input_nr,
     L.prod_variant_input_nr_type_cd,
     IFNULL(LOC_PROD.local_prod_name, PV.prod_name) AS prod_name,
     L.prod_entry_method_cd,
     L.price_entry_method_cd,
     CAST(NULL AS STRING) AS paym_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS paym_type_id,
     L.return_txt,
     L.unit_price,
     L.prod_return_reason_sid,
      L.prod_variant_cnt * - 1 AS prod_variant_cnt,
      L.prod_variant_qty * - 1 AS prod_variant_qty,
      L.base_gross_val * - 1 AS base_gross_val,
      L.retail_line_gross_val * - 1 AS retail_line_gross_val,
      L.retail_line_vat_val * - 1 AS retail_line_vat_val,
     CAST(NULL AS BIGNUMERIC) AS local_paym_val,
     L.tax_pct,
     CAST(NULL AS BIGNUMERIC) AS tax_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS tax_line_val,
     FD.row_nr,
     L.discount_fg,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, cast(SUBSTR(SUBSTR(SAFE_CAST(L.orig_sales_event_sid
           as STRING), 1, 39), 9, 2)as string) || cast(SUBSTR(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39), 11, 2)
        as string), NULL) AS orig_country_org_cd,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(L.orig_sales_event_sid AS STRING)
          , 1, 39), 13, 8) as BIGNUMERIC), 0), NULL) AS orig_store_nr,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, DATE(SUBSTR(SUBSTR(SAFE_CAST(L.orig_sales_event_sid
          as STRING), 1, 39), 1, 8)), NULL) AS orig_bus_dt,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(L.orig_sales_event_sid AS STRING)
          , 1, 39), 21, 4) as BIGNUMERIC), 0), NULL) AS orig_cash_register_nr,
     IF(LENGTH(SUBSTR(SAFE_CAST(L.orig_sales_event_sid as STRING), 1, 39)) = 34, ROUND(SAFE_CAST(SUBSTR(SUBSTR(CAST(L.orig_sales_event_sid AS STRING)
          , 1, 39), 25) as BIGNUMERIC), 0), NULL) AS orig_cash_register_event_nr
    FROM tmp_relevant AS FD
     INNER JOIN ldl_data_core_rel.t_retail_event AS E ON FD.cash_register_event_sid = E.retail_event_sid AND FD.bus_dt =
        E.bus_dt AND FD.store_sid = E.store_sid
     INNER JOIN ldl_data_core_rel.t_product_retail_line AS L ON FD.cash_register_event_sid = L.retail_event_sid AND FD.bus_dt
         = L.bus_dt AND FD.store_sid = L.store_sid
     INNER JOIN ldl_data_core_rel.t_cancellation_line AS CL ON FD.bus_dt = CL.bus_dt AND FD.cash_register_event_sid = CL
         .retail_event_sid AND L.cancel_line_seq = CL.retail_event_line_seq AND FD.store_sid = L.store_sid
     -- this is second (fall back) option for product name ( the international product name)
     LEFT JOIN ldl_data_core_dim.t_dim_sales_variant AS PV ON L.prod_variant_sid = PV.sales_variant_sid AND PV.dwh_valid_fg
     -- if we have local name in German for the product we always try to show it. It has higher priority (change 1.16)
     -- yes, German name even for receipts in France, Italy, Spain and so on... this is the requirement
     LEFT JOIN ldl_data_core_dim.t_dim_local_product AS LOC_PROD ON PV.prod_sid = LOC_PROD.prod_sid AND LOC_PROD.dwh_valid_fg
        AND LOC_PROD.country_org_cd = 'DE'
    WHERE FD.event_type_cd = 'RE'
    UNION ALL
    -- pick up the payment lines (t_payment_line)
    SELECT FD.cash_register_event_sid,
     E.cash_register_event_nr,
     PL.retail_event_line_seq,
     - 1 AS parent_line_seq,
     FALSE AS first_line_of_event_fg,
     FALSE AS last_line_of_event_fg,
     E.retail_event_scenario_id AS cash_register_event_scenario_id,
     PL.retail_event_line_scenario_id,
     E.event_start_tmsp,
     E.event_end_tmsp,
     PL.paym_start_tmsp AS event_line_start_tmsp,
     PL.paym_end_tmsp AS event_line_end_tmsp,
     PL.bus_dt,
     PL.store_sid,
     NULL AS store_nr,
     PL.country_org_cd,
     PL.cash_register_sid,
     NULL AS cash_register_nr,
     E.cashier_hash,
     E.auth_by_hash AS event_auth_by_hash,
     CAST(NULL AS STRING) AS line_auth_by_hash,
     CAST(NULL AS STRING) AS prod_retail_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_sid,
     CAST(NULL AS STRING) AS local_prod_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr_type_cd,
     CAST(NULL AS STRING) AS prod_name,
     CAST(NULL AS STRING) AS prod_entry_method_cd,
     CAST(NULL AS STRING) AS price_entry_method_cd,
     PL.paym_line_type_cd,
     PL.paym_type_id,
     CAST(NULL AS STRING) AS return_txt,
     CAST(NULL AS BIGNUMERIC) AS unit_price,
     CAST(NULL AS BIGNUMERIC) AS prod_return_reason_sid,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_cnt,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_qty,
     CAST(NULL AS BIGNUMERIC) AS base_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_vat_val,
     PL.local_paym_val,
     CAST(NULL AS BIGNUMERIC) AS tax_pct,
     CAST(NULL AS BIGNUMERIC) AS tax_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS tax_line_val,
     FD.row_nr,
     CAST(NULL AS BOOL) AS discount_fg,
     CAST(NULL AS STRING) AS orig_country_org_cd,
     CAST(NULL AS BIGNUMERIC) AS orig_store_nr,
     CAST(NULL AS DATE) AS orig_bus_dt,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_nr,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_event_nr
    FROM tmp_relevant AS FD
     INNER JOIN ldl_data_core_rel.t_retail_event AS E ON FD.cash_register_event_sid = E.retail_event_sid AND FD.bus_dt =
        E.bus_dt AND FD.store_sid = E.store_sid
     INNER JOIN ldl_data_core_rel.t_payment_line AS PL ON FD.cash_register_event_sid = PL.retail_event_sid AND FD.bus_dt
         = PL.bus_dt AND FD.store_sid = PL.store_sid
    WHERE FD.event_type_cd = 'RE'
    UNION ALL
    -- pick up the subtotals(t_subtotal_line)
    SELECT FD.cash_register_event_sid,
     E.cash_register_event_nr,
     ST.retail_event_line_seq,
     - 1 AS parent_line_seq,
     FALSE AS first_line_of_event_fg,
     FALSE AS last_line_of_event_fg,
     E.retail_event_scenario_id AS cash_register_event_scenario_id,
     850 AS retail_event_line_scenario_id,
     E.event_start_tmsp,
     E.event_end_tmsp,
     ST.event_tmsp AS event_line_start_tmsp,
     ST.event_tmsp AS event_line_end_tmsp,
     ST.bus_dt,
     ST.store_sid,
     NULL AS store_nr,
     ST.country_org_cd,
     ST.cash_register_sid,
     NULL AS cash_register_nr,
     ST.cashier_hash,
     E.auth_by_hash AS event_auth_by_hash,
     CAST(NULL AS STRING) AS line_auth_by_hash,
     CAST(NULL AS STRING) AS prod_retail_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_sid,
     CAST(NULL AS STRING) AS local_prod_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr_type_cd,
     CAST(NULL AS STRING) AS prod_name,
     CAST(NULL AS STRING) AS prod_entry_method_cd,
     CAST(NULL AS STRING) AS price_entry_method_cd,
     CAST(NULL AS STRING) AS paym_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS paym_type_id,
     CAST(NULL AS STRING) AS return_txt,
     CAST(NULL AS BIGNUMERIC) AS unit_price,
     CAST(NULL AS BIGNUMERIC) AS prod_return_reason_sid,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_cnt,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_qty,
     CAST(NULL AS BIGNUMERIC) AS base_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_vat_val,
     CAST(NULL AS BIGNUMERIC) AS local_paym_val,
     CAST(NULL AS BIGNUMERIC) AS tax_pct,
     CAST(NULL AS BIGNUMERIC) AS tax_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS tax_line_val,
     FD.row_nr,
     CAST(NULL AS BOOL) AS discount_fg,
     CAST(NULL AS STRING) AS orig_country_org_cd,
     CAST(NULL AS BIGNUMERIC) AS orig_store_nr,
     CAST(NULL AS DATE) AS orig_bus_dt,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_nr,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_event_nr
    FROM tmp_relevant AS FD
     INNER JOIN ldl_data_core_rel.t_retail_event AS E ON FD.cash_register_event_sid = E.retail_event_sid AND FD.bus_dt =
        E.bus_dt AND FD.store_sid = E.store_sid
     INNER JOIN ldl_data_core_rel.t_subtotal_line AS ST ON FD.cash_register_event_sid = ST.retail_event_sid AND FD.bus_dt
         = ST.bus_dt AND FD.store_sid = ST.store_sid
    WHERE FD.event_type_cd = 'RE'
    UNION ALL
    -- pick up the tax lines (t_tax_line)
    SELECT FD.cash_register_event_sid,
     E.cash_register_event_nr,
     TL.retail_event_line_seq,
     - 1 AS parent_line_seq,
     FALSE AS first_line_of_event_fg,
     FALSE AS last_line_of_event_fg,
     E.retail_event_scenario_id AS cash_register_event_scenario_id,
     855 AS retail_event_line_scenario_id,
     E.event_start_tmsp,
     E.event_end_tmsp,
     TL.event_tmsp AS event_line_start_tmsp,
     TL.event_tmsp AS event_line_end_tmsp,
     TL.bus_dt,
     TL.store_sid,
     NULL AS store_nr,
     TL.country_org_cd,
     TL.cash_register_sid,
     NULL AS cash_register_nr,
     TL.cashier_hash,
     E.auth_by_hash AS event_auth_by_hash,
     CAST(NULL AS STRING) AS line_auth_by_hash,
     CAST(NULL AS STRING) AS prod_retail_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_sid,
     CAST(NULL AS STRING) AS local_prod_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr_type_cd,
     CAST(NULL AS STRING) AS prod_name,
     CAST(NULL AS STRING) AS prod_entry_method_cd,
     CAST(NULL AS STRING) AS price_entry_method_cd,
     CAST(NULL AS STRING) AS paym_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS paym_type_id,
     CAST(NULL AS STRING) AS return_txt,
     CAST(NULL AS BIGNUMERIC) AS unit_price,
     CAST(NULL AS BIGNUMERIC) AS prod_return_reason_sid,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_cnt,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_qty,
     CAST(NULL AS BIGNUMERIC) AS base_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_vat_val,
     CAST(NULL AS BIGNUMERIC) AS local_paym_val,
     TL.tax_pct,
     TL.gross_val AS tax_line_gross_val,
     TL.tax_val AS tax_line_val,
     FD.row_nr,
     CAST(NULL AS BOOL) AS discount_fg,
     CAST(NULL AS STRING) AS orig_country_org_cd,
     CAST(NULL AS BIGNUMERIC) AS orig_store_nr,
     CAST(NULL AS DATE) AS orig_bus_dt,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_nr,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_event_nr
    FROM tmp_relevant AS FD
     INNER JOIN ldl_data_core_rel.t_retail_event AS E ON FD.cash_register_event_sid = E.retail_event_sid AND FD.bus_dt =
        E.bus_dt AND FD.store_sid = E.store_sid
     INNER JOIN ldl_data_core_rel.t_tax_line AS TL ON FD.cash_register_event_sid = TL.retail_event_sid AND FD.bus_dt =
        TL.bus_dt AND FD.store_sid = TL.store_sid
    WHERE FD.event_type_cd = 'RE'
    UNION ALL
    -- pick up the discount lines (t_discount_line)
    SELECT FD.cash_register_event_sid,
     E.cash_register_event_nr,
     DL.retail_event_line_seq,
     DL.discounted_line_seq AS parent_line_seq,
     FALSE AS first_line_of_event_fg,
     FALSE AS last_line_of_event_fg,
     E.retail_event_scenario_id AS cash_register_event_scenario_id,
     DL.retail_event_line_scenario_id,
     E.event_start_tmsp,
     E.event_end_tmsp,
     DL.event_tmsp AS event_line_start_tmsp,
     DL.event_tmsp AS event_line_end_tmsp,
     DL.bus_dt,
     DL.store_sid,
     NULL AS store_nr,
     DL.country_org_cd,
     DL.cash_register_sid,
     NULL AS cash_register_nr,
     DL.cashier_hash,
     E.auth_by_hash AS event_auth_by_hash,
     DL.auth_by_hash AS line_auth_by_hash,
     CAST(NULL AS STRING) AS prod_retail_line_type_cd,
     DL.prod_variant_sid,
     CAST(NULL AS STRING) AS local_prod_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr_type_cd,
     CAST(NULL AS STRING) AS prod_name,
     CAST(NULL AS STRING) AS prod_entry_method_cd,
     CAST(NULL AS STRING) AS price_entry_method_cd,
     CAST(NULL AS STRING) AS paym_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS paym_type_id,
     CAST(NULL AS STRING) AS return_txt,
     CAST(NULL AS BIGNUMERIC) AS unit_price,
     CAST(NULL AS BIGNUMERIC) AS prod_return_reason_sid,
     DL.discounted_cnt AS prod_variant_cnt,
     DL.discounted_qty AS prod_variant_qty,
     CAST(NULL AS BIGNUMERIC) AS base_gross_val,
     DL.discount_val AS retail_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_vat_val,
     CAST(NULL AS BIGNUMERIC) AS local_paym_val,
     CAST(NULL AS BIGNUMERIC) AS tax_pct,
     CAST(NULL AS BIGNUMERIC) AS tax_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS tax_line_val,
     FD.row_nr,
     CAST(NULL AS BOOL) AS discount_fg,
     CAST(NULL AS STRING) AS orig_country_org_cd,
     CAST(NULL AS BIGNUMERIC) AS orig_store_nr,
     CAST(NULL AS DATE) AS orig_bus_dt,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_nr,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_event_nr
    FROM tmp_relevant AS FD
     INNER JOIN ldl_data_core_rel.t_retail_event AS E ON FD.cash_register_event_sid = E.retail_event_sid AND FD.bus_dt =
        E.bus_dt AND FD.store_sid = E.store_sid
     INNER JOIN ldl_data_core_rel.t_discount_line AS DL ON FD.cash_register_event_sid = DL.retail_event_sid AND FD.bus_dt
         = DL.bus_dt AND FD.store_sid = DL.store_sid
    WHERE FD.event_type_cd = 'RE'
    UNION ALL
    -- pick up the technical events
    SELECT FD.cash_register_event_sid,
     TC.cash_register_event_nr,
     1 AS retail_event_line_seq,
     - 1 AS parent_line_seq,
     TRUE AS first_line_of_event_fg,
     TRUE AS last_line_of_event_fg,
     ROUND(CAST(TC.tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS cash_register_event_scenario_id,
     ROUND(CAST(TC.tech_cash_register_event_type_cd AS BIGNUMERIC), 0) AS retail_event_line_scenario_id,
     TC.event_tmsp AS event_start_tmsp,
     TC.event_tmsp AS event_end_tmsp,
     TC.event_tmsp AS event_line_start_tmsp,
     TC.event_tmsp AS event_line_end_tmsp,
     TC.bus_dt,
     TC.store_sid,
     NULL AS store_nr,
     TC.country_org_cd,
     TC.cash_register_sid,
     NULL AS cash_register_nr,
     TC.cashier_hash,
     CAST(NULL AS STRING) AS event_auth_by_hash,
     CAST(NULL AS STRING) AS line_auth_by_hash,
     CAST(NULL AS STRING) AS prod_retail_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_sid,
     CAST(NULL AS STRING) AS local_prod_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr_type_cd,
     CAST(NULL AS STRING) AS prod_name,
     CAST(NULL AS STRING) AS prod_entry_method_cd,
     CAST(NULL AS STRING) AS price_entry_method_cd,
     CAST(NULL AS STRING) AS paym_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS paym_type_id,
     CAST(NULL AS STRING) AS return_txt,
     CAST(NULL AS BIGNUMERIC) AS unit_price,
     CAST(NULL AS BIGNUMERIC) AS prod_return_reason_sid,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_cnt,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_qty,
     CAST(NULL AS BIGNUMERIC) AS base_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_vat_val,
     CAST(NULL AS BIGNUMERIC) AS local_paym_val,
     CAST(NULL AS BIGNUMERIC) AS tax_pct,
     CAST(NULL AS BIGNUMERIC) AS tax_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS tax_line_val,
     FD.row_nr,
     CAST(NULL AS BOOL) AS discount_fg,
     CAST(NULL AS STRING) AS orig_country_org_cd,
     CAST(NULL AS BIGNUMERIC) AS orig_store_nr,
     CAST(NULL AS DATE) AS orig_bus_dt,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_nr,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_event_nr
    FROM tmp_relevant AS FD
     INNER JOIN ldl_data_core_rel.t_technical_cash_register_event AS TC ON FD.cash_register_event_sid = TC.tech_cash_register_event_sid
         AND FD.bus_dt = TC.bus_dt AND FD.store_sid = TC.store_sid
    UNION ALL
    -- pick up the price info lines
    SELECT FD.cash_register_event_sid,
     PR.cash_register_event_nr,
     1 AS retail_event_line_seq, -- price info is an independent event
     - 1 AS parent_line_seq,
     TRUE AS first_line_of_event_fg,
     TRUE AS last_line_of_event_fg,
     480 AS cash_register_event_scenario_id,
     480 AS retail_event_line_scenario_id,
     PR.event_tmsp AS event_start_tmsp,
     PR.event_tmsp AS event_end_tmsp,
     PR.event_tmsp AS event_line_start_tmsp,
     PR.event_tmsp AS event_line_end_tmsp,
     PR.bus_dt,
     PR.store_sid,
     NULL AS store_nr,
     PR.country_org_cd,
     PR.cash_register_sid,
     NULL AS cash_register_nr,
     PR.cashier_hash,
     CAST(NULL AS STRING) AS event_auth_by_hash,
     CAST(NULL AS STRING) AS line_auth_by_hash,
     CAST(NULL AS STRING) AS prod_retail_line_type_cd,
     PR.prod_variant_sid AS prod_variant_sid,
     PV.sales_variant_nr AS local_prod_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr,
     CAST(NULL AS STRING) AS prod_variant_input_nr_type_cd,
     IFNULL(LOC_PROD.local_prod_name, PV.prod_name) AS prod_name,
     CAST(NULL AS STRING) AS prod_entry_method_cd,
     CAST(NULL AS STRING) AS price_entry_method_cd,
     CAST(NULL AS STRING) AS paym_line_type_cd,
     CAST(NULL AS BIGNUMERIC) AS paym_type_id,
     CAST(NULL AS STRING) AS return_txt,
     PR.prod_price AS unit_price,
     CAST(NULL AS BIGNUMERIC) AS prod_return_reason_sid,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_cnt,
     CAST(NULL AS BIGNUMERIC) AS prod_variant_qty,
     CAST(NULL AS BIGNUMERIC) AS base_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS retail_line_vat_val,
     CAST(NULL AS BIGNUMERIC) AS local_paym_val,
     CAST(NULL AS BIGNUMERIC) AS tax_pct,
     CAST(NULL AS BIGNUMERIC) AS tax_line_gross_val,
     CAST(NULL AS BIGNUMERIC) AS tax_line_val,
     FD.row_nr,
     CAST(NULL AS BOOL) AS discount_fg,
     CAST(NULL AS STRING) AS orig_country_org_cd,
     CAST(NULL AS BIGNUMERIC) AS orig_store_nr,
     CAST(NULL AS DATE) AS orig_bus_dt,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_nr,
     CAST(NULL AS BIGNUMERIC) AS orig_cash_register_event_nr
    FROM tmp_relevant AS FD
     INNER JOIN ldl_data_core_rel.t_price_information_event AS PR ON FD.cash_register_event_sid = PR.price_info_event_sid
         AND FD.bus_dt = PR.bus_dt AND FD.store_sid = PR.store_sid
     -- this is second (fall back) option for product name ( the international product name)
     LEFT JOIN ldl_data_core_dim.t_dim_sales_variant AS PV ON PR.prod_variant_sid = PV.sales_variant_sid AND PV.dwh_valid_fg
     -- if we have local name in German for the product we always try to show it. It has higher priority (change 1.16)
     -- yes, German name even for receipts in France, Italy, Spain and so on... this is the requirement
     LEFT JOIN ldl_data_core_dim.t_dim_local_product AS LOC_PROD ON PV.prod_sid = LOC_PROD.prod_sid AND LOC_PROD.dwh_valid_fg
        AND LOC_PROD.country_org_cd = 'DE'
    WHERE FD.event_type_cd = 'PIE') (SELECT fd.cash_register_event_sid,
    SUBSTR(CAST(fd.cash_register_event_nr AS STRING), 1, 20) AS cash_register_event_nr,
    CH.cashier_nr,
    fd.retail_event_line_seq,
    E_AH.cashier_nr AS event_auth_by_nr,
    L_AH.cashier_nr AS line_auth_by_nr,
    fd.parent_line_seq,
    fd.first_line_of_event_fg,
    fd.last_line_of_event_fg,
    fd.cash_register_event_scenario_id,
    fd.retail_event_line_scenario_id,
    fd.event_start_tmsp,
    fd.event_end_tmsp,
    fd.event_line_start_tmsp,
    fd.event_line_end_tmsp,
    fd.bus_dt,
    fd.store_sid,
    O.curr_int_org_nr AS store_nr,
    fd.country_org_cd,
    RIK.resource_item_nat_key_nr AS cash_register_nr,
    fd.prod_retail_line_type_cd,
    fd.prod_variant_sid,
    fd.local_prod_nr,
    fd.prod_variant_input_nr,
    fd.prod_variant_input_nr_type_cd,
    fd.prod_name,
    fd.prod_entry_method_cd,
    fd.price_entry_method_cd,
    fd.paym_line_type_cd,
    fd.paym_type_id,
      CASE
      WHEN S.cash_register_event_sid IS NOT NULL
      THEN 1
      ELSE 0
      END <> 0 AS fraud_detection_relevant_fg,
    fd.prod_return_reason_sid,
    fd.return_txt,
    NULL AS parent_retail_event_sid,
    fd.discount_fg,
    fd.unit_price,
    fd.prod_variant_cnt,
    fd.prod_variant_qty,
    fd.base_gross_val,
    fd.retail_line_gross_val,
    fd.retail_line_vat_val,
    fd.local_paym_val,
    fd.tax_line_gross_val,
    fd.tax_pct,
    fd.tax_line_val,
    fd.row_nr,
    fd.orig_country_org_cd,
    SUBSTR(CAST(fd.orig_store_nr AS STRING), 1, 20) AS orig_store_nr,
    fd.orig_bus_dt,
    fd.orig_cash_register_nr,
    fd.orig_cash_register_event_nr,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    ${LOAD_ID} AS dwh_load_id, 
    'MANUAL' AS dwh_node_cd
   FROM RECEIPTS AS fd
    -- we want only rows with existing ch.cashier_hash, -- needed to handle data quality problems
    INNER JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS CH ON fd.cashier_hash = CH.cashier_hash
    LEFT JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS E_AH ON fd.event_auth_by_hash = E_AH.cashier_hash
     
    LEFT JOIN ldl_data_core_app_fraud_detection.t_cashier_encryption AS L_AH ON fd.line_auth_by_hash = L_AH.cashier_hash
     
    LEFT JOIN ldl_data_core_dim.t_dim_internal_organization AS O ON fd.store_sid = O.int_org_sid AND O.dwh_valid_fg AND
      O.int_org_type_cd = 'STORE'
    LEFT JOIN ldl_data_meta.t_resource_item_key AS RIK ON fd.cash_register_sid = RIK.resource_item_sid AND RIK.dwh_valid_fg
       AND RIK.resource_item_key_type_cd = 'REG'
    LEFT JOIN ldl_data_core_dim.t_fact_fraud_detection_by_cash_register_event AS S ON fd.cash_register_event_sid = S.cash_register_event_sid
     );

END;