CREATE OR REPLACE TABLE vt_$_1{src2tgt_temp_table1}_${src_context_area}_process AS
SELECT *
FROM ldl_data_production_$_1{temp_db}.t_${src_input_table} src
;

-- PRODUCT_VARIANT_SID Notes:
--
-- Mapping specifies that
-- - A SID should be assigned from SLS_GTIN where the item_1 number and barcode has been assigned a SID already in the keyspace
--         - Otherwise a SLS_UNK SID should be assigned from the country_1 and item_1 number has ben assigned already
--                 - Otherwise create a SLS_UNK SID and assign that number for the country_1 & Item_1 Number.
--
-- The previous process has assigned aN SLS_GTIN SID if one was present, otherwise this process will see -1
-- So for -1 SIDs perform the keyspace ASSIGN_WHEN_PRESENT-ELSE-INSERT-AND-ASSIGN routine here in the transform itself

BEGIN TRANSACTION;

DELETE FROM ldl_data_production_meta.t_product_variant_key_1
WHERE 1 = 2;

-- Create new SK entries for every new NK/TYPE/VALID_FROM_TMSP Combination

INSERT INTO ldl_data_production_meta.t_product_variant_key_1
(
  prod_variant_sid,
  prod_variant_key_type_cd,
  prod_variant_nat_key_nr,
  dwh_created_tmsp,
  dwh_updated_tmsp,
  dwh_valid_from_tmsp,
  dwh_valid_to_tmsp,
  dwh_valid_fg,
  dwh_node_cd,
  dwh_load_id
)
WITH new_keys AS (
  SELECT
    max_seq.max_seq + ROW_NUMBER() OVER (ORDER BY 1) AS prod_variant_sid,
    'SLS_UNK' AS prod_variant_key_type_cd,
    UPPER(t1.context_country || '|' || t1.orig_item_nr) AS natural_key,
    CURRENT_TIMESTAMP() AS dwh_created_tmsp,
    CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
    CURRENT_TIMESTAMP() AS dwh_valid_from_tmsp,
    TIMESTAMP('9999-12-31 23:59:59') AS dwh_valid_to_tmsp,
    TRUE AS dwh_valid_fg,
    t1.dwh_node_cd AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
  FROM (
    SELECT DISTINCT
      'EJR' AS dwh_node_cd,
      UPPER(context_country) AS context_country,
      orig_item_nr
    FROM vt_$_1{src2tgt_temp_table1}_${src_context_area}_process
    WHERE prod_variant_sidx = '-1'    -- We only want to create SIDs where not previously assigned (-1) and not present              
  ) AS t1_1
  CROSS JOIN (
    SELECT COALESCE(MAX(prod_variant_sid), 0) AS max_seq
    FROM ldl_data_production_meta.t_product_variant_key_1
  ) AS max_seq
  WHERE natural_key IS NOT NULL
    AND NOT EXISTS (
      SELECT 1
      FROM ldl_data_production_meta.t_product_variant_key_1 t2
      WHERE UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK'
        AND CURRENT_TIMESTAMP() BETWEEN t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp       -- Accomodates historized SID association (full capability not implemented in initial release)
        AND UPPER(t2.prod_variant_nat_key_nr) = UPPER(t1.context_country || '|' || t1.orig_item_nr)
    )
)
SELECT * FROM new_keys
;

COMMIT TRANSACTION;

INSERT INTO ldl_data_production_$_1{temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
  retail_event_sid,
  retail_event_line_seq,
  event_start_tmsp,
  event_end_tmsp,
  bus_dt,
  retail_event_end_tmsp,
  store_sid,
  country_org_sid,
  country_org_cd,
  real_estate_sid,
  cash_register_sid,
  cash_register_type_cd,
  cash_register_usg_type_cd,
  cashier_nr,
  auth_by_nr,
  cust_sid,
  prod_retail_line_type_cd,
  retail_event_line_scenario_id,
  prod_variant_sid,
  local_prod_nr,
  prod_variant_input_nr,
  prod_variant_input_nr_type_cd,
  displayed_prod_variant_name,
  weight_based_fg,
  prod_variant_cnt,
  prod_variant_qty,
  uom_cd,
  unit_price,
  base_gross_val,
  retail_line_gross_val,
  retail_line_net_val,
  retail_line_vat_val,
  tax_class_cd,
  geo_area_sid,
  tax_pct,
  curr_cd,
  turnover_relevant_fg,
  discount_fg,
  prod_entry_method_cd,
  price_entry_method_cd,
  prod_return_reason_sid,
  return_txt,
  orig_sales_event_sid,
  parent_line_seq,
  cancel_line_seq,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
SELECT
  src.retail_event_sid,
  src.retail_event_line_seq,
  src.event_start_tmsp,
  src.event_end_tmsp,
  src.bus_dt,
  src.retail_event_end_tmsp,
  src.store_sid,
  src.country_org_sid,
  org.country_org_cd,
  src.real_estate_sid,
  src.cash_register_sid,
  src.cash_register_type_cd,
  src.cash_register_usg_type_cd,
  IF(
    src.bus_dt < DATE_SUB(CURRENT_DATE(), INTERVAL ${retention_period_cashier_nr} WEEK),
    -1,
    src.checker_id
  ) AS cashier_nr,
  IF(
    src.bus_dt < DATE_SUB(CURRENT_DATE(), INTERVAL ${retention_period_cashier_nr} WEEK),
    -1,
    src.receiptline_authority_id
  ) AS auth_by_nr,
  src.cust_sid,
  src.prod_retail_line_type_cd,
  src.retail_event_line_scenario_id,
  CASE
    WHEN src.prod_variant_sidx = '-1' 
    THEN pvk1.prod_variant_sid    -- See start of script ^^
    ELSE src.prod_variant_sidx    --SIDX would be populated where already present in SLS_GTIN Domain.
  END AS prod_variant_sid,
  src.local_prod_nr,
  src.prod_variant_input_nr,
  src.prod_variant_input_nr_type_cd,
  src.displayed_prod_variant_name,
  src.weight_based_fg,
  src.prod_variant_cnt,
  src.prod_variant_qty,
  src.uom_cd,
  src.unit_price,
  src.base_gross_val,
  src.retail_line_gross_val,
  src.retail_line_net_val,
  src.retail_line_vat_val,
  src.tax_class_cd,
  src.geo_area_sid,
  src.tax_pct,
  org.curr_cd,
  src.turnover_relevant_fg,
  CASE WHEN src.base_gross_val > src.retail_line_gross_val THEN TRUE ELSE FALSE END AS discount_fg,
  src.prod_entry_method_cd,
  src.price_entry_method_cd,
  src.prod_return_reason_sid,
  src.return_txt,
  src.orig_sales_event_sid,
  src.parent_line_seq,
  src.cancel_line_seq,
  'EJR' AS source_system,
  CURRENT_DATE() AS extraction_dt,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  't_${src_input_table}' AS filename,
  'EJR' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM vt_$_1{src2tgt_temp_table1}_${src_context_area}_process src
LEFT JOIN ldl_data_production_meta.t_product_variant_key_1 pvk1     -- NKC is ON, but we dont want to generate missing keys, so we access the keyspace directly here instead os fwork-based key assignment
  ON pvk1.prod_variant_key_type_cd = 'SLS_UNK'
 AND UPPER(src.context_country || '|' || src.orig_item_nr) = UPPER(pvk1.prod_variant_nat_key_nr)
 AND pvk1.dwh_valid_fg = TRUE
LEFT JOIN ldl_data_production_$_1{target_db}.t_internal_organization_1 org
  ON src.country_org_sid = org.int_org_sid
 AND src.bus_dt BETWEEN org.dwh_valid_from_tmsp AND org.dwh_valid_to_tmsp
;


-- Delete those records from source using the PK
DELETE FROM ldl_data_production_$_1{temp_db}.t_${src_input_table} src
WHERE EXISTS (
  SELECT 1
  FROM vt_$_1{src2tgt_temp_table1}_${src_context_area}_process process
  WHERE src.retail_event_sid = process.retail_event_sid
    AND src.retail_event_line_seq = process.retail_event_line_seq
)
;
