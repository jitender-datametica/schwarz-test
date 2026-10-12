/* Post Inference Output with 1 inferred tables and its data types: 

[ If a table is not found in the dictionary, a `DM_INFERRED_` prefixed schema DDL is inferred and added to the dictionary, while the original table name remains in the SQL query.]

1. SZD_PRODUCTON.DM_INFERRED_${TEMP_DB}.${SRC2TGT_TEMP_TABLE1}_${SRC_CONTEXT_AREA}
		Column: article_number, Data Type: VARCHAR
		Column: allocation, Data Type: VARCHAR
		Column: dwh_src_file_name, Data Type: VARCHAR
		Column: tf_error_fg, Data Type: INTEGER
		Column: country_of_origin, Data Type: VARCHAR
		Column: customs_tariff_number, Data Type: VARCHAR
		Column: article, Data Type: VARCHAR
		Column: preferential_origin, Data Type: VARCHAR
		Column: tax_code, Data Type: VARCHAR
		Column: quantity_in_uom, Data Type: VARCHAR
		Column: dwh_src_1_tmsp, Data Type: TIMESTAMP_WITH_LOCAL_TIME_ZONE
		Column: deleted_fg, Data Type: BOOLEAN
		Column: unit_of_measure, Data Type: VARCHAR
		Column: dwh_valid_fg, Data Type: BOOLEAN
		Column: record_id, Data Type: VARCHAR
		Column: dwh_mapping_tmsp, Data Type: TIMESTAMP_WITH_LOCAL_TIME_ZONE
		Column: filename, Data Type: VARCHAR
		Column: resource_item_key_type_cd, Data Type: VARCHAR
		Column: export_warehouse_name, Data Type: VARCHAR
		Column: invoice_nr, Data Type: VARCHAR
		Column: finance_key_type_cd, Data Type: VARCHAR
		Column: consignee_party_id, Data Type: VARCHAR
		Column: finance_id, Data Type: VARCHAR
		Column: consignee_party_key_type_cd, Data Type: VARCHAR
		Column: receipt_txt, Data Type: VARCHAR
		Column: booking_type_cd, Data Type: VARCHAR
		Column: invoice_type_cd, Data Type: VARCHAR
		Column: consignor_stream_cd, Data Type: VARCHAR
		Column: invoice_reference_nr, Data Type: VARCHAR
		Column: invoice_finance_key_type_cd, Data Type: VARCHAR
		Column: invoice_finance_id, Data Type: VARCHAR
		Column: invoice_status_type_cd, Data Type: VARCHAR
		Column: product_status_cd, Data Type: VARCHAR
		Column: incoterm_name, Data Type: VARCHAR
		Column: product_division_type_cd, Data Type: VARCHAR
		Column: product_name_txt, Data Type: VARCHAR
		Column: product_key_type_cd, Data Type: VARCHAR
		Column: product_name, Data Type: VARCHAR
		Column: prod_id, Data Type: VARCHAR
		Column: ian_nr, Data Type: VARCHAR
		Column: company_id, Data Type: VARCHAR
		Column: party_key_type_cd, Data Type: VARCHAR
		Column: source_company_name_address_city_txt, Data Type: VARCHAR
		Column: company_type_cd, Data Type: VARCHAR
		Column: company_name, Data Type: VARCHAR
		Column: company_nr, Data Type: VARCHAR
		Column: company_status_cd, Data Type: VARCHAR
		Column: papty, Data Type: VARCHAR
		Column: prtxt, Data Type: VARCHAR
		Column: prvsy, Data Type: VARCHAR
		Column: cucoo, Data Type: VARCHAR
		Column: etd, Data Type: DATE
		Column: excise_duty_code, Data Type: VARCHAR
		Column: ccngn, Data Type: VARCHAR
		Column: ctsmu1, Data Type: VARCHAR
		Column: consignee_id, Data Type: VARCHAR
		Column: consignee_name, Data Type: VARCHAR
		Column: consignee_additional_name, Data Type: VARCHAR
		Column: country_location_id, Data Type: VARCHAR
		Column: country_location_key_type_cd, Data Type: VARCHAR
		Column: party_sid, Data Type: DECIMAL
		Column: importer_party_sid, Data Type: DECIMAL
		Column: importer_name, Data Type: VARCHAR
		Column: consignor_stream_name, Data Type: VARCHAR
		Column: consignor_name, Data Type: VARCHAR
		Column: importer_nr, Data Type: VARCHAR
		Column: error_descr, Data Type: VARCHAR
		Column: requested_procedure_cd, Data Type: VARCHAR
		Column: requested_procedure_descr, Data Type: VARCHAR
		Column: customs_procedure_cd, Data Type: VARCHAR
		Column: dwh_load_id, Data Type: DECIMAL
		Column: customs_procedure_approve_status_name, Data Type: VARCHAR
		Column: additional_procedure_descr, Data Type: VARCHAR
		Column: customs_procedure_approved_fg, Data Type: BOOLEAN
		Column: additional_procedure_cd, Data Type: VARCHAR
		Column: customs_procedure_approve_status_cd, Data Type: VARCHAR
		Column: product_sid, Data Type: DECIMAL
		Column: item_position, Data Type: DECIMAL
		Column: attribute_value_txt, Data Type: VARCHAR
		Column: declarant_party_sid, Data Type: DECIMAL
		Column: cds_acceptance_dt, Data Type: DATE
		Column: movement_ref_number, Data Type: VARCHAR
		Column: attribute_name, Data Type: VARCHAR
		Column: broker_declarant_party_sid, Data Type: DECIMAL
		Column: total_line_cnt, Data Type: DECIMAL
		Column: customs_product_sid, Data Type: DECIMAL
		Column: customs_declaration_type_cd, Data Type: VARCHAR
		Column: consignor_party_sid, Data Type: DECIMAL
		Column: alcoholic_line_cnt, Data Type: DECIMAL
		Column: non_alcoholic_line_cnt, Data Type: DECIMAL
		Column: authority_country_location_sid, Data Type: DECIMAL
		Column: customs_tariff_code_cd, Data Type: VARCHAR
		Column: customs_tariff_category_cd, Data Type: VARCHAR
		Column: customs_classification_scheme_cd, Data Type: VARCHAR
		Column: customs_tariff_code_type_cd, Data Type: VARCHAR
		Column: duty_paid_val, Data Type: DECIMAL
		Column: clearance_dt, Data Type: DATE
		Column: curr_cd, Data Type: VARCHAR
		Column: customs_preference_cd, Data Type: VARCHAR
		Column: agreement_sid, Data Type: DECIMAL
		Column: declaration_cnt, Data Type: DECIMAL
		Column: origin_country_location_sid, Data Type: DECIMAL
		Column: declarant_authorized_fg, Data Type: BOOLEAN
		Column: declarant_nr, Data Type: VARCHAR
		Column: declarant_type_cd, Data Type: VARCHAR
		Column: declarant_type_name, Data Type: VARCHAR
		Column: declarant_name, Data Type: VARCHAR
		Column: declarant_auth_status_name, Data Type: VARCHAR
		Column: declarant_auth_status_cd, Data Type: VARCHAR
		Column: broker_number, Data Type: VARCHAR
		Column: broker_name, Data Type: VARCHAR
		Column: broker_authorized_fg, Data Type: BOOLEAN
		Column: broker_party_id, Data Type: VARCHAR
		Column: broker_postcode, Data Type: VARCHAR
		Column: approved_fg, Data Type: BOOLEAN
		Column: origin_country_name_de, Data Type: VARCHAR
		Column: import_country_name_de, Data Type: VARCHAR
		Column: origin_iso_country_cd, Data Type: VARCHAR
		Column: origin_country_name_en, Data Type: VARCHAR
		Column: import_country_name_en, Data Type: VARCHAR
		Column: free_trade_agreement_category_descr, Data Type: VARCHAR
		Column: import_iso_country_cd, Data Type: VARCHAR
		Column: import_country_location_sid, Data Type: DECIMAL
		Column: free_trade_agreement_category_cd, Data Type: VARCHAR
		Column: free_trade_agreement_category_name, Data Type: VARCHAR
		Column: product_cnt, Data Type: DECIMAL
		Column: transport_country_location_sid, Data Type: DECIMAL
		Column: dispatch_country_location_sid, Data Type: DECIMAL
		Column: customs_val, Data Type: DECIMAL
		Column: net_weight_meas, Data Type: DECIMAL
		Column: import_location_sid, Data Type: DECIMAL
		Column: item_non_preferential_country_code, Data Type: VARCHAR
		Column: item_commodity_code, Data Type: VARCHAR
		Column: item_national_additional_code, Data Type: VARCHAR
		Column: item_product, Data Type: VARCHAR
		Column: item_description, Data Type: VARCHAR
		Column: item_preferential_country_code, Data Type: VARCHAR
		Column: importer_eori, Data Type: VARCHAR
		Column: customs_tariff_code_descr, Data Type: VARCHAR
		Column: food_nonfood_type_cd, Data Type: VARCHAR
		Column: food_nonfood_type_name, Data Type: VARCHAR
		Column: customs_tariff_number_descr, Data Type: VARCHAR
		Column: alcoholic_beverage_type_cd, Data Type: VARCHAR
		Column: customs_tariff_number_cd, Data Type: VARCHAR
		Column: alcoholic_beverage_type_name, Data Type: VARCHAR
		Column: excise_val, Data Type: DECIMAL
		Column: broker_line_cnt, Data Type: DECIMAL
		Column: original_consignor_party_sid, Data Type: DECIMAL
		Column: trader_reference_nr, Data Type: VARCHAR
		Column: report_dt, Data Type: DATE
		Column: broker_tax_cd, Data Type: VARCHAR
		Column: different_tax_code_cnt, Data Type: DECIMAL
		Column: broker_excise_qty, Data Type: DECIMAL
		Column: consignor_line_missing_cnt, Data Type: DECIMAL
		Column: broker_consignor_party_sid, Data Type: DECIMAL
		Column: cds_consignor_party_sid, Data Type: DECIMAL
		Column: correct_excise_amount_cnt, Data Type: DECIMAL
		Column: overpaid_excise_val, Data Type: DECIMAL
		Column: movement_ref_number_txt, Data Type: VARCHAR
		Column: broker_line_missing_cnt, Data Type: DECIMAL
		Column: article_variant_nr_txt, Data Type: VARCHAR
		Column: consignor_line_cnt, Data Type: DECIMAL
		Column: consignor_excise_qty, Data Type: DECIMAL
		Column: different_excise_amount_cnt, Data Type: DECIMAL
		Column: consignor_tax_cd, Data Type: VARCHAR
		Column: broker_excise_val, Data Type: DECIMAL
		Column: item_position_txt, Data Type: VARCHAR
		Column: different_excise_quantity_cnt, Data Type: DECIMAL
		Column: consignor_excise_val, Data Type: DECIMAL
		Column: underpaid_excise_val, Data Type: DECIMAL
		Column: error_message, Data Type: VARCHAR
		Column: item_sequence_number, Data Type: VARCHAR
		Column: trader_reference, Data Type: VARCHAR
		Column: mrn, Data Type: VARCHAR
		Column: latitude, Data Type: DECIMAL
		Column: eu_member_fg, Data Type: BOOLEAN
		Column: location_sid, Data Type: DECIMAL
		Column: country_name_en, Data Type: VARCHAR
		Column: iso_country_cd, Data Type: VARCHAR
		Column: country_name_de, Data Type: VARCHAR
		Column: longitude, Data Type: DECIMAL
		Column: alcoholic_beverage_pct, Data Type: DECIMAL
		Column: item_tariff_uom_cd, Data Type: VARCHAR
		Column: origin_country_cd, Data Type: VARCHAR
		Column: net_mass_meas, Data Type: DECIMAL
		Column: item_position_seq, Data Type: DECIMAL
		Column: gross_mass_meas, Data Type: DECIMAL
		Column: excise_payment_amount_val, Data Type: DECIMAL
		Column: customs_product_nr, Data Type: VARCHAR
		Column: first_deferment, Data Type: VARCHAR
		Column: alcoholic_beverage_adjusted_pct, Data Type: DECIMAL
		Column: broker_dt, Data Type: VARCHAR
		Column: excise_tax_rate_val, Data Type: DECIMAL
		Column: consignor_specified_qty, Data Type: VARCHAR
		Column: broker_declarant_nr, Data Type: VARCHAR
		Column: cds_acceptance_tmsp, Data Type: TIMESTAMP_WITH_LOCAL_TIME_ZONE
		Column: broker_declarant_name, Data Type: VARCHAR
		Column: alcoholic_beverage_volume_qty, Data Type: DECIMAL
		Column: customs_product_descr, Data Type: VARCHAR
		Column: item_tariff_qty, Data Type: DECIMAL
		Column: item_piece_cnt, Data Type: DECIMAL
		Column: acceptance_tmsp, Data Type: TIMESTAMP_WITH_LOCAL_TIME_ZONE
		Column: cds_clearance_tmsp, Data Type: TIMESTAMP_WITH_LOCAL_TIME_ZONE
		Column: additional_cd, Data Type: VARCHAR
		Column: consignor_commodity_code_nr, Data Type: VARCHAR
		Column: cds_document_codes_txt, Data Type: VARCHAR
		Column: consignor_invoice_amount_val, Data Type: VARCHAR
		Column: cds_invoice_curr_cd, Data Type: VARCHAR
		Column: cds_net_mass_meas, Data Type: VARCHAR
		Column: consignor_product_missing_cnt, Data Type: VARCHAR
		Column: consignor_trader_reference_missing_cnt, Data Type: VARCHAR
		Column: different_invoice_curr_cnt, Data Type: VARCHAR
		Column: incoterm_cd, Data Type: VARCHAR
		Column: different_country_of_origin_cnt, Data Type: VARCHAR
		Column: broker_product_missing_cnt, Data Type: VARCHAR
		Column: invalid_consignor_cnt, Data Type: VARCHAR
		Column: different_invoice_amount_cnt, Data Type: VARCHAR
		Column: consignor_net_mass_meas, Data Type: VARCHAR
		Column: broker_commodity_code_nr, Data Type: VARCHAR
		Column: broker_country_of_origin_cd, Data Type: VARCHAR
		Column: different_net_mass_cnt, Data Type: VARCHAR
		Column: missing_document_codes_txt, Data Type: VARCHAR
		Column: consignor_country_of_origin_cd, Data Type: VARCHAR
		Column: broker_trader_reference_missing_cnt, Data Type: VARCHAR
		Column: consignor_invoice_curr_cd, Data Type: VARCHAR
		Column: invalid_importer_cnt, Data Type: VARCHAR
		Column: correct_line_cnt, Data Type: VARCHAR
		Column: missing_document_codes_cnt, Data Type: VARCHAR
		Column: consignor_origin_country_location_sid, Data Type: VARCHAR
		Column: invalid_incoterm_cnt, Data Type: VARCHAR
		Column: broker_origin_country_location_sid, Data Type: VARCHAR
		Column: consignor_document_codes_txt, Data Type: VARCHAR
		Column: different_commodity_code_cnt, Data Type: VARCHAR
		Column: cds_invoice_amount_val, Data Type: VARCHAR
		Column: cds_clearance_dt, Data Type: DATE
		Column: broker_declarant_party_cd, Data Type: VARCHAR
		Column: broker_declarant_party_key_type_cd, Data Type: VARCHAR
		Column: second_supplementary_cd, Data Type: VARCHAR
		Column: vat_val, Data Type: DECIMAL
		Column: vat_paid_val, Data Type: DECIMAL
		Column: document_references, Data Type: VARCHAR
		Column: declaration_part_number, Data Type: VARCHAR
		Column: duty_secured_val, Data Type: DECIMAL
		Column: duty_suspended_val, Data Type: DECIMAL
		Column: supplementary_units_qty, Data Type: DECIMAL
		Column: additional_special_cpc_codes, Data Type: VARCHAR
		Column: net_mass_qty, Data Type: DECIMAL
		Column: inventory_ucr, Data Type: VARCHAR
		Column: first_supplementary_cd, Data Type: VARCHAR
		Column: item_price, Data Type: DECIMAL
		Column: customs_valuation_method_id, Data Type: DECIMAL
		Column: goods_descr, Data Type: VARCHAR
		Column: customs_product_name, Data Type: VARCHAR
		Column: parent_product_sid, Data Type: DECIMAL
		Column: customs_additional_cd, Data Type: VARCHAR
		Column: parent_product_name, Data Type: VARCHAR
		Column: alcoholic_beverage_duty_per_unit_val, Data Type: DECIMAL
		Column: preferential_origin_fg, Data Type: BOOLEAN
		Column: customs_product_type_descr, Data Type: VARCHAR
		Column: alcoholic_beverage_tax_rate_cd, Data Type: VARCHAR
		Column: customs_product_type_cd, Data Type: VARCHAR
*/
-- and br.cds_clearance_dt=trunc(to_timestamp(hd.clearance_date), 'dd')

-- trunc(to_timestamp(hd.clearance_date), 'dd') clearance_date,

/* left
         join(select entry_identifier as movement_ref_number
                from SZD_PRODUCTION.etl.t_cache_cds_header
               group
                  by 1
              having count(*) > 1

/*select movement_ref_number
                from SZD_PRODUCTION.core_rel.t_customs_clearance_report
               group
                  by 1
              having count(*) > 1
             ) nu
           on hd.entry_identifier = nu.movement_ref_number */
/* and year(br.cds_clearance_dt)= year(case when substring(trim(hd.clearance_date),3,1)='/' then 
                  to_date(substring(hd.clearance_date,1,10), 'DD/MM/YYYY')
                  else to_date(substring(hd.clearance_date,1,10), 'YYYY-MM-DD') end)
          and  month(br.cds_clearance_dt)= month(case when substring(trim(hd.clearance_date),3,1)='/' then 
                  to_date(substring(hd.clearance_date,1,10), 'DD/MM/YYYY')
                  else to_date(substring(hd.clearance_date,1,10), 'YYYY-MM-DD') end) */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, customs_procedure_cd,
 item_position, movement_ref_number, customs_product_sid, customs_tariff_code_cd, customs_classification_scheme_cd,
 duty_paid_val, clearance_dt, customs_preference_cd, origin_country_location_sid, customs_val, trader_reference,
 second_supplementary_cd, vat_val, vat_paid_val, document_references, declaration_part_number, duty_secured_val,
 duty_suspended_val, supplementary_units_qty, additional_special_cpc_codes, net_mass_qty, inventory_ucr,
 first_supplementary_cd, item_price, customs_valuation_method_id, goods_descr)
(SELECT DISTINCT COALESCE(dwh_src_file_name, 'na') AS dwh_src_file_name,
  0 AS tf_error_fg,
  COALESCE(dwh_src_1_tmsp, CURRENT_TIMESTAMP()) AS dwh_src_tmsp,
   0 <> 0 AS deleted_fg,
   1 <> 0 AS dwh_valid_fg,
  CAST(0 AS STRING) AS record_id,
  COALESCE(dwh_src_1_tmsp, CURRENT_TIMESTAMP()) AS dwh_mapping_tmsp,
  COALESCE(dwh_src_file_name, 'na') AS filename,
  cpc AS customs_procedure_cd,
  item_number AS item_position,
  entry_identifier AS movement_ref_number,
  customs_product_sid,
  commodity_code,
   CASE
   WHEN commodity_code <> '-1'
   THEN 'CTC_GB'
   ELSE '-1'
   END AS customs_classification_scheme_cd,
  duty_paid AS duty_paid_val,
  clearance_date,
  COALESCE(NULLIF(preference, 'NULL'), '-1') AS customs_preference_cd,
  location_sid AS origin_country_location_sid,
  customs_value AS customs_val,
  trader_reference,
  NULLIF(supplementary_commodity_2, 'NULL') AS second_supplementary_cd,
  vat_value AS vat_val,
  vat_paid AS vat_paid_val,
  NULLIF(document_references, 'NULL') AS document_references,
  NULLIF(declaration_part_mumber, 'NULL') AS declaration_part_number,
  duty_secured AS duty_secured_val,
  duty_suspended AS duty_suspended_val,
  supplementary_units AS supplementary_units_qty,
  NULLIF(additional_special_procedure_codes, 'NULL') AS additional_special_cpc_codes,
  net_mass AS net_mass_qty,
  NULLIF(mucr, 'NULL') AS inventory_ucr,
  NULLIF(supplementary_commodity_1, 'NULL') AS first_supplementary_cd,
  item_price,
  COALESCE(ROUND(SAFE_CAST(valuation_method AS BIGNUMERIC), 0), - 1) AS customs_valuation_method_id,
  TRIM(SUBSTR(NULLIF(goods_description, 'NULL'), 1, 250)) AS goods_descr
 FROM (SELECT DISTINCT COALESCE(NULLIF(hd.declarant_reference, 'NULL'), NULLIF(br.trader_reference, 'NULL')) AS
    trader_reference,
    DATE(SUBSTR(hd.clearance_date, 1, 10)) AS clearance_date,
    COALESCE(br.customs_product_sid, - 1) AS customs_product_sid,
     CASE
     WHEN NULLIF(ci.commodity_code, 'NULL') IS NOT NULL
     THEN LPAD(SUBSTR(REPLACE(ci.commodity_code, ' ', ''), 1, 10), 10, '0')
     ELSE '-1'
     END AS commodity_code,
    ci.country_of_origin,
    ci.entry_identifier,
    ci.item_number,
    ci.preference,
    ci.valuation_method,
    ci.cpc,
    ci.additional_special_procedure_codes,
    ci.supplementary_commodity_1,
    ci.supplementary_commodity_2,
    ci.mucr,
    ci.declaration_part_mumber,
    ROUND(SAFE_CAST(ci.item_price AS BIGNUMERIC), 5) AS item_price,
    ROUND(SAFE_CAST(ci.customs_value AS BIGNUMERIC), 5) AS customs_value,
    ROUND(SAFE_CAST(ci.duty_paid AS BIGNUMERIC), 5) AS duty_paid,
    ROUND(SAFE_CAST(ci.vat_value AS BIGNUMERIC), 5) AS vat_value,
    ROUND(SAFE_CAST(ci.vat_paid AS BIGNUMERIC), 5) AS vat_paid,
    ROUND(SAFE_CAST(ci.duty_suspended AS BIGNUMERIC), 5) AS duty_suspended,
    ROUND(SAFE_CAST(ci.duty_secured AS BIGNUMERIC), 5) AS duty_secured,
    ROUND(SAFE_CAST(ci.net_mass AS BIGNUMERIC), 5) AS net_mass,
    ROUND(SAFE_CAST(ci.supplementary_units AS BIGNUMERIC), 5) AS supplementary_units,
    COALESCE(NULLIF(lk.location_sid, - 1), NULLIF(lk1.location_sid, - 1), - 1) AS location_sid,
    ci.goods_description,
    ci.document_references,
    ci.dwh_src_file_name,
    ci.dwh_src_1_tmsp,
     CASE
     WHEN hd.declarant_reference = br.trader_reference
     THEN 1
     WHEN hd.declarant_reference = br.invoice_number
     THEN 2
     WHEN br.declaration_ucr LIKE '%' || hd.declarant_reference || '%'
     THEN 3
     WHEN ABS(DATE_DIFF(CASE
         WHEN SUBSTR(SUBSTR(CAST(br.cds_clearance_dt AS STRING), 1, 20), 2, 1) = '/'
         THEN DATE_TRUNC(DATE(SUBSTR(SUBSTR(CAST(br.cds_clearance_dt AS STRING), 1, 20), 1, 10)), DD)
         WHEN SUBSTR(SUBSTR(CAST(br.cds_clearance_dt AS STRING), 1, 20), 5, 1) = '-'
         THEN DATE_TRUNC(DATE(SUBSTR(SUBSTR(CAST(br.cds_clearance_dt AS STRING), 1, 20), 1, 10)), DD)
         ELSE NULL
         END, CASE
         WHEN SUBSTR(hd.clearance_date, 2, 1) = '/'
         THEN DATE_TRUNC(DATE(SUBSTR(hd.clearance_date, 1, 10)), DD)
         WHEN SUBSTR(hd.clearance_date, 5, 1) = '-'
         THEN DATE_TRUNC(DATE(SUBSTR(hd.clearance_date, 1, 10)), DD)
         ELSE NULL
         END, DAY)) < 2
     THEN 4
     ELSE NULL
     END AS rn
   FROM szd_production_etl.t_cache_cds_item AS ci
    INNER JOIN szd_production_etl.t_cache_cds_header AS hd ON ci.entry_identifier = hd.entry_identifier AND DATE(SUBSTR(hd
        .clearance_date, 1, 10)) = DATE(SUBSTR(ci.clearance_date, 1, 10))
    LEFT JOIN szd_production_meta.t_location_key AS lk ON lk.location_key_type_cd = 'COUNTRY' AND lk.location_nat_key_nr
       = COALESCE(NULLIF(ci.country_of_origin, 'NULL'), '-1')
    LEFT JOIN szd_production_meta.t_location_key AS lk1 ON lk1.location_key_type_cd = 'COUNTRY' AND lk1.location_nat_key_nr
       = COALESCE(NULLIF(ci.preferential_country_of_origin, 'NULL'), '-1')
    LEFT JOIN (SELECT DISTINCT br.movement_ref_number,
      br.trader_reference,
      br.cds_clearance_dt,
      brl.item_position,
      brl.customs_product_sid,
      brl.invoice_number,
      br.declaration_ucr,
      COALESCE(NULLIF(brl.non_preferential_country_location_sid, - 1), brl.preferential_country_location_sid) AS
      origin_country_location_sid
     FROM szd_production_core_rel.t_broker_report AS br
      INNER JOIN szd_production_core_rel.t_broker_report_line AS brl ON br.movement_ref_number = brl.movement_ref_number
         AND br.trader_reference = brl.trader_reference) AS br ON ci.entry_identifier = br.movement_ref_number AND (ABS(DATE_DIFF(CASE
               WHEN SUBSTR(SUBSTR(CAST(br.cds_clearance_dt AS STRING), 1, 20), 3, 1) = '/'
               THEN DATE_TRUNC(DATE(SUBSTR(SUBSTR(CAST(br.cds_clearance_dt AS STRING), 1, 20), 1, 10)), DD)
               WHEN SUBSTR(SUBSTR(CAST(br.cds_clearance_dt AS STRING), 1, 20), 5, 1) = '-'
               THEN DATE_TRUNC(DATE(SUBSTR(SUBSTR(CAST(br.cds_clearance_dt AS STRING), 1, 20), 1, 10)), DD)
               ELSE NULL
               END, CASE
               WHEN SUBSTR(hd.clearance_date, 3, 1) = '/'
               THEN DATE_TRUNC(DATE(SUBSTR(hd.clearance_date, 1, 10)), DD)
               WHEN SUBSTR(hd.clearance_date, 5, 1) = '-'
               THEN DATE_TRUNC(DATE(SUBSTR(hd.clearance_date, 1, 10)), DD)
               ELSE NULL
               END, DAY)) < 2 OR hd.declarant_reference = br.trader_reference OR hd.declarant_reference = br.invoice_number
            OR br.declaration_ucr LIKE '%' || hd.declarant_reference || '%') AND CAST(ci.item_number AS FLOAT64) = br.item_position
        AND COALESCE(NULLIF(lk.location_sid, - 1), NULLIF(lk1.location_sid, - 1), - 1) = br.origin_country_location_sid
   WHERE hd.declaration_category IN ('IMD', 'IMA', 'IMY')
    AND ci.declaration_category IN ('IMD', 'IMA', 'IMY')) AS ci
 WHERE NULLIF(entry_identifier, 'NULL') IS NOT NULL
  AND NULLIF(trader_reference, 'NULL') IS NOT NULL
  AND item_number IS NOT NULL
 QUALIFY (ROW_NUMBER() OVER (PARTITION BY entry_identifier, trader_reference, item_number ORDER BY rn IS NULL, rn)) = 1
 );