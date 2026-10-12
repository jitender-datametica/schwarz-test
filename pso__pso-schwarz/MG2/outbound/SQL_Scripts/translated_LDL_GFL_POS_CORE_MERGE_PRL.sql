



-- TF Table


CREATE OR REPLACE TABLE ${target_db}.${vt_tgt_target_table} AS
SELECT bus_dt,
 turnover_relevant_fg,
 price_entry_method_cd,
 prod_return_reason_sid,
 prod_retail_line_type_cd,
 cash_register_usg_type_cd,
 prod_variant_cnt,
 tax_pct,
 base_gross_val,
 event_start_tmsp,
 event_end_tmsp,
 real_estate_sid,
 prod_entry_method_cd,
 auth_by_hash,
 cash_register_type_cd,
 retail_line_vat_val,
 prod_variant_qty,
 store_sid,
 parent_line_seq,
 retail_line_gross_val,
 cashier_hash,
 orig_sales_event_sid,
 orig_sales_event_nr,
 retail_event_sid,
 geo_area_sid,
 cancel_line_seq,
 prod_variant_input_nr,
 curr_cd,
 cash_register_sid,
 discount_fg,
 weight_based_fg,
 prod_variant_input_nr_type_cd,
 uom_cd,
 displayed_prod_variant_name,
 country_org_sid,
 retail_event_end_tmsp,
 tax_class_cd,
 country_org_cd,
 dwh_node_cd,
 return_txt,
 retail_event_line_scenario_id,
 retail_line_net_val,
 retail_event_line_seq,
 cust_sid,
 prod_variant_sid,
 wawi_item_sid,
 unit_price,
 local_prod_nr
FROM ${target_db}.${tgt_target_table} AS src
EXCEPT DISTINCT
SELECT bus_dt,
 turnover_relevant_fg,
 price_entry_method_cd,
 prod_return_reason_sid,
 prod_retail_line_type_cd,
 cash_register_usg_type_cd,
 prod_variant_cnt,
 tax_pct,
 base_gross_val,
 event_start_tmsp,
 event_end_tmsp,
 real_estate_sid,
 prod_entry_method_cd,
 auth_by_hash,
 cash_register_type_cd,
 retail_line_vat_val,
 prod_variant_qty,
 store_sid,
 parent_line_seq,
 retail_line_gross_val,
 cashier_hash,
 orig_sales_event_sid,
 orig_sales_event_nr,
 retail_event_sid,
 geo_area_sid,
 cancel_line_seq,
 prod_variant_input_nr,
 curr_cd,
 cash_register_sid,
 discount_fg,
 weight_based_fg,
 prod_variant_input_nr_type_cd,
 uom_cd,
 displayed_prod_variant_name,
 country_org_sid,
 retail_event_end_tmsp,
 tax_class_cd,
 country_org_cd,
 dwh_node_cd,
 return_txt,
 retail_event_line_scenario_id,
 retail_line_net_val,
 retail_event_line_seq,
 cust_sid,
 prod_variant_sid,
 wawi_item_sid,
 unit_price,
 local_prod_nr
FROM ldl_data_production_core_rel.t_product_retail_line AS tgt
WHERE (country_org_cd, bus_dt) IN (SELECT (country_org_cd, bus_dt)
   FROM (SELECT DISTINCT country_org_cd,
       tgt.bus_dt AS bus_dt
     FROM ${temp_db}.${src2tgt_temp_table1}_${src_context_area}) AS t1);


MERGE INTO ldl_data_production_core_rel.t_product_retail_line AS tgt
USING ${target_db}.${vt_tgt_target_table} AS SRC
ON tgt.retail_event_sid = SRC.retail_event_sid AND tgt.retail_event_line_seq = SRC.retail_event_line_seq
WHEN MATCHED THEN UPDATE SET
 dwh_load_id = ROUND(CAST('${LOAD_ID}' AS BIGNUMERIC), 0),
 bus_dt = SRC.bus_dt,
 turnover_relevant_fg = SRC.turnover_relevant_fg,
 price_entry_method_cd = SRC.price_entry_method_cd,
 prod_return_reason_sid = SRC.prod_return_reason_sid,
 prod_retail_line_type_cd = SRC.prod_retail_line_type_cd,
 cash_register_usg_type_cd = SRC.cash_register_usg_type_cd,
 prod_variant_cnt = SRC.prod_variant_cnt,
 tax_pct = SRC.tax_pct,
 base_gross_val = SRC.base_gross_val,
 event_start_tmsp = SRC.event_start_tmsp,
 event_end_tmsp = SRC.event_end_tmsp,
 real_estate_sid = SRC.real_estate_sid,
 prod_entry_method_cd = SRC.prod_entry_method_cd,
 auth_by_hash = SRC.auth_by_hash,
 cash_register_type_cd = SRC.cash_register_type_cd,
 retail_line_vat_val = SRC.retail_line_vat_val,
 prod_variant_qty = SRC.prod_variant_qty,
 store_sid = SRC.store_sid,
 parent_line_seq = SRC.parent_line_seq,
 retail_line_gross_val = SRC.retail_line_gross_val,
 cashier_hash = SRC.cashier_hash,
 orig_sales_event_sid = SRC.orig_sales_event_sid,
 orig_sales_event_nr = SRC.orig_sales_event_nr,
 geo_area_sid = SRC.geo_area_sid,
 cancel_line_seq = SRC.cancel_line_seq,
 prod_variant_input_nr = SRC.prod_variant_input_nr,
 curr_cd = SRC.curr_cd,
 cash_register_sid = SRC.cash_register_sid,
 discount_fg = SRC.discount_fg,
 weight_based_fg = SRC.weight_based_fg,
 prod_variant_input_nr_type_cd = SRC.prod_variant_input_nr_type_cd,
 uom_cd = SRC.uom_cd,
 displayed_prod_variant_name = SRC.displayed_prod_variant_name,
 country_org_sid = SRC.country_org_sid,
 retail_event_end_tmsp = SRC.retail_event_end_tmsp,
 tax_class_cd = SRC.tax_class_cd,
 country_org_cd = SRC.country_org_cd,
 dwh_node_cd = SRC.dwh_node_cd,
 return_txt = SRC.return_txt,
 retail_event_line_scenario_id = SRC.retail_event_line_scenario_id,
 retail_line_net_val = SRC.retail_line_net_val,
 cust_sid = SRC.cust_sid,
 prod_variant_sid = SRC.prod_variant_sid,
 wawi_item_sid = SRC.wawi_item_sid,
 unit_price = SRC.unit_price,
 local_prod_nr = SRC.local_prod_nr,
 dwh_updated_tmsp = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT VALUES(SRC.retail_event_sid, SRC.retail_event_line_seq, SRC.event_start_tmsp, SRC.event_end_tmsp
 , SRC.bus_dt, SRC.retail_event_end_tmsp, SRC.store_sid, SRC.country_org_sid, SRC.country_org_cd, SRC.real_estate_sid,
 SRC.cash_register_sid, SRC.cash_register_type_cd, SRC.cash_register_usg_type_cd, SRC.cashier_hash, SRC.auth_by_hash,
 SRC.cust_sid, SRC.prod_retail_line_type_cd, SRC.retail_event_line_scenario_id, SRC.prod_variant_sid, SRC.wawi_item_sid
 , SRC.local_prod_nr, SRC.prod_variant_input_nr, SRC.prod_variant_input_nr_type_cd, SRC.displayed_prod_variant_name, SRC
 .weight_based_fg, SRC.prod_variant_cnt, SRC.prod_variant_qty, SRC.uom_cd, SRC.unit_price, SRC.base_gross_val, SRC.retail_line_gross_val
 , SRC.retail_line_net_val, SRC.retail_line_vat_val, SRC.tax_class_cd, SRC.geo_area_sid, SRC.tax_pct, SRC.curr_cd, SRC.turnover_relevant_fg
 , SRC.discount_fg, SRC.prod_entry_method_cd, SRC.price_entry_method_cd, SRC.prod_return_reason_sid, SRC.return_txt, SRC
 .orig_sales_event_sid, SRC.orig_sales_event_nr, SRC.parent_line_seq, SRC.cancel_line_seq, CURRENT_TIMESTAMP(),
 CURRENT_TIMESTAMP(), ROUND(CAST('${LOAD_ID}' AS BIGNUMERIC), 0), SRC.dwh_node_cd);


/*

Manually create the aggregation control records here, rther than the generated protocol sql.
We need to to do this because the generated protocol-sql uses the target table name specified in the pset
rather than product_retail_line, which is the actual target (loaded by the SQL above
*/


MERGE INTO ldl_data_production_etl_process.t_prcs_delta AS prcs_delta
USING (SELECT DISTINCT dwh_node_cd,
  country_org_cd AS country_cd,
  bus_dt AS dwh_cal_dt,
  COALESCE(store_sid, - 1) AS loc_sid,
   (SELECT dependency
   FROM ldl_data_production_etl_process.t_prcs_main
   WHERE dependency = 't_product_retail_line'
   GROUP BY dependency) AS dependency
 FROM ldl_data_production_etl.${src2tgt_temp_table2}_${src_context_area}
 WHERE error_fg = 0
  AND (SELECT dependency
   FROM ldl_data_production_etl_process.t_prcs_main
   WHERE dependency = 't_product_retail_line'
   GROUP BY dependency) IS NOT NULL
  AND country_org_cd IS NOT NULL
  AND bus_dt IS NOT NULL) AS POC
ON prcs_delta.dwh_node_cd = POC.dwh_node_cd AND prcs_delta.country_cd = POC.country_cd AND prcs_delta.dwh_cal_dt = POC.dwh_cal_dt
     AND prcs_delta.dependency = POC.dependency AND prcs_delta.loc_sid = POC.loc_sid
WHEN MATCHED THEN UPDATE SET
 load_tmsp = CURRENT_TIMESTAMP(),
 dwh_load_id = ROUND(CAST('${LOAD_ID}' AS BIGNUMERIC), 0)
WHEN NOT MATCHED THEN INSERT VALUES(POC.dependency, POC.dwh_node_cd, POC.country_cd, POC.dwh_cal_dt, POC.loc_sid,
 CURRENT_TIMESTAMP(), ROUND(CAST('${LOAD_ID}' AS BIGNUMERIC), 0));