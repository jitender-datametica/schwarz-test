/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung - DWH / MIS
#----------------------------------------------------------------------------
# Script: ldl_fact_fraud_detection_return_at_price_higher_than_orig.sql
#----------------------------------------------------------------------------
# History:
#  1.0  13.09.2024  Kamil Roszczyk   - ZKP GF - script for scenario 'Return at higher price than original'
						https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/33394/
#  1.1	23.09.2024	Kamil Roszczyk   - Performance optimization, single SQL split into temp tables
#  1.2	24.11.2024	Kamil Roszczyk   - adding the logic for the new flag: return_at_higher_than_official_price_fg
                                           US: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/57645
#  1.3  07.03.2025  Kamil Roszczyk   - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63648
										- adjusted the code for extracting the Wawi price
										- replaced prod_variant_sid with local_prod_nr in all places
										- removed condition for lack of original receipt in return_at_higher_than_official_price_fg logic (for this scenario return receipts either with or without original receipt can be qualified)
#  1.4  18.03.2025  Kamil Roszczyk   - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/67104
										- restored filter for return_at_higher_than_official_price_fg to look only for return receipts without original receipts
										
#  1.5  27.03.2025  Mihail Ivanov  - Changes:
						- added logic to set the flag only in scenaio is enabled in a country (and remove the flag if scenario is disabled)
							https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/63803
						- removed columns that were only relevant for "storno" scenarios
#  1.6  01.04.2024  Kamil Roszczyk   - bugfixing: https://dev.azure.com/schwarzit-wiking/schwarzit.cdwh-greenfield-co-INTEGER /_workitems/edit/67104
										- modified the filter for return_at_higher_than_official_price_fg - qualify only return receipts without any original receipt (previous fix could qualify returns that could also fall into return_not_on_orig_fg - such receipts are also excluded now)

#  1.7  03.04.2025  Mihail Ivanov  - Changes:
						Removing flag if scenario is disabled is moved out of this script to the main script
*/


CREATE OR REPLACE TEMPORARY TABLE t_tmp_return_lines AS WITH return_receipts AS (SELECT tre.retail_event_sid,
   tre.cash_register_event_nr,
   tre.event_start_tmsp,
   tre.bus_dt,
   tre.cash_register_sid,
   tre.cashier_hash,
   tre.store_sid,
   tre.country_org_cd,
   tre.country_org_sid,
   tre.txn_net_val,
   tre.txn_gross_val
  FROM ${fwrk_work_db}.vt1
   INNER JOIN ldl_data_production_core_rel.t_retail_event AS tre ON vt1.loc_sid = tre.store_sid AND vt1.country_cd = tre
      .country_org_cd AND vt1.dwh_cal_dt = tre.bus_dt
  WHERE tre.retail_event_type_cd = 'R'
   AND tre.turnover_relevant_fg), materialize_param_view AS (SELECT param_id,
   scenario_id,
   scenario_type_cd,
   param_name,
   country_org_cd,
   param_default_val_qty,
   param_country_val_qty,
   param_val_qty,
   param_last_update_tmsp,
   is_scenario_enabled_in_country_fg
  FROM ldl_data_production_core_app_fraud_detection.v_fraud_detection_parameter_current_value
  WHERE scenario_id = 11), return_receipt_lines AS (SELECT tprl.retail_event_sid,
   tprl.local_prod_nr,
   tprl.orig_sales_event_sid,
   ANY_VALUE(tprl.store_sid) AS store_sid,
   ANY_VALUE(tprl.country_org_cd) AS country_org_cd,
   ANY_VALUE(tprl.curr_cd) AS curr_cd,
   ANY_VALUE(CONCAT(tprl.country_org_cd, '|', tprl.local_prod_nr)) AS prod_variant_nat_key_nr,
   -- there can be multiple different local_prod_nr values for the same prod_variant_sid within a country but the price will remain the same for them; implementation rule copied from old ZKP
   MAX(tprl.retail_line_gross_val / COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty)) AS adjusted_unit_price
  FROM ${fwrk_work_db}.vt1 AS vt10
   INNER JOIN ldl_data_production_core_rel.t_product_retail_line AS tprl ON vt10.loc_sid = tprl.store_sid AND vt10.country_cd
       = tprl.country_org_cd AND vt10.dwh_cal_dt = tprl.bus_dt
   INNER JOIN materialize_param_view AS p_arp ON tprl.country_org_cd = p_arp.country_org_cd AND p_arp.param_id = 32
      -- if scneario is not enabled all receipts from that country will be eliminated in the inner join
 AND p_arp.is_scenario_enabled_in_country_fg
    
  WHERE tprl.turnover_relevant_fg
   AND COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty) <> 0
   AND tprl.retail_line_gross_val / COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty) >= p_arp.param_val_qty
  GROUP BY tprl.retail_event_sid,
   tprl.local_prod_nr,
   tprl.orig_sales_event_sid) (

  SELECT rr.retail_event_sid,
   rr.cash_register_event_nr,
   rr.event_start_tmsp,
   rr.bus_dt,
   rr.cash_register_sid,
   rr.cashier_hash,
   rr.store_sid,
   rr.country_org_cd,
   rr.country_org_sid,
   rr.txn_net_val,
   rr.txn_gross_val,
   rrl.local_prod_nr,
   rrl.prod_variant_nat_key_nr,
   rrl.adjusted_unit_price,
   rrl.curr_cd,
   rrl.orig_sales_event_sid
  FROM return_receipts AS rr
   INNER JOIN return_receipt_lines AS rrl ON rr.retail_event_sid = rrl.retail_event_sid AND rr.store_sid = rrl.store_sid
       AND rr.country_org_cd = rrl.country_org_cd);


CREATE OR REPLACE TEMPORARY TABLE t_tmp_orig_receipts AS
SELECT tre.retail_event_sid,
 tre.bus_dt,
 tre.store_sid,
 tre.country_org_cd
FROM (SELECT DISTINCT orig_sales_event_sid
  FROM t_tmp_return_lines AS ttrl
  WHERE orig_sales_event_sid IS NOT NULL) AS ret_lines
 INNER JOIN ldl_data_production_core_rel.t_retail_event AS tre ON ret_lines.orig_sales_event_sid = tre.retail_event_sid
  AND tre.retail_event_type_cd = 'S';


CREATE OR REPLACE TEMPORARY TABLE t_tmp_orig_receipt_lines AS
SELECT ttor.retail_event_sid,
 ANY_VALUE(ttor.bus_dt) AS bus_dt,
 ANY_VALUE(ttor.store_sid) AS store_sid,
 ANY_VALUE(ttor.country_org_cd) AS country_org_cd,
 tprl.local_prod_nr,
 MAX(tprl.retail_line_gross_val / COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty)) AS adjusted_unit_price
FROM t_tmp_orig_receipts AS ttor
 INNER JOIN ldl_data_production_core_rel.t_product_retail_line AS tprl ON ttor.retail_event_sid = tprl.retail_event_sid
    AND ttor.bus_dt = tprl.bus_dt AND ttor.store_sid = tprl.store_sid AND ttor.country_org_cd = tprl.country_org_cd
WHERE COALESCE(tprl.prod_variant_cnt, tprl.prod_variant_qty) <> 0
GROUP BY ttor.retail_event_sid,
 tprl.local_prod_nr;



 INSERT INTO
${fwrk_work_db}.t_fact_fraud_detection_by_cash_register_event_final (cashier_hash, txn_net_val,
 cash_register_event_nr, cash_register_sid, curr_cd, cash_register_nr, txn_gross_val, event_start_tmsp,
 cash_register_event_sid, bus_dt, store_sid, return_at_higher_than_official_price_fg,
 return_at_higher_than_sales_price_fg)
WITH wawi_item_variant_max_price AS (/* Preaggregate the prices on Wawi item variant level */
  SELECT wawi_item_variant_sid,
    MAX(sales_gross_price) AS max_sales_gross_price
   FROM ldl_data_production_core_rel.t_wawi_item_variant_sales_price
   GROUP BY wawi_item_variant_sid), wawi_item_max_price AS (/* Aggregate the prices on Wawi item level */
  SELECT ik.wawi_item_nat_key_nr,
    DATE(ik.dwh_valid_from_tmsp) AS dwh_valid_from_dt,
    DATE(ik.dwh_valid_to_tmsp) AS dwh_valid_to_dt,
    MAX(ivp.max_sales_gross_price) AS max_sales_gross_price
   FROM wawi_item_variant_max_price AS ivp
    INNER JOIN ldl_data_production_core_rel.t_wawi_item_variant AS iv ON ivp.wawi_item_variant_sid = iv.wawi_item_variant_sid
       AND iv.dwh_valid_fg
    INNER JOIN ldl_data_production_meta.t_wawi_item_key AS ik ON iv.wawi_item_sid = ik.wawi_item_sid AND ik.wawi_item_key_type_cd
        = 'WAWI' AND ik.dwh_valid_fg
   GROUP BY ik.wawi_item_nat_key_nr,
    dwh_valid_from_dt,
    dwh_valid_to_dt), calc_flags AS (SELECT rl.retail_event_sid AS cash_register_event_sid,
    rl.cash_register_event_nr,
    rl.event_start_tmsp,
    rl.bus_dt,
    rl.cash_register_sid,
    cr.cash_register_nr,
    rl.store_sid,
    rl.cashier_hash,
    rl.txn_net_val,
    rl.txn_gross_val,
    rl.curr_cd,
     CASE
     WHEN rl.adjusted_unit_price > orl.adjusted_unit_price AND rl.local_prod_nr = orl.local_prod_nr
     THEN 1
     ELSE 0
     END AS return_at_higher_than_sales_price_fg,
     CASE
     WHEN rl.adjusted_unit_price > wimp.max_sales_gross_price AND orl.retail_event_sid IS NULL
     THEN 1
     ELSE 0
     END AS return_at_higher_than_official_price_fg
   FROM t_tmp_return_lines AS rl
    INNER JOIN ldl_data_production_core_rel.t_cash_register AS cr ON rl.cash_register_sid = cr.cash_register_sid AND cr
     .dwh_valid_fg
    LEFT JOIN t_tmp_orig_receipt_lines AS orl ON rl.orig_sales_event_sid = orl.retail_event_sid
    LEFT JOIN wawi_item_max_price AS wimp ON rl.prod_variant_nat_key_nr = wimp.wawi_item_nat_key_nr AND rl.bus_dt
      BETWEEN wimp.dwh_valid_from_dt AND wimp.dwh_valid_to_dt
      -- filtering on dates as there can be a different product assigned to the same key through the time

   WHERE rl.adjusted_unit_price > orl.adjusted_unit_price AND rl.local_prod_nr = orl.local_prod_nr
   --return price higher than original price
    OR rl.adjusted_unit_price > wimp.max_sales_gross_price AND orl.retail_event_sid IS NULL) 
    --OR return price higher than the Wawi max price
    (SELECT ANY_VALUE(cashier_hash
     ) AS cashier_hash,
    ANY_VALUE(txn_net_val) AS txn_net_val,
    ANY_VALUE(cash_register_event_nr) AS cash_register_event_nr,
    ANY_VALUE(cash_register_sid) AS cash_register_sid,
    ANY_VALUE(curr_cd) AS curr_cd,
    CAST(ANY_VALUE(cash_register_nr) AS STRING) AS cash_register_nr,
    ANY_VALUE(txn_gross_val) AS txn_gross_val,
    ANY_VALUE(event_start_tmsp) AS event_start_tmsp,
    cash_register_event_sid,
    ANY_VALUE(bus_dt) AS bus_dt,
    ANY_VALUE(store_sid) AS store_sid,
     MAX(return_at_higher_than_official_price_fg) <> 0 AS return_at_higher_than_official_price_fg,
     MAX(return_at_higher_than_sales_price_fg) <> 0 AS return_at_higher_than_sales_price_fg
   FROM calc_flags
   GROUP BY cash_register_event_sid);