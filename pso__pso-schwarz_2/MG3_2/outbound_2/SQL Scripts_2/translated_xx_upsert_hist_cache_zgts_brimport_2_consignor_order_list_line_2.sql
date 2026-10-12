
-- ARTIKELNUMMER  STRING
 -- alter table SZD_PRODUCTION.etl.t_cache_abv_2 add column

/* allocation_cnt,
       packages_qty, */ -- excise_code STRING
 /* item_cnt, */
/* case when st.invoice_status_type_cd in ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            then p.package_qty * -1
            else p.package_qty
        end as packages_qty, */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, product_name, product_sid,
 customs_product_sid, origin_country_location_sid, net_weight_meas, trader_reference_nr, item_position_seq,
 additional_cd, alcoholic_beverage_tax_rate_cd, gross_weight_meas, invoice_finance_sid, freight_cost_curr_cd, item_cnt,
 tax_indicator_txt, purchase_order_item_nr, license_cost_val, invoice_position_finance_sid, net_curr_cd,
 insurance_cost_val, allocation_cnt, inbound_item_nr, license_cost_curr_cd, insurance_cost_curr_cd, gtin_nr,
 item_price_val, original_amount_val, product_nr, item_uom_id, net_val, batch_nr, packages_uom_id,
 original_amount_curr_cd, article_variant_nr, order_dt, abv_pct, packages_cnt, additional_codes_txt, weight_uom_id,
 freight_cost_val)
(SELECT MAX(dwh_src_file_name),
  0 AS tf_error_fg,
  MAX(dwh_src_1_tmsp),
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  CURRENT_TIMESTAMP() AS dwh_mapping_tmsp,
  MAX(dwh_src_file_name) AS filename,
  TRIM(product_name) AS product_name,
  product_sid,
  customs_product_sid,
  origin_country_location_sid,
  net_weight_meas,
  trader_reference_nr,
  item_position_seq,
  additional_cd,
   CASE
   WHEN TRIM(alcoholic_beverage_tax_rate_cd) = 'NULL'
   THEN '-1'
   ELSE TRIM(alcoholic_beverage_tax_rate_cd)
   END,
  gross_weight_meas,
  invoice_finance_sid,
  freight_cost_curr_cd,
  item_cnt,
  tax_indicator_txt,
  LTRIM(purchase_order_item_nr, '0') AS purchase_order_item_nr,
  license_cost_val,
  invoice_position_finance_sid,
  net_curr_cd,
  insurance_cost_val,
  allocation_cnt,
  LTRIM(inbound_item_nr, '0') AS inbound_item_nr,
   CASE
   WHEN license_cost_curr_cd LIKE 'NUL%'
   THEN '-1'
   ELSE license_cost_curr_cd
   END AS license_cost_curr_cd,
   CASE
   WHEN insurance_cost_curr_cd LIKE 'NUL%'
   THEN '-1'
   ELSE insurance_cost_curr_cd
   END,
  gtin_nr,
  item_price_val,
  original_amount_val,
  LTRIM(product_nr, '0') AS product_nr,
  item_uom_id,
  net_val,
  batch_nr,
  packages_uom_id,
  original_amount_curr_cd,
  article_variant_nr,
  order_dt,
  CAST(abv_pct AS STRING) AS abv_pct,
  packages_cnt,
   CASE
   WHEN additional_codes_txt = 'NULL'
   THEN NULL
   ELSE additional_codes_txt
   END,
  weight_uom_id,
  freight_cost_val
 FROM (SELECT CAST(bei.corder AS STRING) AS trader_reference_nr,
     COALESCE(bei.etd, bei.etats) AS order_dt,
     ROW_NUMBER() OVER (PARTITION BY bei.corder ORDER BY bei.itvsy_id_no IS NULL, bei.itvsy_id_no) AS item_position_seq
     ,
     - 1 AS product_sid,
     pk.product_sid AS customs_product_sid,
     COALESCE(ock.location_sid, - 1) AS origin_country_location_sid,
      CASE
      WHEN bei.etd >= DATE '2023-08-01'
      THEN COALESCE(bei.excise_duty_code, '-1')
      ELSE COALESCE(abv.excise_code, bei.excise_duty_code, '-1')
      END AS alcoholic_beverage_tax_rate_cd,
     - 1 AS invoice_finance_sid,
     - 1 AS invoice_position_finance_sid,
     LTRIM(bei.itvsy_po_no, '0') AS purchase_order_item_nr,
     LTRIM(CAST(bei.prvsy AS STRING), '0') AS product_nr,
     '' AS additional_cd,
     TRIM(SUBSTR(bei.prtxt, 1, 100)) AS product_name,
     bei.weinet_flt AS net_weight_meas,
     bei.weigro_flt AS gross_weight_meas,
     10 AS weight_uom_id,
     bei.allocation AS allocation_cnt,
     bei.pgesu AS packages_cnt,
     30 AS packages_uom_id,
     bei.quant_flt AS item_cnt,
     19 AS item_uom_id,
     bei.netval_flt AS net_val,
     'EUR' AS net_curr_cd,
     CAST(bei.original_val AS BIGNUMERIC) AS original_amount_val,
     COALESCE(SUBSTR(bei.orig_val_curr, 1, 3), '-1') AS original_amount_curr_cd,
     0 AS item_price_val,
     bei.frt_cost AS freight_cost_val,
     COALESCE(SUBSTR(bei.frt_cost_curr, 1, 3), '-1') AS freight_cost_curr_cd,
     bei.ins_cost AS insurance_cost_val,
     COALESCE(SUBSTR(bei.ins_cost_curr, 1, 3), '-1') AS insurance_cost_curr_cd,
     bei.licence_cost AS license_cost_val,
     COALESCE(SUBSTR(bei.licence_cost_curr, 1, 3), '-1') AS license_cost_curr_cd,
     0 AS abv_pct,
     LTRIM(bei.itvsy_id_no, '0') AS inbound_item_nr,
     bei.taxid AS tax_indicator_txt,
     TRIM(bei.article_variant) AS article_variant_nr,
     bei.additional_codes AS additional_codes_txt,
     bei.gtin_number AS gtin_nr,
     CAST(NULL AS STRING) AS batch_nr,
     CURRENT_TIMESTAMP() AS dwh_created_tmsp,
     CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
     bei.dwh_src_file_name,
     CURRENT_TIMESTAMP() AS dwh_src_1_tmsp
    FROM szd_production_etl.t_cache_zgts_brimport_2 AS bei
     INNER JOIN szd_production_meta.t_product_key_2 AS pk ON pk.product_key_type_cd = 'CUSTOMS_PRODUCT' AND pk.product_nat_key_nr
        = CAST(ROUND(SAFE_CAST(bei.prvsy AS BIGNUMERIC), 0) AS STRING) || '||' || LPAD(SUBSTR(REPLACE(bei.ccngn, ' ', ''
             ), 1, 10), 10, '0') || '|' || TRIM(bei.cucoo)
     LEFT JOIN szd_production_meta.t_location_key_2 AS ock ON ock.location_key_type_cd = 'COUNTRY_2' AND ock.location_nat_key_nr
        = UPPER(TRIM(bei.cucoo))
     LEFT JOIN szd_production_etl.t_cache_abv_2 AS abv ON LTRIM(bei.prvsy, '0') = abv.article_number
    WHERE COALESCE(bei.etd, bei.etats) IS NOT NULL
    UNION DISTINCT
    SELECT t3.trader_reference_nr,
     t3.order_dt,
     ROW_NUMBER() OVER (PARTITION BY t3.consignee_additional_name || '-' || t3.invoice_reference_nr, t3.loading_dt
      ORDER BY ROUND(ROUND(CAST(t3.finance_nat_key_nr AS BIGNUMERIC), 0), 0) IS NULL, ROUND(ROUND(CAST(t3.finance_nat_key_nr AS BIGNUMERIC)
          , 0), 0)) AS item_position_seq,
     t3.product_sid,
     - 1 AS customs_product_sid,
     t3.origin_country_location_sid,
     '-1' AS alocholic_beverage_tax_rate_cd,
     t3.invoice_finance_sid,
     t3.invoice_position_finance_sid,
     CAST(NULL AS STRING) AS purchase_order_item_nr,
     t3.product_nr,
     t3.additional_product_cd,
     t3.product_name,
     t3.net_weight_meas,
     t3.gross_weight_meas,
     10 AS weight_uom_id,
      CASE
      WHEN t3.allocation_cnt IS NULL
      THEN 0
      ELSE t3.allocation_cnt
      END AS allocation_cnt,
      CASE
      WHEN t3.packages_cnt IS NULL
      THEN 0
      ELSE t3.packages_cnt
      END AS packages_cnt,
     30 AS packages_uom_id,
      CASE
      WHEN t3.item_cnt IS NULL
      THEN 0
      ELSE t3.item_cnt
      END AS item_cnt,
     19 AS item_uom_id,
     t3.net_val,
     'EUR' AS net_curr_cd,
     0 AS original_amount_val,
     '-1' AS original_amount_curr_cd,
     t3.item_price_val,
     0 AS freight_cost_val,
     '-1' AS freight_cost_curr_cd,
     0 AS insurance_cost_val,
     '-1' AS insurance_cost_curr_cd,
     0 AS license_cost_val,
     '-1' AS license_cost_curr_cd,
     0 AS abv_pct,
     CAST(NULL AS STRING) AS inbound_item_nr,
     CAST(NULL AS STRING) AS tax_indicator_txt,
     CAST(NULL AS STRING) AS article_variant_nr,
     CAST(NULL AS STRING) AS additional_codes_txt,
     CAST(NULL AS STRING) AS gtin_nr,
     t3.batch_nr,
     CURRENT_TIMESTAMP() AS dwh_created_tmsp,
     CURRENT_TIMESTAMP() AS dwh_updated_tmsp,
     t3.dwh_src_file_name,
     CURRENT_TIMESTAMP() AS dwh_src_1_tmsp
    FROM (SELECT DISTINCT c.consignee_additional_name || '-' || i.invoice_reference_nr AS trader_reference_nr,
       p.loading_dt AS order_dt,
       c.consignee_additional_name,
       i.invoice_reference_nr,
       p.loading_dt,
       fk.finance_nat_key_nr,
       p.product_sid,
       p.origin_country_location_sid,
       p.invoice_finance_sid,
       p.finance_sid AS invoice_position_finance_sid,
       CAST(pr.ian_nr AS STRING) AS product_nr,
       p.additional_product_cd,
       p.product_name,
        CASE
        WHEN CASE
         WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
         THEN p.package_qty * - 1
         ELSE p.package_qty
         END IS NULL
        THEN 0
        ELSE CASE
         WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
         THEN p.package_qty * - 1
         ELSE p.package_qty
         END
        END AS packages_cnt,
        CASE
        WHEN p.non_food_fg AND st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
        THEN p.item_net_weight_meas * CASE
           WHEN CASE
            WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            THEN p.package_qty * - 1
            ELSE p.package_qty
            END IS NULL
           THEN 0
           ELSE CASE
            WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            THEN p.package_qty * - 1
            ELSE p.package_qty
            END
           END * - 1
        WHEN p.non_food_fg AND st.invoice_status_type_cd NOT IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
        THEN p.item_net_weight_meas * CASE
          WHEN CASE
           WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
           THEN p.package_qty * - 1
           ELSE p.package_qty
           END IS NULL
          THEN 0
          ELSE CASE
           WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
           THEN p.package_qty * - 1
           ELSE p.package_qty
           END
          END
        WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE') AND NOT p.non_food_fg
        THEN p.unit_net_weight_meas * CASE
           WHEN CASE
            WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            THEN p.package_qty * - 1
            ELSE p.package_qty
            END IS NULL
           THEN 0
           ELSE CASE
            WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            THEN p.package_qty * - 1
            ELSE p.package_qty
            END
           END * - 1
        WHEN NOT p.non_food_fg AND st.invoice_status_type_cd NOT IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
        THEN p.unit_net_weight_meas * CASE
          WHEN CASE
           WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
           THEN p.package_qty * - 1
           ELSE p.package_qty
           END IS NULL
          THEN 0
          ELSE CASE
           WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
           THEN p.package_qty * - 1
           ELSE p.package_qty
           END
          END
        ELSE NULL
        END AS net_weight_meas,
        CASE
        WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
        THEN p.unit_gross_weight_meas * CASE
           WHEN CASE
            WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            THEN p.package_qty * - 1
            ELSE p.package_qty
            END IS NULL
           THEN 0
           ELSE CASE
            WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
            THEN p.package_qty * - 1
            ELSE p.package_qty
            END
           END * - 1
        ELSE p.unit_gross_weight_meas * CASE
          WHEN CASE
           WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
           THEN p.package_qty * - 1
           ELSE p.package_qty
           END IS NULL
          THEN 0
          ELSE CASE
           WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
           THEN p.package_qty * - 1
           ELSE p.package_qty
           END
          END
        END AS gross_weight_meas,
       p.package_content_cnt AS allocation_cnt,
        CASE
        WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
        THEN p.package_content_cnt * p.package_qty * - 1
        ELSE p.package_content_cnt * p.package_qty
        END AS item_cnt,
        CASE
        WHEN st.invoice_status_type_cd IN ('CREDIT_INVOICE', 'CANCEL_INVOICE')
        THEN p.amount_val * - 1
        ELSE p.amount_val
        END AS net_val,
       p.price_val AS item_price_val,
       p.batch_nr,
       p.dwh_src_file_name
      FROM szd_production_core_rel.t_invoice_position_2 AS p
       INNER JOIN szd_production_core_rel.t_invoice_2 AS i ON p.invoice_finance_sid = i.finance_sid
       INNER JOIN szd_production_core_rel.t_consignee_2 AS c ON i.consignee_party_sid = c.party_sid AND c.dwh_valid_fg
       INNER JOIN szd_production_core_rel.t_country_political_2 AS co ON c.country_location_sid = co.location_sid AND co.lang_cd
          = 'DE'
       LEFT JOIN szd_production_core_rel.t_product_2 AS pr ON p.product_sid = pr.product_sid AND p.loading_dt BETWEEN CAST(pr.dwh_valid_from_tmsp AS DATE)
         AND (CAST(pr.dwh_valid_to_tmsp AS DATE))
       LEFT JOIN szd_production_core_rel.t_invoice_status_2 AS st ON i.finance_sid = st.invoice_finance_sid AND p.loading_dt
         BETWEEN CAST(st.dwh_valid_from_tmsp AS DATE) AND (CAST(st.dwh_valid_to_tmsp AS DATE))
       LEFT JOIN szd_production_meta.t_finance_key_2 AS fk ON p.finance_sid = fk.finance_sid
      WHERE p.business_transaction_type_cd = '1-LAGER'
       AND co.iso_country_cd = 'GB'
       AND i.consignor_stream_cd IN ('LST', 'OWIM')
       AND p.loading_dt >= DATE '2021-12-01') AS t3) AS a
 GROUP BY trader_reference_nr,
  order_dt,
  item_position_seq,
  product_sid,
  customs_product_sid,
  origin_country_location_sid,
  alcoholic_beverage_tax_rate_cd,
  invoice_finance_sid,
  invoice_position_finance_sid,
  purchase_order_item_nr,
  product_nr,
  additional_cd,
  product_name,
  net_weight_meas,
  gross_weight_meas,
  weight_uom_id,
  allocation_cnt,
  packages_cnt,
  packages_uom_id,
  item_cnt,
  item_uom_id,
  net_val,
  net_curr_cd,
  original_amount_val,
  original_amount_curr_cd,
  item_price_val,
  freight_cost_val,
  freight_cost_curr_cd,
  insurance_cost_val,
  insurance_cost_curr_cd,
  license_cost_val,
  license_cost_curr_cd,
  abv_pct,
  inbound_item_nr,
  tax_indicator_txt,
  article_variant_nr,
  additional_codes_txt,
  gtin_nr,
  batch_nr);