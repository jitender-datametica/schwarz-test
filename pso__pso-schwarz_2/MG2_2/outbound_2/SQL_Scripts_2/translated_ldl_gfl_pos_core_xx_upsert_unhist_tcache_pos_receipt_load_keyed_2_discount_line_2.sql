CREATE OR REPLACE TEMPORARY TABLE ${src2tgt_temp_table1}_${src_context_area}_stage AS
SELECT UPPER(context_country || '|' || discount_nr) AS promo_nat_key_nr,
 retail_event_sid,
 posnr AS retail_event_line_seq,
 receiptline_timestamp_begin AS event_tmsp,
 receipt_business_date AS bus_dt,
 store_sid,
 country_org_sid,
 country_org_cd,
 real_estate_sid,
 cash_register_sid,
 pos_type AS cash_register_type_cd,
 NULL AS cash_register_usg_type_cd,
 checker_hash AS cashier_hash,
 receiptline_authority_hash AS auth_by_hash,
 cust_sid,
 receiptline_transactiontype_id AS retail_event_line_scenario_id,
  CASE
  WHEN fg_weight <> '1'
  THEN CASE
   WHEN CAST(receiptline_transactiontype_id AS INTEGER) BETWEEN 400 AND 599
   THEN qty_discount_pos
   WHEN CAST(receiptline_transactiontype_id AS INTEGER) BETWEEN 600 AND 799
   THEN qty_discount_hq
   ELSE NULL
   END
  ELSE NULL
  END AS discounted_cnt,
  CASE
  WHEN fg_weight = '1'
  THEN CASE
   WHEN CAST(receiptline_transactiontype_id AS INTEGER) BETWEEN 400 AND 599
   THEN qty_discount_pos
   WHEN CAST(receiptline_transactiontype_id AS INTEGER) BETWEEN 600 AND 799
   THEN qty_discount_hq
   ELSE NULL
   END
  ELSE NULL
  END AS discounted_qty,
  CASE
  WHEN fg_weight <> '1'
  THEN CASE
   WHEN context_country = 'US'
   THEN 'LB'
   ELSE 'KG'
   END
  ELSE NULL
  END AS uom_cd,
 val_discount_base AS discounted_val,
 val_discount AS discount_val,
 curr_cd,
 pct_discount AS discount_pct,
 item_desc AS discount_name,
 NULL AS discount_type_cd,
 NULL AS discount_reason_cd,
 NULL AS discount_calc_rule_cd,
 parent_line_nr AS discounted_line_seq,
 voided_by_line_nr AS cancel_line_seq,
  CASE
  WHEN CAST(receiptline_transactiontype_id AS INTEGER) BETWEEN 400 AND 599
  THEN 0  /* Discount Node */
  ELSE posnr /* PriceModifier Node */
  END AS discount_seq,
 'False' AS split_fg,
 context_country,
 orig_item_nr,
 barcode
FROM ${temp_db}.v_${src_input_table} AS src
WHERE receiptline_transactiontype_id IN ('401', '402', '441', '442', '470', '472', '480', '482', '501', '502', '570',
   '572', '580', '582', '199', '601', '602', '641', '642', '670', '672', '680', '682', '299', '701', '702', '770', '772'
   , '780', '782')
QUALIFY (ROW_NUMBER() OVER (PARTITION BY context_country, CAST(orig_store_nr AS STRING), CAST(pos_terminal_id AS STRING)
      , CAST(orig_receipt_nr AS STRING), receipt_business_date, CAST(parent_line_nr AS STRING), CAST(posnr AS STRING),
      receiptline_transactiontype_id, receiptline_timestamp_begin ORDER BY receipt_timestamp_end IS NULL DESC,
      receipt_timestamp_end DESC)) = 1;


BEGIN TRANSACTION;


DELETE FROM ldl_data_production_meta.t_promotion_key_2  -- Prevent any concurrent access to this keyspace
WHERE 1 = 2;


INSERT INTO ldl_data_production_meta.t_promotion_key_2 (promo_sid, promo_key_type_cd, dwh_valid_from_tmsp,
 dwh_valid_to_tmsp, dwh_valid_fg, promo_nat_key_nr, dwh_created_tmsp, dwh_updated_tmsp, dwh_load_id, dwh_node_cd)
(SELECT t3.max_seq + (ROW_NUMBER() OVER (ORDER BY 1 IS NULL, 1)) AS promo_sid,
  'STORE',
  CURRENT_TIMESTAMP(),
  CAST('9999-12-31 23:59:59' AS TIMESTAMP),
  TRUE,
  t1.promo_nat_key_nr,
  CURRENT_TIMESTAMP(),
  CURRENT_TIMESTAMP(),
  CAST('${LOAD_ID}' AS INTEGER),
  'EJR'
 FROM (SELECT DISTINCT promo_nat_key_nr
   FROM ${src2tgt_temp_table1}_${src_context_area}_stage) AS t1_2
  INNER JOIN (SELECT COALESCE(MAX(promo_sid), 0) AS max_seq
   FROM ldl_data_production_meta.t_promotion_key_2) AS t3 ON TRUE
 WHERE NOT EXISTS (SELECT 1
   FROM ldl_data_production_meta.t_promotion_key_2 AS t2
   WHERE UPPER(promo_key_type_cd) = 'STORE'
    AND CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp
    AND UPPER(promo_nat_key_nr) = UPPER(t1.promo_nat_key_nr))
  AND t1.promo_nat_key_nr IS NOT NULL);


COMMIT TRANSACTION;


BEGIN TRANSACTION;


DELETE FROM ldl_data_production_meta.t_product_variant_key_2
--Prevent any concurrent access to this keyspace
WHERE 1 = 2;


/* Old code 
INSERT INTO LDL_DATA_PRODUCTION.meta.t_product_variant_key_2 
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
(
SELECT  
        max_seq + row_number() over(order by 1) AS prod_variant_sid,
        'SLS_UNK',
        UPPER(t1.context_country || '|' || t1.orig_item_nr) AS natural_key,
        current_timestamp,
        current_timestamp,
        current_timestamp,
        '9999-12-31 23:59:59'
        ,TRUE
        ,t1.dwh_node_cd
        ,'${LOAD_ID}'       
FROM (SELECT t1.dwh_node_cd, context_country, orig_item_nr, barcode
        FROM (SELECT 'EJR' AS dwh_node_cd, UPPER(context_country) AS context_country, orig_item_nr, barcode 
              FROM LDL_DATA_PRODUCTION.${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}_stage t1_2
              ) t1_2              
        GROUP BY t1.dwh_node_cd, context_country, orig_item_nr, barcode) t1_2
        
CROSS JOIN (SELECT COALESCE(MAX(prod_variant_sid),0) AS max_seq FROM LDL_DATA_PRODUCTION.meta.t_product_variant_key_2) AS max_seq

WHERE 
natural_key IS NOT NULL 
AND NOT EXISTS
        (
         SELECT 1 FROM LDL_DATA_PRODUCTION.meta.t_product_variant_key_2 t2 
         WHERE
         UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK' AND
         current_timestamp between t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND -- Accomodates historized SID association (full capability not implemented in initial release)
         UPPER(t2.prod_variant_nat_key_nr) = UPPER(t1.context_country|| '|' || t1.orig_item_nr) 
        )     
AND NOT EXISTS
        (
         SELECT 1 FROM LDL_DATA_PRODUCTION.meta.t_product_variant_key_2 t2 
         WHERE
         UPPER(t2.prod_variant_key_type_cd) = 'SLS_GTIN' AND
         current_timestamp between t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND -- Accomodates historized SID association (full capability not implemented in initial release)
         UPPER(t2.prod_variant_nat_key_nr) = t1.orig_item_nr || '|' || t1.barcode 
        )     
) ;
*/

INSERT INTO ldl_data_production_meta.t_product_variant_key_2 (prod_variant_sid, prod_variant_key_type_cd,
 dwh_valid_from_tmsp, dwh_valid_to_tmsp, dwh_valid_fg, prod_variant_nat_key_nr, dwh_created_tmsp, dwh_updated_tmsp,
 dwh_load_id, dwh_node_cd)
(SELECT t12.max_seq + (ROW_NUMBER() OVER (ORDER BY UPPER(t1.context_country || '|' || CAST(t1.orig_item_nr AS STRING))
       IS NULL, UPPER(t1.context_country || '|' || CAST(t1.orig_item_nr AS STRING)))) AS prod_variant_sid,
  'SLS_UNK' AS prod_variant_key_type_cd,
  CURRENT_TIMESTAMP() AS dwh_valid_from_tmsp,
  CAST('9999-12-31 23:59:59.99999999' AS TIMESTAMP) AS dwh_valid_to_tmsp,
  TRUE AS dwh_valid_fg,
  UPPER(t1.context_country || '|' || CAST(t1.orig_item_nr AS STRING)) AS prod_variant_nat_key_nr,
  CURRENT_TIMESTAMP() AS dwh_created_tmsp,
  CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
  CAST('${LOAD_ID}' AS INTEGER) AS dwh_load_id,
  'EJR' AS dwh_node_cd
 FROM (/* Generate the new SIDs only for distinct {country_2, orig_item_nr} sets, without the barcode column */
 SELECT DISTINCT context_country,
    orig_item_nr
   FROM (/* Check the GTIN and Unknown key existence using the distinct {country_2, orig_item_nr, barcode} sets */
   SELECT DISTINCT UPPER(context_country) AS context_country,
      orig_item_nr,
      barcode
     FROM ${src2tgt_temp_table1}_${src_context_area}_stage AS t1_2) AS t1_2
   WHERE NOT EXISTS (SELECT 1
     FROM ldl_data_production_meta.t_product_variant_key_2 AS t2
     WHERE UPPER(prod_variant_key_type_cd) = 'SLS_UNK'
      AND CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp
      AND -- Accomodates historized SID association (full capability not implemented in initial release)
 UPPER(prod_variant_nat_key_nr
        ) = UPPER(t1.context_country || '|' || CAST(t1.orig_item_nr AS STRING)))
    AND NOT EXISTS (SELECT 1
     FROM ldl_data_production_meta.t_product_variant_key_2 AS t2
     WHERE UPPER(prod_variant_key_type_cd) = 'SLS_GTIN'
      AND CURRENT_TIMESTAMP() BETWEEN dwh_valid_from_tmsp AND dwh_valid_to_tmsp
      AND -- Accomodates historized SID association (full capability not implemented in initial release)
 UPPER(prod_variant_nat_key_nr
        ) = CAST(t1.orig_item_nr AS STRING) || '|' || t1.barcode)) AS t1_2
  INNER JOIN (SELECT COALESCE(MAX(prod_variant_sid), 0) AS max_seq
   FROM ldl_data_production_meta.t_product_variant_key_2) AS t12 ON TRUE
 WHERE UPPER(t1.context_country || '|' || CAST(t1.orig_item_nr AS STRING)) IS NOT NULL);


COMMIT TRANSACTION;


-- ****************
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_node_cd, tf_error_fg, dwh_load_id, source_system, extraction_dt, deleted_fg, record_id, dwh_mapping_tmsp, filename
 , cancel_line_seq, retail_event_line_scenario_id, uom_cd, bus_dt, cash_register_type_cd, retail_event_line_seq,
 cash_register_usg_type_cd, cust_sid, country_org_sid, prod_variant_sid, cash_register_sid, store_sid, retail_event_sid
 , real_estate_sid, country_org_cd, curr_cd, cashier_hash, event_tmsp, auth_by_hash, discounted_line_seq, promo_sid,
 discounted_qty, discount_type_cd, discounted_cnt, discount_name, discount_reason_cd, discounted_val,
 discount_calc_rule_cd, wawi_item_sid, discount_val, discount_pct, discount_seq, split_fg)
(SELECT 'EJR' AS dwh_node_cd,
  0 AS tf_error_fg,
  '${LOAD_ID}' AS dwh_load_id,
  -- ****************
 'EJR' AS source_system,
  CURRENT_DATE AS extraction_dt,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  'V_${SRC_INPUT_TABLE}' AS filename,
  t1.cancel_line_seq,
  t1.retail_event_line_scenario_id,
  t1.uom_cd,
  t1.bus_dt,
  t1.cash_register_type_cd,
  t1.retail_event_line_seq,
  CAST(t1.cash_register_usg_type_cd AS STRING) AS cash_register_usg_type_cd,
  t1.cust_sid,
  t1.country_org_sid,
  IFNULL(t3.prod_variant_sid, t2.prod_variant_sid) AS prod_variant_sid,
  t1.cash_register_sid,
  t1.store_sid,
  t1.retail_event_sid,
  t1.real_estate_sid,
  t1.country_org_cd,
  t1.curr_cd,
  t1.cashier_hash,
  CAST(t1.event_tmsp AS TIMESTAMP) AS event_tmsp,
  t1.auth_by_hash,
  t1.discounted_line_seq,
  p.promo_sid,
  t1.discounted_qty,
  CAST(t1.discount_type_cd AS STRING) AS discount_type_cd,
  t1.discounted_cnt,
  t1.discount_name,
  CAST(t1.discount_reason_cd AS STRING) AS discount_reason_cd,
  t1.discounted_val,
  CAST(t1.discount_calc_rule_cd AS STRING) AS discount_calc_rule_cd,
  COALESCE(wik.wawi_item_sid, - 1) AS wawi_item_sid,
  t1.discount_val,
  t1.discount_pct,
  t1.discount_seq,
   CASE
   WHEN LOWER(t1.split_fg) = 'true' OR LOWER(t1.split_fg) = 't' OR LOWER(t1.split_fg) = '1' OR LOWER(t1.split_fg) =
       'yes' OR LOWER(t1.split_fg) = 'y' OR LOWER(t1.split_fg) = 'on'
   THEN TRUE
   WHEN LOWER(t1.split_fg) = 'false' OR LOWER(t1.split_fg) = 'f' OR LOWER(t1.split_fg) = '0' OR LOWER(t1.split_fg) =
       'no' OR LOWER(t1.split_fg) = 'n' OR LOWER(t1.split_fg) = 'off'
   THEN FALSE
   ELSE CAST(t1.split_fg AS BOOL)
   END AS split_fg
 FROM ${src2tgt_temp_table1}_${src_context_area}_stage AS t1_2
  LEFT JOIN ldl_data_production_meta.t_product_variant_key_2 AS t2 ON UPPER(t2.prod_variant_key_type_cd) = 'SLS_UNK' AND
     CURRENT_TIMESTAMP() BETWEEN t2.dwh_valid_from_tmsp AND t2.dwh_valid_to_tmsp AND UPPER(t2.prod_variant_nat_key_nr) =
    UPPER(t1.context_country || '|' || CAST(t1.orig_item_nr AS STRING))
  LEFT JOIN ldl_data_production_meta.t_product_variant_key_2 AS t3 ON UPPER(t3.prod_variant_key_type_cd) = 'SLS_GTIN' AND
     CURRENT_TIMESTAMP() BETWEEN t3.dwh_valid_from_tmsp AND t3.dwh_valid_to_tmsp AND UPPER(t3.prod_variant_nat_key_nr) = CAST(t1.orig_item_nr AS STRING)
      || '|' || t1.barcode
  INNER JOIN ldl_data_production_meta.t_promotion_key_2 AS p ON p.promo_key_type_cd = 'STORE' AND UPPER(p.promo_nat_key_nr
     ) = UPPER(t1.promo_nat_key_nr)
  LEFT JOIN ldl_data_production_meta.t_wawi_item_key_2 AS wik ON UPPER(CASE
         WHEN t1.country_org_cd = 'CS'
         THEN 'ES'
         ELSE t1.country_org_cd
         END) || '|' || CAST(SAFE_CAST(t1.orig_item_nr AS BIGNUMERIC) AS STRING) = wik.wawi_item_nat_key_nr AND wik.wawi_item_key_type_cd
      = 'WAWI' AND t1.bus_dt BETWEEN DATE(wik.dwh_valid_from_tmsp) AND (DATE(wik.dwh_valid_to_tmsp)));