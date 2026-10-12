
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, country_of_origin, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename,
 customs_procedure_cd, item_position, movement_ref_number, customs_tariff_code_cd, customs_classification_scheme_cd,
 customs_preference_cd, trader_reference, net_mass_meas, gross_mass_meas, excise_payment_amount_val, item_tariff_qty,
 item_piece_cnt, alcoholic_beverage_tax_rate_cd, abv_pct, commodity_code, item_tariff_qty_uom_id,
 vat_tax_assessed_amount_val, duty_payment_amount_val, duty_excise_rate_txt, customer_product_number,
 authority_country_location_key_type_cd, non_preferential_country_location_key_type_cd, product_number,
 vat_payment_amount_val, non_preferential_country_location_id, preferential_country_location_id, value_for_vat_val,
 item_descr, customs_product_key_type_cd, invoice_number, preferential_country_location_key_type_cd, supplementary_cd,
 authority_country_location_id, value_for_duty_val, additional_code, charge_amount_val, charge_amount_curr_cd,
 documents_txt)
(SELECT dwh_src_file_name0 AS dwh_src_file_name,
  0,
  country_of_origin,
  dwh_src_1_tmsp0 AS dwh_src_1_tmsp,
   0 <> 0,
   1 <> 0,
  CAST(0 AS STRING),
  dwh_src_1_tmsp AS dwh_src_1_tmsp7,
  dwh_src_file_name AS dwh_src_file_name8,
  customs_procedure_cd,
  item_position,
  movement_ref_number,
  customs_tariff_code_cd,
  customs_classification_scheme_cd,
  customs_preference_cd,
  trader_reference,
  net_mass_meas,
  gross_mass_meas,
  excise_payment_amount_val,
  item_tariff_qty,
  item_piece_cnt,
  alcoholic_beverage_tax_rate_cd,
  CAST(abv_pct AS STRING) AS abv_pct,
  commodity_code,
  item_tariff_qty_uom_id,
  vat_tax_assessed_amount_val,
  duty_payment_amount_val,
  duty_excise_rate_txt,
  customer_product_number,
  authority_country_location_key_type_cd,
  non_preferential_country_location_key_type_cd,
  product_number,
  vat_payment_amount_val,
  non_preferential_country_location_id,
  preferential_country_location_id,
  value_for_vat_val,
  item_descr,
  customs_product_key_type_cd,
  invoice_number,
  preferential_country_location_key_type_cd,
  supplementary_cd,
  authority_country_location_id,
  value_for_duty_val,
  additional_code,
  charge_amount_val,
  charge_amount_curr_cd,
  documents_txt
 FROM (SELECT movement_ref_number,
     item_position,
     authority_country_location_id,
     authority_country_location_key_type_cd,
     customs_procedure_cd,
     customs_classification_scheme_cd,
     customs_tariff_code_cd,
     customs_preference_cd,
     non_preferential_country_location_id,
     non_preferential_country_location_key_type_cd,
     preferential_country_location_id,
     preferential_country_location_key_type_cd,
     product_number,
     additional_code,
     commodity_code,
     country_of_origin,
     customs_product_key_type_cd,
     invoice_number,
     gross_mass_meas,
     net_mass_meas,
     charge_amount_curr_cd,
     charge_amount_val,
     item_descr,
     abv_pct,
     item_piece_cnt,
     item_tariff_qty_uom_id,
     item_tariff_qty,
     alcoholic_beverage_tax_rate_cd,
     duty_excise_rate_txt,
     excise_payment_amount_val,
     value_for_duty_val,
     duty_payment_amount_val,
     value_for_vat_val,
     vat_payment_amount_val,
     vat_tax_assessed_amount_val,
     supplementary_cd,
     documents_txt,
     customer_product_number,
     trader_reference,
     dwh_src_1_tmsp,
     0,
     1,
     0,
     0,
     dwh_src_file_name,
     dwh_src_file_name0,
     dwh_src_1_tmsp0
    FROM (SELECT mrn AS movement_ref_number,
        ROUND(SAFE_CAST(item_sequence_number AS BIGNUMERIC), 0) AS item_position,
        'GB' AS authority_country_location_id,
        'COUNTRY' AS authority_country_location_key_type_cd,
          LPAD(item_government_procedure_current_code, 2, '0') || LPAD(item_government_procedure_previous_code, 2, '0')
         || LPAD(item_government_procedure_current_code_special, 3, '0') AS customs_procedure_cd,
        'CTC_GB' AS customs_classification_scheme_cd,
        LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
        COALESCE(item_preference, '-1') AS customs_preference_cd,
        COALESCE(NULLIF(item_non_preferential_country_code, 'NULL'), '-1') AS non_preferential_country_location_id,
        'COUNTRY' AS non_preferential_country_location_key_type_cd,
        COALESCE(NULLIF(item_preferential_country_code, 'NULL'), '-1') AS preferential_country_location_id,
        'COUNTRY' AS preferential_country_location_key_type_cd,
         CASE
         WHEN ROUND(SAFE_CAST(CASE
            WHEN CASE
              WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
              THEN 0
              ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
              END > 0
            THEN TRIM(SUBSTR(item_product, 0, CASE
                WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                THEN 0
                ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                END - 1))
            ELSE TRIM(item_product)
            END AS BIGNUMERIC), 0) IS NULL
         THEN '-1'
         ELSE CASE
          WHEN CASE
            WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
            THEN 0
            ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
            END > 0
          THEN TRIM(SUBSTR(item_product, 0, CASE
              WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
              THEN 0
              ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
              END - 1))
          ELSE TRIM(item_product)
          END
         END AS product_number,
        TRIM(CASE
          WHEN CASE
            WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
            THEN 0
            ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
            END > 0
          THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
          ELSE ''
          END) AS additional_code,
        TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) AS commodity_code,
        TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code), 'NULL'), TRIM(item_preferential_country_code)))
        AS country_of_origin,
        'CUSTOMS_PRODUCT' AS customs_product_key_type_cd,
        COALESCE(NULLIF(item_invoice_number, 'NULL'), '-1') AS invoice_number,
        COALESCE(ROUND(SAFE_CAST(item_gross_mass_measure AS BIGNUMERIC), 6), 0) AS gross_mass_meas,
        COALESCE(ROUND(SAFE_CAST(item_net_weight_measure AS BIGNUMERIC), 6), 0) AS net_mass_meas,
        COALESCE(item_charge_amount_currency, '-1') AS charge_amount_curr_cd,
        COALESCE(ROUND(SAFE_CAST(item_charge_amount AS BIGNUMERIC), 6), 0) AS charge_amount_val,
        SUBSTR(COALESCE(item_description, 'Unknown'), 1, 250) AS item_descr,
        ROUND(SAFE_CAST(abv_pct AS NUMERIC), 5) AS abv_pct,
        COALESCE(ROUND(SAFE_CAST(item_pieces AS BIGNUMERIC), 0), 0) AS item_piece_cnt,
         CASE
         WHEN item_tariff_quantity_unit_code = 'LTR'
         THEN 29
         WHEN item_tariff_quantity_unit_code = 'KGM'
         THEN 10
         WHEN item_tariff_quantity_unit_code = 'NAR'
         THEN 26
         WHEN item_tariff_quantity_unit_code = 'LPA'
         THEN 24
         WHEN item_tariff_quantity_unit_code = 'NPR'
         THEN 27
         WHEN item_tariff_quantity_unit_code = 'MIL'
         THEN 25
         WHEN item_tariff_quantity_unit_code = 'HTL'
         THEN 28
         ELSE - 1
         END AS item_tariff_qty_uom_id,
        COALESCE(ROUND(SAFE_CAST(item_tariff_quantity AS BIGNUMERIC), 6), 0) AS item_tariff_qty,
        COALESCE(NULLIF(item_national_additional_code, 'NULL'), '-1') AS alcoholic_beverage_tax_rate_cd,
        NULLIF(duty_excise_rate, 'NULL') AS duty_excise_rate_txt,
        COALESCE(ROUND(SAFE_CAST(item_excise_payment_amount AS BIGNUMERIC), 6), 0) AS excise_payment_amount_val,
        COALESCE(ROUND(SAFE_CAST(item_value_for_duty AS BIGNUMERIC), 6), 0) AS value_for_duty_val,
        COALESCE(ROUND(SAFE_CAST(item_duty_payment_amount AS BIGNUMERIC), 6), 0) AS duty_payment_amount_val,
        COALESCE(ROUND(SAFE_CAST(item_value_for_vat AS BIGNUMERIC), 6), 0) AS value_for_vat_val,
        COALESCE(ROUND(SAFE_CAST(item_vat_payment_amount AS BIGNUMERIC), 6), 0) AS vat_payment_amount_val,
        COALESCE(ROUND(SAFE_CAST(item_vat_tax_assessed_amount AS BIGNUMERIC), 6), 0) AS vat_tax_assessed_amount_val,
        NULLIF(item_taric_additional_code, 'NULL') AS supplementary_cd,
        NULLIF(documents, 'NULL') AS documents_txt,
         CASE
         WHEN CASE
           WHEN ROUND(SAFE_CAST(CASE
              WHEN CASE
                WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                THEN 0
                ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                END > 0
              THEN TRIM(SUBSTR(item_product, 0, CASE
                  WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                  THEN 0
                  ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                  END - 1))
              ELSE TRIM(item_product)
              END AS BIGNUMERIC), 0) IS NULL
           THEN '-1'
           ELSE CASE
            WHEN CASE
              WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
              THEN 0
              ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
              END > 0
            THEN TRIM(SUBSTR(item_product, 0, CASE
                WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                THEN 0
                ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                END - 1))
            ELSE TRIM(item_product)
            END
           END = '-1'
         THEN '-1'
         WHEN TRIM(CASE
            WHEN CASE
              WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
              THEN 0
              ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
              END > 0
            THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
            ELSE ''
            END) = '-1'
         THEN '-1'
         WHEN TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) = '-1'
         THEN '-1'
         WHEN TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code), 'NULL'), TRIM(item_preferential_country_code
             ))) = '-1'
         THEN '-1'
         ELSE CASE
                WHEN ROUND(SAFE_CAST(CASE
                   WHEN CASE
                     WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                     THEN 0
                     ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                     END > 0
                   THEN TRIM(SUBSTR(item_product, 0, CASE
                       WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                       THEN 0
                       ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                       END - 1))
                   ELSE TRIM(item_product)
                   END AS BIGNUMERIC), 0) IS NULL
                THEN '-1'
                ELSE CASE
                 WHEN CASE
                   WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                   THEN 0
                   ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                   END > 0
                 THEN TRIM(SUBSTR(item_product, 0, CASE
                     WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                     THEN 0
                     ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                     END - 1))
                 ELSE TRIM(item_product)
                 END
                END || '|' || TRIM(CASE
                WHEN CASE
                  WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                  THEN 0
                  ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                  END > 0
                THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
                ELSE ''
                END) || '|' || TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) || '|' || TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code
              ), 'NULL'), TRIM(item_preferential_country_code)))
         END AS customer_product_number,
        trader_reference,
        dwh_src_1_tmsp,
        0,
        1,
        0,
        0,
        dwh_src_file_name,
        dwh_src_file_name AS dwh_src_file_name0,
        dwh_src_1_tmsp AS dwh_src_1_tmsp0
       FROM szd_production_etl.t_cache_ceva
       WHERE job_type_code IN ('IMY', 'IMA', 'IMD')
       UNION ALL
       SELECT mrn AS movement_ref_number,
        ROUND(SAFE_CAST(item_sequence_number AS BIGNUMERIC), 0) AS item_position,
        'GB' AS authority_country_location_id,
        'COUNTRY' AS authority_country_location_key_type_cd,
          LPAD(item_government_procedure_current_code, 2, '0') || LPAD(item_government_procedure_previous_code, 2, '0')
         || LPAD(item_government_procedure_current_code_special, 3, '0') AS customs_procedure_cd,
        'CTC_GB' AS customs_classification_scheme_cd,
        LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
        COALESCE(item_preference, '-1') AS customs_preference_cd,
        COALESCE(NULLIF(item_non_preferential_country_code, 'NULL'), '-1') AS non_preferential_country_location_id,
        'COUNTRY' AS non_preferential_country_location_key_type_cd,
        COALESCE(NULLIF(item_preferential_country_code, 'NULL'), '-1') AS preferential_country_location_id,
        'COUNTRY' AS preferential_country_location_key_type_cd,
         CASE
         WHEN ROUND(SAFE_CAST(CASE
            WHEN CASE
              WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
              THEN 0
              ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
              END > 0
            THEN TRIM(SUBSTR(item_product, 0, CASE
                WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                THEN 0
                ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                END - 1))
            ELSE TRIM(item_product)
            END AS BIGNUMERIC), 0) IS NULL
         THEN '-1'
         ELSE CASE
          WHEN CASE
            WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
            THEN 0
            ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
            END > 0
          THEN TRIM(SUBSTR(item_product, 0, CASE
              WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
              THEN 0
              ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
              END - 1))
          ELSE TRIM(item_product)
          END
         END AS product_number,
        TRIM(CASE
          WHEN CASE
            WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
            THEN 0
            ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
            END > 0
          THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
          ELSE ''
          END) AS additional_code,
        TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) AS commodity_code,
        TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code), 'NULL'), TRIM(item_preferential_country_code)))
        AS country_of_origin,
        'CUSTOMS_PRODUCT' AS customs_product_key_type_cd,
        COALESCE(NULLIF(item_invoice_number, 'NULL'), '-1') AS invoice_number,
        COALESCE(ROUND(SAFE_CAST(item_gross_mass_measure AS BIGNUMERIC), 6), 0) AS gross_mass_meas,
        COALESCE(ROUND(SAFE_CAST(item_net_weight_measure AS BIGNUMERIC), 6), 0) AS net_mass_meas,
        COALESCE(item_charge_amount_currency, '-1') AS charge_amount_curr_cd,
        COALESCE(ROUND(SAFE_CAST(item_charge_amount AS BIGNUMERIC), 6), 0) AS charge_amount_val,
        SUBSTR(COALESCE(item_description, 'Unknown'), 1, 250) AS item_descr,
        ROUND(SAFE_CAST(abv_pct AS NUMERIC), 5) AS abv_pct,
        COALESCE(ROUND(SAFE_CAST(item_pieces AS BIGNUMERIC), 0), 0) AS item_piece_cnt,
         CASE
         WHEN item_tariff_quantity_unit_code = 'LTR'
         THEN 29
         WHEN item_tariff_quantity_unit_code = 'KGM'
         THEN 10
         WHEN item_tariff_quantity_unit_code = 'NAR'
         THEN 26
         WHEN item_tariff_quantity_unit_code = 'LPA'
         THEN 24
         WHEN item_tariff_quantity_unit_code = 'NPR'
         THEN 27
         WHEN item_tariff_quantity_unit_code = 'MIL'
         THEN 25
         WHEN item_tariff_quantity_unit_code = 'HTL'
         THEN 28
         ELSE - 1
         END AS item_tariff_qty_uom_id,
        COALESCE(ROUND(SAFE_CAST(item_tariff_quantity AS BIGNUMERIC), 6), 0) AS item_tariff_qty,
        COALESCE(NULLIF(item_national_additional_code, 'NULL'), '-1') AS alcoholic_beverage_tax_rate_cd,
        NULLIF(duty_excise_rate, 'NULL') AS duty_excise_rate_txt,
        COALESCE(ROUND(SAFE_CAST(item_excise_payment_amount AS BIGNUMERIC), 6), 0) AS excise_payment_amount_val,
        COALESCE(ROUND(SAFE_CAST(item_value_for_duty AS BIGNUMERIC), 6), 0) AS value_for_duty_val,
        COALESCE(ROUND(SAFE_CAST(item_duty_payment_amount AS BIGNUMERIC), 6), 0) AS duty_payment_amount_val,
        COALESCE(ROUND(SAFE_CAST(item_value_for_vat AS BIGNUMERIC), 6), 0) AS value_for_vat_val,
        COALESCE(ROUND(SAFE_CAST(item_vat_payment_amount AS BIGNUMERIC), 6), 0) AS vat_payment_amount_val,
        COALESCE(ROUND(SAFE_CAST(item_vat_tax_assessed_amount AS BIGNUMERIC), 6), 0) AS item_vat_tax_assessed_amount,
        NULLIF(item_taric_additional_code, 'NULL') AS supplementary_cd,
        NULLIF(documents, 'NULL') AS documents_txt,
         CASE
         WHEN CASE
           WHEN ROUND(SAFE_CAST(CASE
              WHEN CASE
                WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                THEN 0
                ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                END > 0
              THEN TRIM(SUBSTR(item_product, 0, CASE
                  WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                  THEN 0
                  ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                  END - 1))
              ELSE TRIM(item_product)
              END AS BIGNUMERIC), 0) IS NULL
           THEN '-1'
           ELSE CASE
            WHEN CASE
              WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
              THEN 0
              ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
              END > 0
            THEN TRIM(SUBSTR(item_product, 0, CASE
                WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                THEN 0
                ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                END - 1))
            ELSE TRIM(item_product)
            END
           END = '-1'
         THEN '-1'
         WHEN TRIM(CASE
            WHEN CASE
              WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
              THEN 0
              ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
              END > 0
            THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
            ELSE ''
            END) = '-1'
         THEN '-1'
         WHEN TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) = '-1'
         THEN '-1'
         WHEN TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code), 'NULL'), TRIM(item_preferential_country_code
             ))) = '-1'
         THEN '-1'
         ELSE CASE
                WHEN ROUND(SAFE_CAST(CASE
                   WHEN CASE
                     WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                     THEN 0
                     ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                     END > 0
                   THEN TRIM(SUBSTR(item_product, 0, CASE
                       WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                       THEN 0
                       ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                       END - 1))
                   ELSE TRIM(item_product)
                   END AS BIGNUMERIC), 0) IS NULL
                THEN '-1'
                ELSE CASE
                 WHEN CASE
                   WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                   THEN 0
                   ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                   END > 0
                 THEN TRIM(SUBSTR(item_product, 0, CASE
                     WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                     THEN 0
                     ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                     END - 1))
                 ELSE TRIM(item_product)
                 END
                END || '|' || TRIM(CASE
                WHEN CASE
                  WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                  THEN 0
                  ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                  END > 0
                THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
                ELSE ''
                END) || '|' || TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) || '|' || TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code
              ), 'NULL'), TRIM(item_preferential_country_code)))
         END AS customer_product_number,
        trader_reference,
        dwh_src_1_tmsp,
        0,
        1,
        0,
        0,
        dwh_src_file_name,
        dwh_src_file_name AS dwh_src_file_name0,
        dwh_src_1_tmsp AS dwh_src_1_tmsp0
       FROM szd_production_etl.t_cache_maersk_lgb
       WHERE job_type_code IN ('IMY', 'IMA', 'IMD')) AS t3
    UNION ALL
    SELECT mrn AS movement_ref_number,
     ROUND(SAFE_CAST(item_sequence_number AS BIGNUMERIC), 0) AS item_position,
     'GB' AS authority_country_location_id,
     'COUNTRY' AS authority_country_location_key_type_cd,
       LPAD(item_government_procedure_current_code, 2, '0') || LPAD(item_government_procedure_previous_code, 2, '0') ||
      LPAD(item_government_procedure_current_code_special, 3, '0') AS customs_procedure_cd,
     'CTC_GB' AS customs_classification_scheme_cd,
     LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0') AS customs_tariff_code_cd,
     COALESCE(item_preference, '-1') AS customs_preference_cd,
     COALESCE(NULLIF(item_non_preferential_country_code, 'NULL'), '-1') AS non_preferential_country_location_id,
     'COUNTRY' AS non_preferential_country_location_key_type_cd,
     COALESCE(NULLIF(item_preferential_country_code, 'NULL'), '-1') AS preferential_country_location_id,
     'COUNTRY' AS preferential_country_location_key_type_cd,
      CASE
      WHEN ROUND(SAFE_CAST(CASE
         WHEN CASE
           WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
           THEN 0
           ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
           END > 0
         THEN TRIM(SUBSTR(item_product, 0, CASE
             WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
             THEN 0
             ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
             END - 1))
         ELSE TRIM(item_product)
         END AS BIGNUMERIC), 0) IS NULL
      THEN '-1'
      ELSE CASE
       WHEN CASE
         WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
         THEN 0
         ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
         END > 0
       THEN TRIM(SUBSTR(item_product, 0, CASE
           WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
           THEN 0
           ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
           END - 1))
       ELSE TRIM(item_product)
       END
      END AS product_number,
     TRIM(CASE
       WHEN CASE
         WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
         THEN 0
         ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
         END > 0
       THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
       ELSE ''
       END) AS additional_code,
     TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) AS commodity_code,
     TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code), 'NULL'), TRIM(item_preferential_country_code))) AS
     country_of_origin,
     'CUSTOMS_PRODUCT' AS customs_product_key_type_cd,
     COALESCE(NULLIF(item_invoice_number, 'NULL'), '-1') AS invoice_number,
     COALESCE(ROUND(SAFE_CAST(item_gross_mass_measure AS BIGNUMERIC), 6), 0) AS gross_mass_meas,
     COALESCE(ROUND(SAFE_CAST(item_net_weight_measure AS BIGNUMERIC), 6), 0) AS net_mass_meas,
     COALESCE(item_charge_amount_currency, '-1') AS charge_amount_curr_cd,
     COALESCE(ROUND(SAFE_CAST(item_charge_amount AS BIGNUMERIC), 6), 0) AS charge_amount_val,
     SUBSTR(COALESCE(item_description, 'Unknown'), 1, 250) AS item_descr,
     ROUND(SAFE_CAST(abv_pct AS NUMERIC), 5) AS abv_pct,
     COALESCE(ROUND(SAFE_CAST(item_pieces AS BIGNUMERIC), 0), 0) AS item_piece_cnt,
      CASE
      WHEN item_tariff_quantity_unit_code = 'LTR'
      THEN 29
      WHEN item_tariff_quantity_unit_code = 'KGM'
      THEN 10
      WHEN item_tariff_quantity_unit_code = 'NAR'
      THEN 26
      WHEN item_tariff_quantity_unit_code = 'LPA'
      THEN 24
      WHEN item_tariff_quantity_unit_code = 'NPR'
      THEN 27
      WHEN item_tariff_quantity_unit_code = 'MIL'
      THEN 25
      WHEN item_tariff_quantity_unit_code = 'HTL'
      THEN 28
      ELSE - 1
      END AS item_tariff_qty_uom_id,
     COALESCE(ROUND(SAFE_CAST(item_tariff_quantity AS BIGNUMERIC), 6), 0) AS item_tariff_qty,
     COALESCE(NULLIF(item_national_additional_code, 'NULL'), '-1') AS alcoholic_beverage_tax_rate_cd,
     NULLIF(duty_excise_rate, 'NULL') AS duty_excise_rate_txt,
     COALESCE(ROUND(SAFE_CAST(item_excise_payment_amount AS BIGNUMERIC), 6), 0) AS excise_payment_amount_val,
     COALESCE(ROUND(SAFE_CAST(item_value_for_duty AS BIGNUMERIC), 6), 0) AS value_for_duty_val,
     COALESCE(ROUND(SAFE_CAST(item_duty_payment_amount AS BIGNUMERIC), 6), 0) AS duty_payment_amount_val,
     COALESCE(ROUND(SAFE_CAST(item_value_for_vat AS BIGNUMERIC), 6), 0) AS value_for_vat_val,
     COALESCE(ROUND(SAFE_CAST(item_vat_payment_amount AS BIGNUMERIC), 6), 0) AS vat_payment_amount_val,
     COALESCE(ROUND(SAFE_CAST(item_vat_tax_assessed_amount AS BIGNUMERIC), 6), 0) AS vat_tax_assessed_amount_val,
     NULLIF(item_taric_additional_code, 'NULL') AS supplementary_cd,
     NULLIF(documents, 'NULL') AS documents_txt,
      CASE
      WHEN CASE
        WHEN ROUND(SAFE_CAST(CASE
           WHEN CASE
             WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
             THEN 0
             ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
             END > 0
           THEN TRIM(SUBSTR(item_product, 0, CASE
               WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
               THEN 0
               ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
               END - 1))
           ELSE TRIM(item_product)
           END AS BIGNUMERIC), 0) IS NULL
        THEN '-1'
        ELSE CASE
         WHEN CASE
           WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
           THEN 0
           ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
           END > 0
         THEN TRIM(SUBSTR(item_product, 0, CASE
             WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
             THEN 0
             ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
             END - 1))
         ELSE TRIM(item_product)
         END
        END = '-1'
      THEN '-1'
      WHEN TRIM(CASE
         WHEN CASE
           WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
           THEN 0
           ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
           END > 0
         THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
         ELSE ''
         END) = '-1'
      THEN '-1'
      WHEN TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) = '-1'
      THEN '-1'
      WHEN TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code), 'NULL'), TRIM(item_preferential_country_code)
         )) = '-1'
      THEN '-1'
      ELSE CASE
             WHEN ROUND(SAFE_CAST(CASE
                WHEN CASE
                  WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                  THEN 0
                  ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                  END > 0
                THEN TRIM(SUBSTR(item_product, 0, CASE
                    WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                    THEN 0
                    ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                    END - 1))
                ELSE TRIM(item_product)
                END AS BIGNUMERIC), 0) IS NULL
             THEN '-1'
             ELSE CASE
              WHEN CASE
                WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                THEN 0
                ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                END > 0
              THEN TRIM(SUBSTR(item_product, 0, CASE
                  WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
                  THEN 0
                  ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
                  END - 1))
              ELSE TRIM(item_product)
              END
             END || '|' || TRIM(CASE
             WHEN CASE
               WHEN STRPOS(SUBSTR(item_product, 0), '_') = 0
               THEN 0
               ELSE STRPOS(SUBSTR(item_product, 0), '_') + -1
               END > 0
             THEN TRIM(SUBSTR(item_product, STRPOS(item_product, '_') + 1, LENGTH(item_product)))
             ELSE ''
             END) || '|' || TRIM(LPAD(SUBSTR(REPLACE(item_commodity_code, ' ', ''), 1, 10), 10, '0')) || '|' || TRIM(COALESCE(NULLIF(TRIM(item_non_preferential_country_code
           ), 'NULL'), TRIM(item_preferential_country_code)))
      END AS customer_product_number,
     trader_reference,
     dwh_src_1_tmsp,
     0,
     1,
     0,
     0,
     dwh_src_file_name,
     dwh_src_file_name AS dwh_src_file_name0,
     dwh_src_1_tmsp AS dwh_src_1_tmsp0
    FROM szd_production_etl.t_cache_maersk_lukt
    WHERE job_type_code IN ('IMY', 'IMA', 'IMD')) AS t7);