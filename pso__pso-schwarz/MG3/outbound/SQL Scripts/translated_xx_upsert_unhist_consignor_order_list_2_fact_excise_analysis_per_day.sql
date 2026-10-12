
/* floor(case when max(rl.customs_tariff_code_type_cd) = 'BEER'
                         then sum(cols.spec_meas * cp.alcoholic_beverage_pct * coalesce(cp.special_excise_rate_val, tr.excise_tax_rate_val))
                         else sum(cols.spec_meas * coalesce(cp.special_excise_rate_val, tr.excise_tax_rate_val)) 
                     end * 100) / 100 as excise_val */
/* sum(case when coalesce(cp.alcoholic_beverage_tax_rate_cd, '-1') != coalesce(br.broker_tax_cd, '-1')
                then coalesce(br.line_cnt, cs.line_cnt)
                else 0
            end) */
-- GTS
 -- Broker Report
 -- brl.alcoholic_beverage_tax_rate_cd,
 /* 'GBP' as curr_cd, */ -- WWT

/* case when broker_tax_cd != consignor_tax_cd
            then coalesce(nullfif(broker_line_cnt, 0), consignor_line_cnt)
            else 0
        end	as different_tax_code_cnt, */
/* case when abs(broker_excise_qty - consignor_excise_qty) > 0.3
            then coalesce(nullfif(broker_line_cnt, 0), consignor_line_cnt)
            else 0
        end as different_excise_quantity_cnt, */
/* sum(case when coalesce(br.excise_qty, 0) != coalesce(cs.excise_qty, 0)
                then coalesce(br.line_cnt, cs.line_cnt)
                else 0
            end) */
/* and cp.dwh_valid_fg */ 
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, dwh_load_id,
 broker_declarant_party_sid, customs_product_sid, customs_declaration_type_cd, consignor_party_sid,
 authority_country_location_sid, curr_cd, customs_preference_cd, broker_line_cnt, original_consignor_party_sid,
 trader_reference_nr, report_dt, broker_tax_cd, different_tax_code_cnt, broker_excise_qty, consignor_line_missing_cnt,
 broker_consignor_party_sid, cds_consignor_party_sid, correct_excise_amount_cnt, overpaid_excise_val,
 movement_ref_number_txt, broker_line_missing_cnt, article_variant_nr_txt, consignor_line_cnt, consignor_excise_qty,
 different_excise_amount_cnt, consignor_tax_cd, broker_excise_val, item_position_txt, different_excise_quantity_cnt,
 consignor_excise_val, underpaid_excise_val)
(SELECT COALESCE(br.dwh_src_file_name, cs.dwh_src_file_name) AS dwh_src_file_name,
  0 AS tf_error_fg,
  COALESCE(br.dwh_src_1_tmsp, cs.dwh_src_1_tmsp) AS dwh_src_1_tmsp,
   0 <> 0 AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  COALESCE(br.dwh_src_1_tmsp, cs.dwh_src_1_tmsp) AS dwh_mapping_tmsp,
  COALESCE(br.dwh_src_file_name, cs.dwh_src_file_name) AS filename,
  0 AS dwh_load_id,
  COALESCE(br.broker_declarant_party_sid, - 1) AS broker_declarant_party_sid,
  COALESCE(br.customs_product_sid, cs.customs_product_sid) AS customs_product_sid,
  COALESCE(br.customs_declaration_type_cd, '-1') AS customs_declaration_type_cd,
  COALESCE(cs.consignor_party_sid, - 1) AS consignor_party_sid,
  COALESCE(br.authority_country_location_sid, cs.authority_country_location_sid) AS authority_country_location_sid,
  'GBP' AS curr_cd,
   CASE
   WHEN cp0.preferential_origin_fg
   THEN '300'
   ELSE '100'
   END AS customs_preference_cd,
  COALESCE(SUM(br.line_cnt), 0) AS broker_line_cnt,
  COALESCE(cs.original_consignor_party_sid, - 1) AS original_consignor_party_sid,
  COALESCE(br.trader_reference_nr, cs.trader_reference_nr) AS trader_reference_nr,
  CAST(COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) AS DATE) AS report_dt,
  COALESCE(MAX(br.broker_tax_cd), 'Unknown') AS broker_tax_cd,
   CASE
   WHEN COALESCE(MAX(br.broker_tax_cd), 'Unknown') <> COALESCE(MAX(cs.alcoholic_beverage_tax_rate_cd), 'Unknown')
   THEN CAST(COALESCE(NULLIF(COALESCE(SUM(br.line_cnt), 0), 0), COALESCE(SUM(cs.line_cnt), 0)) AS INTEGER)
   ELSE 0
   END AS different_tax_code_cnt,
  COALESCE(SUM(br.excise_qty), 0) AS broker_excise_qty,
  SUM(CASE
    WHEN cs.trader_reference_nr IS NULL
    THEN CAST(br.line_cnt AS INTEGER)
    ELSE 0
    END) AS consignor_line_missing_cnt,
  COALESCE(br.consignor_party_sid_br, - 1) AS broker_consignor_party_sid,
  COALESCE(br.cds_consignor_party_sid, - 1) AS cds_consignor_party_sid,
   CASE
   WHEN ABS(COALESCE(SUM(br.excise_val), 0) - COALESCE(CAST(FLOOR(SUM(CASE
             WHEN COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) >= CAST('2023-08-01 00:00:00' AS DATETIME)
              
             THEN cs.item_cnt * cp0.alcoholic_beverage_duty_per_unit_val
             WHEN rl0.customs_tariff_code_type_cd = 'BEER'
             THEN cs.excise_qty * cp0.alcoholic_beverage_pct * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val
               )
             ELSE cs.excise_qty * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val)
             END) * 100) AS INTEGER) / 100, 0)) <= 0.3
   THEN CAST(COALESCE(NULLIF(COALESCE(SUM(br.line_cnt), 0), 0), COALESCE(SUM(cs.line_cnt), 0)) AS INTEGER)
   ELSE 0
   END AS correct_excise_amount_cnt,
   CASE
   WHEN COALESCE(SUM(br.excise_val), 0) > COALESCE(CAST(FLOOR(SUM(CASE
           WHEN COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) >= CAST('2023-08-01 00:00:00' AS DATETIME)
            
           THEN cs.item_cnt * cp0.alcoholic_beverage_duty_per_unit_val
           WHEN rl0.customs_tariff_code_type_cd = 'BEER'
           THEN cs.excise_qty * cp0.alcoholic_beverage_pct * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val
             )
           ELSE cs.excise_qty * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val)
           END) * 100) AS INTEGER) / 100, 0)
   THEN COALESCE(SUM(br.excise_val), 0) - COALESCE(CAST(FLOOR(SUM(CASE
           WHEN COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) >= CAST('2023-08-01 00:00:00' AS DATETIME)
            
           THEN cs.item_cnt * cp0.alcoholic_beverage_duty_per_unit_val
           WHEN rl0.customs_tariff_code_type_cd = 'BEER'
           THEN cs.excise_qty * cp0.alcoholic_beverage_pct * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val
             )
           ELSE cs.excise_qty * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val)
           END) * 100) AS INTEGER) / 100, 0)
   ELSE 0
   END AS overpaid_excise_val,
  COALESCE(MAX(br.movement_ref_number_txt), 'Unknown') AS movement_ref_number_txt,
  SUM(CASE
    WHEN br.trader_reference_nr IS NULL
    THEN CAST(cs.line_cnt AS INTEGER)
    ELSE 0
    END) AS broker_line_missing_cnt,
  COALESCE(MAX(cs.article_variant_nr), '') AS article_variant_nr_txt,
  COALESCE(SUM(cs.line_cnt), 0) AS consignor_line_cnt,
  COALESCE(SUM(cs.excise_qty), 0) AS consignor_excise_qty,
   CASE
   WHEN ABS(COALESCE(SUM(br.excise_val), 0) - COALESCE(CAST(FLOOR(SUM(CASE
             WHEN COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) >= CAST('2023-08-01 00:00:00' AS DATETIME)
              
             THEN cs.item_cnt * cp0.alcoholic_beverage_duty_per_unit_val
             WHEN rl0.customs_tariff_code_type_cd = 'BEER'
             THEN cs.excise_qty * cp0.alcoholic_beverage_pct * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val
               )
             ELSE cs.excise_qty * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val)
             END) * 100) AS INTEGER) / 100, 0)) > 0.3
   THEN CAST(COALESCE(NULLIF(COALESCE(SUM(br.line_cnt), 0), 0), COALESCE(SUM(cs.line_cnt), 0)) AS INTEGER)
   ELSE 0
   END AS different_excise_amount_cnt,
  COALESCE(MAX(cs.alcoholic_beverage_tax_rate_cd), 'Unknown') AS consignor_tax_cd,
  COALESCE(SUM(br.excise_val), 0) AS broker_excise_val,
  COALESCE(MAX(br.item_position_txt), 'Unknown') AS item_position_txt,
   CASE
   WHEN ABS(COALESCE(SUM(br.excise_qty), 0) - COALESCE(SUM(cs.excise_qty), 0)) > 0.3
   THEN CAST(COALESCE(NULLIF(COALESCE(SUM(br.line_cnt), 0), 0), COALESCE(SUM(cs.line_cnt), 0)) AS INTEGER)
   ELSE 0
   END AS different_excise_quantity_cnt,
  COALESCE(CAST(FLOOR(SUM(CASE
         WHEN COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) >= CAST('2023-08-01 00:00:00' AS DATETIME)
         THEN cs.item_cnt * cp0.alcoholic_beverage_duty_per_unit_val
         WHEN rl0.customs_tariff_code_type_cd = 'BEER'
         THEN cs.excise_qty * cp0.alcoholic_beverage_pct * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val
           )
         ELSE cs.excise_qty * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val)
         END) * 100) AS INTEGER) / 100, 0) AS consignor_excise_val,
   CASE
   WHEN COALESCE(CAST(FLOOR(SUM(CASE
           WHEN COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) >= CAST('2023-08-01 00:00:00' AS DATETIME)
            
           THEN cs.item_cnt * cp0.alcoholic_beverage_duty_per_unit_val
           WHEN rl0.customs_tariff_code_type_cd = 'BEER'
           THEN cs.excise_qty * cp0.alcoholic_beverage_pct * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val
             )
           ELSE cs.excise_qty * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val)
           END) * 100) AS INTEGER) / 100, 0) > COALESCE(SUM(br.excise_val), 0)
   THEN COALESCE(CAST(FLOOR(SUM(CASE
           WHEN COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) >= CAST('2023-08-01 00:00:00' AS DATETIME)
            
           THEN cs.item_cnt * cp0.alcoholic_beverage_duty_per_unit_val
           WHEN rl0.customs_tariff_code_type_cd = 'BEER'
           THEN cs.excise_qty * cp0.alcoholic_beverage_pct * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val
             )
           ELSE cs.excise_qty * COALESCE(cp0.special_excise_rate_val, tr.excise_tax_rate_val)
           END) * 100) AS INTEGER) / 100, 0) - COALESCE(SUM(br.excise_val), 0)
   ELSE 0
   END AS underpaid_excise_val
 FROM (SELECT CASE
     WHEN br.trader_reference LIKE '%-SDI'
     THEN SUBSTR(br.trader_reference, 1, LENGTH(br.trader_reference) - 4)
     ELSE br.trader_reference
     END AS trader_reference_nr,
    COALESCE(CAST(NULLIF(br.cds_acceptance_dt, DATE '1900-01-01') AS DATETIME), CAST(NULLIF(br.cds_clearance_dt, DATE '1900-01-01') AS DATETIME)
     , DATE_TRUNC(br.acceptance_tmsp, DD)) AS cds_acceptance_dt,
    br.broker_declarant_party_sid,
    br.customs_declaration_type_cd,
    br.consignor_party_sid AS consignor_party_sid_br,
    cr.consignor_party_sid AS cds_consignor_party_sid,
    br.authority_country_location_sid,
    brl.customs_product_sid,
    cp.customs_product_nr,
    cp.additional_cd,
    cp.customs_tariff_code_cd,
    cp.origin_country_location_sid,
    MIN(br.dwh_src_file_name) AS dwh_src_file_name,
    MIN(br.dwh_src_1_tmsp) AS dwh_src_1_tmsp,
    STRING_AGG(DISTINCT brl.alcoholic_beverage_tax_rate_cd, ', ' ORDER BY brl.alcoholic_beverage_tax_rate_cd IS NULL,
      brl.alcoholic_beverage_tax_rate_cd) AS broker_tax_cd,
    COUNT(*) AS line_cnt,
    SUM(COALESCE(brl.item_tariff_qty, 0)) AS excise_qty,
    SUM(COALESCE(brl.excise_payment_amount_val, 0)) AS excise_val,
    STRING_AGG(DISTINCT br.movement_ref_number, ', ' ORDER BY br.movement_ref_number IS NULL, br.movement_ref_number) AS
    movement_ref_number_txt,
    STRING_AGG(DISTINCT CAST(brl.item_position AS STRING), ', ' ORDER BY CAST(brl.item_position AS STRING) IS NULL, CAST(brl.item_position AS STRING)
      ) AS item_position_txt
   FROM szd_production_core_rel.t_broker_report AS br
    INNER JOIN szd_production_core_rel.t_broker_report_line AS brl ON br.movement_ref_number = brl.movement_ref_number
     AND br.trader_reference = brl.trader_reference
    INNER JOIN szd_production_core_rel.t_customs_product AS cp ON brl.customs_product_sid = cp.product_sid AND CAST(COALESCE(CAST(NULLIF(br.cds_acceptance_dt, DATE '1900-01-01') AS DATETIME)
        , DATE_TRUNC(br.acceptance_tmsp, DD), CAST(br.cds_clearance_dt AS DATETIME)) AS TIMESTAMP)
      BETWEEN cp.dwh_valid_from_tmsp AND cp.dwh_valid_to_tmsp -- and YEAR(cp.dwh_valid_from_tmsp)>1900

    INNER JOIN szd_production_core_rel.t_customs_tariff_code_type_rel AS rl ON cp.customs_tariff_code_cd = rl.customs_tariff_code_cd
       AND rl.customs_tariff_category_cd = 'ABV'
    LEFT JOIN szd_production_core_rel.t_customs_clearance_report AS cr ON br.movement_ref_number = cr.movement_ref_number
       AND (br.trader_reference = cr.trader_reference OR brl.invoice_number = cr.trader_reference OR br.declaration_ucr
        LIKE '%' || cr.trader_reference || '%')
   WHERE cp.alcoholic_beverage_tax_rate_cd LIKE 'X%'
    AND br.trader_reference IS NOT NULL
   GROUP BY trader_reference_nr,
    cds_acceptance_dt,
    br.broker_declarant_party_sid,
    br.customs_declaration_type_cd,
    consignor_party_sid_br,
    cds_consignor_party_sid,
    br.authority_country_location_sid,
    brl.customs_product_sid,
    cp.customs_product_nr,
    cp.additional_cd,
    cp.customs_tariff_code_cd,
    cp.origin_country_location_sid) AS br
  FULL JOIN (SELECT co.trader_reference_nr,
     co.order_dt,
     cp.product_sid AS customs_product_sid,
     cp.customs_product_nr,
     cp.additional_cd,
     cp.customs_tariff_code_cd,
     cp.origin_country_location_sid,
     col.article_variant_nr,
     co.authority_country_location_sid,
     co.consignor_party_sid,
     co.original_consignor_party_sid,
     col.alcoholic_beverage_tax_rate_cd,
     COUNT(*) AS line_cnt,
     SUM(col.item_cnt) AS item_cnt,
     SUM(CASE
       WHEN cols.spec_uom_id = 28
       THEN cols.spec_meas * 100
       ELSE cols.spec_meas
       END) AS excise_qty,
     MAX(co.dwh_src_file_name) AS dwh_src_file_name,
     MAX(co.dwh_src_1_tmsp) AS dwh_src_1_tmsp
    FROM szd_production_core_rel.t_consignor_order_list AS co
     INNER JOIN szd_production_core_rel.t_consignor_order_list_line AS col ON co.trader_reference_nr = col.trader_reference_nr
        AND co.order_dt = col.order_dt
     INNER JOIN szd_production_core_rel.t_customs_product AS cp ON col.customs_product_sid = cp.product_sid AND cp.customs_product_type_cd
         = 'GTS' -- and YEAR(cp.dwh_valid_from_tmsp)>1900
 AND co.order_dt BETWEEN CAST(cp.dwh_valid_from_tmsp AS DATE)
       AND (CAST(cp.dwh_valid_to_tmsp /* join SZD_PRODUCTION.core_rel.t_customs_tariff_code_type_rel rl
           on cp.customs_tariff_code_cd = rl.customs_tariff_code_cd
          and rl.customs_tariff_category_cd = 'ABV' */ AS DATE)
        )
     INNER JOIN szd_production_core_rel.t_consignor_order_list_line_specification AS cols ON col.trader_reference_nr =
         cols.trader_reference_nr AND col.order_dt = cols.order_dt AND col.item_position_seq = cols.item_position_seq
      AND cols.specification_seq = 1
       /* join SZD_PRODUCTION.core_rel.t_alcoholic_beverage_tax_rate tr
           on cp.alcoholic_beverage_tax_rate_cd = tr.alcoholic_beverage_tax_rate_cd */
       
    WHERE col.product_sid = - 1 -- and cp.dwh_valid_fg

    GROUP BY co.trader_reference_nr,
     co.order_dt,
     customs_product_sid,
     cp.customs_product_nr,
     cp.additional_cd,
     cp.customs_tariff_code_cd,
     cp.origin_country_location_sid,
     col.article_variant_nr,
     co.authority_country_location_sid,
     co.consignor_party_sid,
     co.original_consignor_party_sid,
     col.alcoholic_beverage_tax_rate_cd
    UNION ALL
    SELECT co.trader_reference_nr,
     co.order_dt,
     cp.product_sid AS customs_product_sid,
     cp.customs_product_nr,
     cp.additional_cd,
     cp.customs_tariff_code_cd,
     cp.origin_country_location_sid,
     SUBSTR(CAST(NULL AS STRING), 1, 250) AS article_variant_nr,
     co.authority_country_location_sid,
     co.consignor_party_sid,
     co.original_consignor_party_sid,
     cp.alcoholic_beverage_tax_rate_cd,
     COUNT(*) AS line_cnt,
     SUM(col.item_cnt) AS item_cnt,
     SUM(CASE
       WHEN cp.alcoholic_beverage_uom_id = 24
       THEN col.item_cnt * cp.alcoholic_beverage_volume_lpa_qty
       ELSE col.item_cnt * cp.alcoholic_beverage_volume_qty
       END) AS excise_qty,
     MAX(co.dwh_src_file_name) AS dwh_src_file_name,
     MAX(co.dwh_src_1_tmsp) AS dwh_src_1_tmsp
    FROM szd_production_core_rel.t_consignor_order_list AS co
     INNER JOIN szd_production_core_rel.t_consignor_order_list_line AS col ON co.trader_reference_nr = col.trader_reference_nr
         AND co.order_dt = col.order_dt AND co.invoice_finance_sid = col.invoice_finance_sid
     INNER JOIN szd_production_core_rel.t_customs_product AS cp ON col.product_nr = cp.customs_product_nr
         -- and YEAR(cp.dwh_valid_from_tmsp)>1900
 AND col.additional_cd = cp.additional_cd AND cp.customs_product_type_cd
         = 'WWT' AND co.order_dt BETWEEN CAST(cp.dwh_valid_from_tmsp AS DATE) AND (CAST(cp.dwh_valid_to_tmsp AS DATE))
     INNER JOIN szd_production_core_rel.t_invoice_status AS ist ON co.invoice_finance_sid = ist.invoice_finance_sid AND
       co.order_dt BETWEEN CAST(ist.dwh_valid_from_tmsp AS DATE) AND (CAST(ist.dwh_valid_to_tmsp AS DATE))
     INNER JOIN szd_production_core_rel.t_invoice_position AS inp ON col.invoice_position_finance_sid = inp.finance_sid
      AND co.order_dt BETWEEN CAST(inp.dwh_valid_from_tmsp AS DATE) AND (CAST(inp.dwh_valid_to_tmsp AS DATE))
    WHERE col.product_sid <> - 1
     AND ist.invoice_status_type_cd IN ('UNCHARGED', 'CHARGED')
     AND inp.reference_invoice_position_finance_sid = - 1
     AND cp.alcoholic_beverage_volume_qty > 0
    GROUP BY co.trader_reference_nr,
     co.order_dt,
     customs_product_sid,
     cp.customs_product_nr,
     cp.additional_cd,
     cp.customs_tariff_code_cd,
     cp.origin_country_location_sid,
     article_variant_nr,
     co.authority_country_location_sid,
     co.consignor_party_sid,
     co.original_consignor_party_sid,
     cp.alcoholic_beverage_tax_rate_cd) AS cs ON br.trader_reference_nr = cs.trader_reference_nr AND br.customs_product_nr
        = cs.customs_product_nr AND br.additional_cd = cs.additional_cd AND br.customs_tariff_code_cd = cs.customs_tariff_code_cd
      AND br.origin_country_location_sid = cs.origin_country_location_sid
  INNER JOIN szd_production_core_rel.t_customs_product AS cp0 ON COALESCE(br.customs_product_sid, cs.customs_product_sid
     ) = cp0.product_sid AND CAST(COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) AS
     TIMESTAMP) BETWEEN cp0.dwh_valid_from_tmsp AND cp0.dwh_valid_to_tmsp
    -- and YEAR(cp.dwh_valid_from_tmsp)>1900

  INNER JOIN szd_production_core_rel.t_customs_tariff_code_type_rel AS rl0 ON cp0.customs_tariff_code_cd = rl0.customs_tariff_code_cd
     AND rl0.customs_tariff_category_cd = 'ABV'
  INNER JOIN szd_production_core_rel.t_alcoholic_beverage_tax_rate AS tr ON cp0.alcoholic_beverage_tax_rate_cd = tr.alcoholic_beverage_tax_rate_cd
     AND CAST(COALESCE(br.cds_acceptance_dt, CAST(cs.order_dt AS DATETIME)) AS TIMESTAMP) BETWEEN
    tr.dwh_valid_from_tmsp AND tr.dwh_valid_to_tmsp
 GROUP BY trader_reference_nr,
  customs_product_sid,
  authority_country_location_sid,
  report_dt,
  broker_declarant_party_sid,
  consignor_party_sid,
  broker_consignor_party_sid,
  cds_consignor_party_sid,
  original_consignor_party_sid,
  customs_declaration_type_cd,
  customs_preference_cd,
  dwh_mapping_tmsp,
  dwh_src_file_name
 QUALIFY (RANK() OVER (PARTITION BY trader_reference_nr ORDER BY CASE
        WHEN broker_declarant_party_sid > - 1
        THEN 1
        ELSE - 1
        END IS NULL DESC, CASE
        WHEN broker_declarant_party_sid > - 1
        THEN 1
        ELSE - 1
        END DESC)) = 1);