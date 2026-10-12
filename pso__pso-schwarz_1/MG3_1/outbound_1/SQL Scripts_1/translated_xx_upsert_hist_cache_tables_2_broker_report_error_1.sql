
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, item_position,
 attribute_value_txt, cds_acceptance_dt, movement_ref_number, attribute_name, broker_declarant_party_cd,
 broker_declarant_party_key_type_cd)
(SELECT dwh_src_file_name,
  tf_error_fg,
  dwh_src_1_tmsp,
   deleted_fg <> 0 AS deleted_fg,
   dwh_valid_fg <> 0 AS dwh_valid_fg,
  CAST(record_id AS STRING) AS record_id,
  dwh_mapping_tmsp,
  filename,
  item_position,
  attribute_value_txt,
  cds_acceptance_dt,
  movement_ref_number,
  attribute_name,
  broker_declarant_party_cd,
  broker_declarant_party_key_type_cd
 FROM ((SELECT DISTINCT movement_ref_number,
      item_position,
      broker_declarant_party_key_type_cd,
      broker_declarant_party_cd,
      COALESCE(cds_acceptance_date, cds_clearance_date, DATE_TRUNC(acceptance_date_time, DD), DATE('1900-01-01')) AS
      cds_acceptance_dt,
       CASE
       WHEN ROUND(SAFE_CAST(COALESCE(total_package_quantity, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Total Packages Quantity'
       WHEN ROUND(SAFE_CAST(COALESCE(excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Excise Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Value for Duty'
       WHEN ROUND(SAFE_CAST(COALESCE(duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Duty Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(duty_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Duty Tax Assessed Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Value for VAT'
       WHEN ROUND(SAFE_CAST(COALESCE(vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'VAT Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(vat_taxassessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'VAT Tax Assessed Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(CASE
           WHEN STRPOS(item_product, '_') > 0
           THEN SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1)
           ELSE item_product
           END, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Product'
       WHEN ROUND(SAFE_CAST(COALESCE(item_gross_mass_measure, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Gross Mass Measure'
       WHEN ROUND(SAFE_CAST(COALESCE(item_net_weight_measure, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Net Weight Measure'
       WHEN ROUND(SAFE_CAST(COALESCE(item_charge_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Charge Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(item_pieces, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Pieces'
       WHEN ROUND(SAFE_CAST(COALESCE(item_tariff_quantity, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Tariff Quantity'
       WHEN ROUND(SAFE_CAST(COALESCE(item_excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Excise Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Value for Duty'
       WHEN ROUND(SAFE_CAST(COALESCE(item_duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Duty Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Value for VAT'
       WHEN ROUND(SAFE_CAST(COALESCE(item_vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'VAT Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(item_vat_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'VAT Tax Assessed Amount'
       ELSE NULL
       END AS attribute_name,
       CASE
       WHEN ROUND(SAFE_CAST(COALESCE(total_package_quantity, '0') AS BIGNUMERIC), 0) IS NULL
       THEN total_package_quantity
       WHEN ROUND(SAFE_CAST(COALESCE(excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN excise_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
       THEN value_for_duty
       WHEN ROUND(SAFE_CAST(COALESCE(duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN duty_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(duty_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN duty_tax_assessed_amount
       WHEN ROUND(SAFE_CAST(COALESCE(value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
       THEN value_for_vat
       WHEN ROUND(SAFE_CAST(COALESCE(vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN vat_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(vat_taxassessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN vat_taxassessed_amount
       WHEN ROUND(SAFE_CAST(COALESCE(CASE
           WHEN STRPOS(item_product, '_') > 0
           THEN SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1)
           ELSE item_product
           END, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_product
       WHEN ROUND(SAFE_CAST(COALESCE(item_gross_mass_measure, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_gross_mass_measure
       WHEN ROUND(SAFE_CAST(COALESCE(item_net_weight_measure, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_net_weight_measure
       WHEN ROUND(SAFE_CAST(COALESCE(item_charge_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_charge_amount
       WHEN ROUND(SAFE_CAST(COALESCE(item_pieces, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_pieces
       WHEN ROUND(SAFE_CAST(COALESCE(item_tariff_quantity, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_tariff_quantity
       WHEN ROUND(SAFE_CAST(COALESCE(item_excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_excise_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_value_for_duty
       WHEN ROUND(SAFE_CAST(COALESCE(item_duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_duty_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_value_for_vat
       WHEN ROUND(SAFE_CAST(COALESCE(item_vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_vat_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(item_vat_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_vat_tax_assessed_amount
       ELSE NULL
       END AS attribute_value_txt,
      dwh_valid_fg,
      dwh_src_file_name,
      dwh_src_1_tmsp,
      dwh_mapping_tmsp,
      tf_error_fg,
      deleted_fg,
      record_id,
      filename
     FROM (SELECT job_type_code,
        mrn AS movement_ref_number,
        COALESCE(item_sequence_number, '-1') AS item_position,
        'BROKER' AS broker_declarant_party_key_type_cd,
        declarant_eori AS broker_declarant_party_cd,
         CASE
         WHEN TRIM(cds_acceptance_date) = '' OR TRIM(cds_acceptance_date) = 'NULL'
         THEN NULL
         ELSE DATE(SUBSTR(cds_acceptance_date, 1, 10))
         END AS cds_acceptance_date,
         CASE
         WHEN TRIM(cds_clearance_date) = '' OR TRIM(cds_clearance_date) = 'NULL'
         THEN NULL
         ELSE DATE(SUBSTR(cds_clearance_date, 1, 10))
         END AS cds_clearance_date,
         CASE
         WHEN TRIM(acceptance_date_time) = '' OR TRIM(acceptance_date_time) = 'NULL'
         THEN NULL
         ELSE DATE(SUBSTR(acceptance_date_time, 1, 10))
         END AS acceptance_date_time,
         CASE
         WHEN TRIM(total_package_quantity) = '' OR TRIM(total_package_quantity) = 'NULL'
         THEN NULL
         ELSE total_package_quantity
         END AS total_package_quantity,
         CASE
         WHEN TRIM(excise_payment_amount) = '' OR TRIM(excise_payment_amount) = 'NULL'
         THEN NULL
         ELSE excise_payment_amount
         END AS excise_payment_amount,
         CASE
         WHEN TRIM(value_for_duty) = '' OR TRIM(value_for_duty) = 'NULL'
         THEN NULL
         ELSE value_for_duty
         END AS value_for_duty,
         CASE
         WHEN TRIM(duty_payment_amount) = '' OR TRIM(duty_payment_amount) = 'NULL'
         THEN NULL
         ELSE duty_payment_amount
         END AS duty_payment_amount,
         CASE
         WHEN TRIM(duty_tax_assessed_amount) = '' OR TRIM(duty_tax_assessed_amount) = 'NULL'
         THEN NULL
         ELSE duty_tax_assessed_amount
         END AS duty_tax_assessed_amount,
         CASE
         WHEN TRIM(value_for_vat) = '' OR TRIM(value_for_vat) = 'NULL'
         THEN NULL
         ELSE value_for_vat
         END AS value_for_vat,
         CASE
         WHEN TRIM(vat_payment_amount) = '' OR TRIM(vat_payment_amount) = 'NULL'
         THEN NULL
         ELSE vat_payment_amount
         END AS vat_payment_amount,
         CASE
         WHEN TRIM(vat_taxassessed_amount) = '' OR TRIM(vat_taxassessed_amount) = 'NULL'
         THEN NULL
         ELSE vat_taxassessed_amount
         END AS vat_taxassessed_amount,
         CASE
         WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
         THEN NULL
         ELSE item_product
         END AS item_product,
         CASE
         WHEN TRIM(item_gross_mass_measure) = '' OR TRIM(item_gross_mass_measure) = 'NULL'
         THEN NULL
         ELSE item_gross_mass_measure
         END AS item_gross_mass_measure,
         CASE
         WHEN TRIM(item_net_weight_measure) = '' OR TRIM(item_net_weight_measure) = 'NULL'
         THEN NULL
         ELSE item_net_weight_measure
         END AS item_net_weight_measure,
         CASE
         WHEN TRIM(item_charge_amount) = '' OR TRIM(item_charge_amount) = 'NULL'
         THEN NULL
         ELSE item_charge_amount
         END AS item_charge_amount,
         CASE
         WHEN TRIM(item_pieces) = '' OR TRIM(item_pieces) = 'NULL'
         THEN NULL
         ELSE item_pieces
         END AS item_pieces,
         CASE
         WHEN TRIM(item_tariff_quantity) = '' OR TRIM(item_tariff_quantity) = 'NULL'
         THEN NULL
         ELSE item_tariff_quantity
         END AS item_tariff_quantity,
         CASE
         WHEN TRIM(item_excise_payment_amount) = '' OR TRIM(item_excise_payment_amount) = 'NULL'
         THEN NULL
         ELSE item_excise_payment_amount
         END AS item_excise_payment_amount,
         CASE
         WHEN TRIM(item_value_for_duty) = '' OR TRIM(item_value_for_duty) = 'NULL'
         THEN NULL
         ELSE item_value_for_duty
         END AS item_value_for_duty,
         CASE
         WHEN TRIM(item_duty_payment_amount) = '' OR TRIM(item_duty_payment_amount) = 'NULL'
         THEN NULL
         ELSE item_duty_payment_amount
         END AS item_duty_payment_amount,
         CASE
         WHEN TRIM(item_value_for_vat) = '' OR TRIM(item_value_for_vat) = 'NULL'
         THEN NULL
         ELSE item_value_for_vat
         END AS item_value_for_vat,
         CASE
         WHEN TRIM(item_vat_payment_amount) = '' OR TRIM(item_vat_payment_amount) = 'NULL'
         THEN NULL
         ELSE item_vat_payment_amount
         END AS item_vat_payment_amount,
         CASE
         WHEN TRIM(item_vat_tax_assessed_amount) = '' OR TRIM(item_vat_tax_assessed_amount) = 'NULL'
         THEN NULL
         ELSE item_vat_tax_assessed_amount
         END AS item_vat_tax_assessed_amount,
        1 AS dwh_valid_fg,
        dwh_src_file_name,
        dwh_src_1_tmsp,
        dwh_src_1_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        dwh_src_file_name AS filename
       FROM szd_production_etl.t_cache_ceva_1
       WHERE job_type_code IN ('IMY', 'IMA', 'IMD')
        AND (ROUND(SAFE_CAST(COALESCE(CASE
                                WHEN TRIM(total_package_quantity) = '' OR TRIM(total_package_quantity) = 'NULL'
                                THEN NULL
                                ELSE total_package_quantity
                                END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                                WHEN TRIM(excise_payment_amount) = '' OR TRIM(excise_payment_amount) = 'NULL'
                                THEN NULL
                                ELSE excise_payment_amount
                                END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                               WHEN TRIM(value_for_duty) = '' OR TRIM(value_for_duty) = 'NULL'
                               THEN NULL
                               ELSE value_for_duty
                               END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                              WHEN TRIM(duty_payment_amount) = '' OR TRIM(duty_payment_amount) = 'NULL'
                              THEN NULL
                              ELSE duty_payment_amount
                              END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                             WHEN TRIM(duty_tax_assessed_amount) = '' OR TRIM(duty_tax_assessed_amount) = 'NULL'
                             THEN NULL
                             ELSE duty_tax_assessed_amount
                             END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                            WHEN TRIM(value_for_vat) = '' OR TRIM(value_for_vat) = 'NULL'
                            THEN NULL
                            ELSE value_for_vat
                            END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                           WHEN TRIM(vat_payment_amount) = '' OR TRIM(vat_payment_amount) = 'NULL'
                           THEN NULL
                           ELSE vat_payment_amount
                           END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                          WHEN TRIM(vat_taxassessed_amount) = '' OR TRIM(vat_taxassessed_amount) = 'NULL'
                          THEN NULL
                          ELSE vat_taxassessed_amount
                          END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                         WHEN STRPOS(CASE
                            WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                            THEN NULL
                            ELSE item_product
                            END, '_') > 0
                         THEN SUBSTR(CASE
                           WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                           THEN NULL
                           ELSE item_product
                           END, 1, STRPOS(CASE
                             WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                             THEN NULL
                             ELSE item_product
                             END, '_') - 1)
                         ELSE CASE
                          WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                          THEN NULL
                          ELSE item_product
                          END
                         END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                        WHEN TRIM(item_gross_mass_measure) = '' OR TRIM(item_gross_mass_measure) = 'NULL'
                        THEN NULL
                        ELSE item_gross_mass_measure
                        END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                       WHEN TRIM(item_net_weight_measure) = '' OR TRIM(item_net_weight_measure) = 'NULL'
                       THEN NULL
                       ELSE item_net_weight_measure
                       END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                      WHEN TRIM(item_charge_amount) = '' OR TRIM(item_charge_amount) = 'NULL'
                      THEN NULL
                      ELSE item_charge_amount
                      END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                     WHEN TRIM(item_pieces) = '' OR TRIM(item_pieces) = 'NULL'
                     THEN NULL
                     ELSE item_pieces
                     END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                    WHEN TRIM(item_tariff_quantity) = '' OR TRIM(item_tariff_quantity) = 'NULL'
                    THEN NULL
                    ELSE item_tariff_quantity
                    END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                   WHEN TRIM(item_excise_payment_amount) = '' OR TRIM(item_excise_payment_amount) = 'NULL'
                   THEN NULL
                   ELSE item_excise_payment_amount
                   END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                  WHEN TRIM(item_value_for_duty) = '' OR TRIM(item_value_for_duty) = 'NULL'
                  THEN NULL
                  ELSE item_value_for_duty
                  END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                 WHEN TRIM(item_duty_payment_amount) = '' OR TRIM(item_duty_payment_amount) = 'NULL'
                 THEN NULL
                 ELSE item_duty_payment_amount
                 END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                WHEN TRIM(item_value_for_vat) = '' OR TRIM(item_value_for_vat) = 'NULL'
                THEN NULL
                ELSE item_value_for_vat
                END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
               WHEN TRIM(item_vat_payment_amount) = '' OR TRIM(item_vat_payment_amount) = 'NULL'
               THEN NULL
               ELSE item_vat_payment_amount
               END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
              WHEN TRIM(item_vat_tax_assessed_amount) = '' OR TRIM(item_vat_tax_assessed_amount) = 'NULL'
              THEN NULL
              ELSE item_vat_tax_assessed_amount
              END, '0') AS BIGNUMERIC), 0) IS NULL)) AS t0
     UNION DISTINCT
     SELECT DISTINCT movement_ref_number,
      item_position,
      broker_declarant_party_key_type_cd,
      broker_declarant_party_cd,
      COALESCE(cds_acceptance_date, cds_clearance_date, DATE_TRUNC(acceptance_date_time, DD), DATE('1900-01-01')) AS
      cds_acceptance_dt,
       CASE
       WHEN ROUND(SAFE_CAST(COALESCE(total_package_quantity, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Total Packages Quantity'
       WHEN ROUND(SAFE_CAST(COALESCE(excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Excise Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Value for Duty'
       WHEN ROUND(SAFE_CAST(COALESCE(duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Duty Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(duty_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Duty Tax Assessed Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Value for VAT'
       WHEN ROUND(SAFE_CAST(COALESCE(vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'VAT Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(vat_taxassessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'VAT Tax Assessed Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(CASE
           WHEN STRPOS(item_product, '_') > 0
           THEN SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1)
           ELSE item_product
           END, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Product'
       WHEN ROUND(SAFE_CAST(COALESCE(item_gross_mass_measure, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Gross Mass Measure'
       WHEN ROUND(SAFE_CAST(COALESCE(item_net_weight_measure, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Net Weight Measure'
       WHEN ROUND(SAFE_CAST(COALESCE(item_charge_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Charge Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(item_pieces, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Pieces'
       WHEN ROUND(SAFE_CAST(COALESCE(item_tariff_quantity, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Tariff Quantity'
       WHEN ROUND(SAFE_CAST(COALESCE(item_excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Excise Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Value for Duty'
       WHEN ROUND(SAFE_CAST(COALESCE(item_duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Duty Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'Item_1 Value for VAT'
       WHEN ROUND(SAFE_CAST(COALESCE(item_vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'VAT Payment Amount'
       WHEN ROUND(SAFE_CAST(COALESCE(item_vat_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN 'VAT Tax Assessed Amount'
       ELSE NULL
       END AS attribute_name,
       CASE
       WHEN ROUND(SAFE_CAST(COALESCE(total_package_quantity, '0') AS BIGNUMERIC), 0) IS NULL
       THEN total_package_quantity
       WHEN ROUND(SAFE_CAST(COALESCE(excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN excise_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
       THEN value_for_duty
       WHEN ROUND(SAFE_CAST(COALESCE(duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN duty_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(duty_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN duty_tax_assessed_amount
       WHEN ROUND(SAFE_CAST(COALESCE(value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
       THEN value_for_vat
       WHEN ROUND(SAFE_CAST(COALESCE(vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN vat_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(vat_taxassessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN vat_taxassessed_amount
       WHEN ROUND(SAFE_CAST(COALESCE(CASE
           WHEN STRPOS(item_product, '_') > 0
           THEN SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1)
           ELSE item_product
           END, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_product
       WHEN ROUND(SAFE_CAST(COALESCE(item_gross_mass_measure, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_gross_mass_measure
       WHEN ROUND(SAFE_CAST(COALESCE(item_net_weight_measure, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_net_weight_measure
       WHEN ROUND(SAFE_CAST(COALESCE(item_charge_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_charge_amount
       WHEN ROUND(SAFE_CAST(COALESCE(item_pieces, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_pieces
       WHEN ROUND(SAFE_CAST(COALESCE(item_tariff_quantity, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_tariff_quantity
       WHEN ROUND(SAFE_CAST(COALESCE(item_excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_excise_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_value_for_duty
       WHEN ROUND(SAFE_CAST(COALESCE(item_duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_duty_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_value_for_vat
       WHEN ROUND(SAFE_CAST(COALESCE(item_vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_vat_payment_amount
       WHEN ROUND(SAFE_CAST(COALESCE(item_vat_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
       THEN item_vat_tax_assessed_amount
       ELSE NULL
       END AS attribute_value_txt,
      dwh_valid_fg,
      dwh_src_file_name,
      dwh_src_1_tmsp,
      dwh_mapping_tmsp,
      tf_error_fg,
      deleted_fg,
      record_id,
      filename
     FROM (SELECT job_type_code,
        mrn AS movement_ref_number,
        COALESCE(item_sequence_number, '-1') AS item_position,
        'BROKER' AS broker_declarant_party_key_type_cd,
        declarant_eori AS broker_declarant_party_cd,
         CASE
         WHEN TRIM(cds_acceptance_date) = '' OR TRIM(cds_acceptance_date) = 'NULL'
         THEN NULL
         ELSE DATE(SUBSTR(cds_acceptance_date, 1, 10))
         END AS cds_acceptance_date,
         CASE
         WHEN TRIM(cds_clearance_date) = '' OR TRIM(cds_clearance_date) = 'NULL' OR LENGTH(TRIM(cds_clearance_date)) <>
           10
         THEN NULL
         ELSE DATE(SUBSTR(cds_clearance_date, 1, 10))
         END AS cds_clearance_date,
         CASE
         WHEN TRIM(acceptance_date_time) = '' OR TRIM(acceptance_date_time) = 'NULL'
         THEN NULL
         ELSE DATE(SUBSTR(acceptance_date_time, 1, 10))
         END AS acceptance_date_time,
         CASE
         WHEN TRIM(total_package_quantity) = '' OR TRIM(total_package_quantity) = 'NULL'
         THEN NULL
         ELSE total_package_quantity
         END AS total_package_quantity,
         CASE
         WHEN TRIM(excise_payment_amount) = '' OR TRIM(excise_payment_amount) = 'NULL'
         THEN NULL
         ELSE excise_payment_amount
         END AS excise_payment_amount,
         CASE
         WHEN TRIM(value_for_duty) = '' OR TRIM(value_for_duty) = 'NULL'
         THEN NULL
         ELSE value_for_duty
         END AS value_for_duty,
         CASE
         WHEN TRIM(duty_payment_amount) = '' OR TRIM(duty_payment_amount) = 'NULL'
         THEN NULL
         ELSE duty_payment_amount
         END AS duty_payment_amount,
         CASE
         WHEN TRIM(duty_tax_assessed_amount) = '' OR TRIM(duty_tax_assessed_amount) = 'NULL'
         THEN NULL
         ELSE duty_tax_assessed_amount
         END AS duty_tax_assessed_amount,
         CASE
         WHEN TRIM(value_for_vat) = '' OR TRIM(value_for_vat) = 'NULL'
         THEN NULL
         ELSE value_for_vat
         END AS value_for_vat,
         CASE
         WHEN TRIM(vat_payment_amount) = '' OR TRIM(vat_payment_amount) = 'NULL'
         THEN NULL
         ELSE vat_payment_amount
         END AS vat_payment_amount,
         CASE
         WHEN TRIM(vat_taxassessed_amount) = '' OR TRIM(vat_taxassessed_amount) = 'NULL'
         THEN NULL
         ELSE vat_taxassessed_amount
         END AS vat_taxassessed_amount,
         CASE
         WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
         THEN NULL
         ELSE item_product
         END AS item_product,
         CASE
         WHEN TRIM(item_gross_mass_measure) = '' OR TRIM(item_gross_mass_measure) = 'NULL'
         THEN NULL
         ELSE item_gross_mass_measure
         END AS item_gross_mass_measure,
         CASE
         WHEN TRIM(item_net_weight_measure) = '' OR TRIM(item_net_weight_measure) = 'NULL'
         THEN NULL
         ELSE item_net_weight_measure
         END AS item_net_weight_measure,
         CASE
         WHEN TRIM(item_charge_amount) = '' OR TRIM(item_charge_amount) = 'NULL'
         THEN NULL
         ELSE item_charge_amount
         END AS item_charge_amount,
         CASE
         WHEN TRIM(item_pieces) = '' OR TRIM(item_pieces) = 'NULL'
         THEN NULL
         ELSE item_pieces
         END AS item_pieces,
         CASE
         WHEN TRIM(item_tariff_quantity) = '' OR TRIM(item_tariff_quantity) = 'NULL'
         THEN NULL
         ELSE item_tariff_quantity
         END AS item_tariff_quantity,
         CASE
         WHEN TRIM(item_excise_payment_amount) = '' OR TRIM(item_excise_payment_amount) = 'NULL'
         THEN NULL
         ELSE item_excise_payment_amount
         END AS item_excise_payment_amount,
         CASE
         WHEN TRIM(item_value_for_duty) = '' OR TRIM(item_value_for_duty) = 'NULL'
         THEN NULL
         ELSE item_value_for_duty
         END AS item_value_for_duty,
         CASE
         WHEN TRIM(item_duty_payment_amount) = '' OR TRIM(item_duty_payment_amount) = 'NULL'
         THEN NULL
         ELSE item_duty_payment_amount
         END AS item_duty_payment_amount,
         CASE
         WHEN TRIM(item_value_for_vat) = '' OR TRIM(item_value_for_vat) = 'NULL'
         THEN NULL
         ELSE item_value_for_vat
         END AS item_value_for_vat,
         CASE
         WHEN TRIM(item_vat_payment_amount) = '' OR TRIM(item_vat_payment_amount) = 'NULL'
         THEN NULL
         ELSE item_vat_payment_amount
         END AS item_vat_payment_amount,
         CASE
         WHEN TRIM(item_vat_tax_assessed_amount) = '' OR TRIM(item_vat_tax_assessed_amount) = 'NULL'
         THEN NULL
         ELSE item_vat_tax_assessed_amount
         END AS item_vat_tax_assessed_amount,
        1 AS dwh_valid_fg,
        dwh_src_file_name,
        dwh_src_1_tmsp,
        dwh_src_1_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        dwh_src_file_name AS filename
       FROM szd_production_etl.t_cache_maersk_lgb_1
       WHERE job_type_code IN ('IMY', 'IMA', 'IMD')
        AND (ROUND(SAFE_CAST(COALESCE(CASE
                                WHEN TRIM(total_package_quantity) = '' OR TRIM(total_package_quantity) = 'NULL'
                                THEN NULL
                                ELSE total_package_quantity
                                END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                                WHEN TRIM(excise_payment_amount) = '' OR TRIM(excise_payment_amount) = 'NULL'
                                THEN NULL
                                ELSE excise_payment_amount
                                END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                               WHEN TRIM(value_for_duty) = '' OR TRIM(value_for_duty) = 'NULL'
                               THEN NULL
                               ELSE value_for_duty
                               END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                              WHEN TRIM(duty_payment_amount) = '' OR TRIM(duty_payment_amount) = 'NULL'
                              THEN NULL
                              ELSE duty_payment_amount
                              END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                             WHEN TRIM(duty_tax_assessed_amount) = '' OR TRIM(duty_tax_assessed_amount) = 'NULL'
                             THEN NULL
                             ELSE duty_tax_assessed_amount
                             END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                            WHEN TRIM(value_for_vat) = '' OR TRIM(value_for_vat) = 'NULL'
                            THEN NULL
                            ELSE value_for_vat
                            END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                           WHEN TRIM(vat_payment_amount) = '' OR TRIM(vat_payment_amount) = 'NULL'
                           THEN NULL
                           ELSE vat_payment_amount
                           END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                          WHEN TRIM(vat_taxassessed_amount) = '' OR TRIM(vat_taxassessed_amount) = 'NULL'
                          THEN NULL
                          ELSE vat_taxassessed_amount
                          END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                         WHEN STRPOS(CASE
                            WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                            THEN NULL
                            ELSE item_product
                            END, '_') > 0
                         THEN SUBSTR(CASE
                           WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                           THEN NULL
                           ELSE item_product
                           END, 1, STRPOS(CASE
                             WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                             THEN NULL
                             ELSE item_product
                             END, '_') - 1)
                         ELSE CASE
                          WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                          THEN NULL
                          ELSE item_product
                          END
                         END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                        WHEN TRIM(item_gross_mass_measure) = '' OR TRIM(item_gross_mass_measure) = 'NULL'
                        THEN NULL
                        ELSE item_gross_mass_measure
                        END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                       WHEN TRIM(item_net_weight_measure) = '' OR TRIM(item_net_weight_measure) = 'NULL'
                       THEN NULL
                       ELSE item_net_weight_measure
                       END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                      WHEN TRIM(item_charge_amount) = '' OR TRIM(item_charge_amount) = 'NULL'
                      THEN NULL
                      ELSE item_charge_amount
                      END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                     WHEN TRIM(item_pieces) = '' OR TRIM(item_pieces) = 'NULL'
                     THEN NULL
                     ELSE item_pieces
                     END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                    WHEN TRIM(item_tariff_quantity) = '' OR TRIM(item_tariff_quantity) = 'NULL'
                    THEN NULL
                    ELSE item_tariff_quantity
                    END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                   WHEN TRIM(item_excise_payment_amount) = '' OR TRIM(item_excise_payment_amount) = 'NULL'
                   THEN NULL
                   ELSE item_excise_payment_amount
                   END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                  WHEN TRIM(item_value_for_duty) = '' OR TRIM(item_value_for_duty) = 'NULL'
                  THEN NULL
                  ELSE item_value_for_duty
                  END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                 WHEN TRIM(item_duty_payment_amount) = '' OR TRIM(item_duty_payment_amount) = 'NULL'
                 THEN NULL
                 ELSE item_duty_payment_amount
                 END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                WHEN TRIM(item_value_for_vat) = '' OR TRIM(item_value_for_vat) = 'NULL'
                THEN NULL
                ELSE item_value_for_vat
                END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
               WHEN TRIM(item_vat_payment_amount) = '' OR TRIM(item_vat_payment_amount) = 'NULL'
               THEN NULL
               ELSE item_vat_payment_amount
               END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
              WHEN TRIM(item_vat_tax_assessed_amount) = '' OR TRIM(item_vat_tax_assessed_amount) = 'NULL'
              THEN NULL
              ELSE item_vat_tax_assessed_amount
              END, '0') AS BIGNUMERIC), 0) IS NULL)) AS t4)
    UNION DISTINCT
    SELECT DISTINCT movement_ref_number,
     item_position,
     broker_declarant_party_key_type_cd,
     broker_declarant_party_cd,
     COALESCE(cds_acceptance_date, cds_clearance_date, DATE_TRUNC(acceptance_date_time, DD), DATE('1900-01-01')) AS
     cds_acceptance_dt,
      CASE
      WHEN ROUND(SAFE_CAST(COALESCE(total_package_quantity, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Total Packages Quantity'
      WHEN ROUND(SAFE_CAST(COALESCE(excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Excise Payment Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Value for Duty'
      WHEN ROUND(SAFE_CAST(COALESCE(duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Duty Payment Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(duty_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Duty Tax Assessed Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Value for VAT'
      WHEN ROUND(SAFE_CAST(COALESCE(vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'VAT Payment Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(vat_taxassessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'VAT Tax Assessed Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(CASE
          WHEN STRPOS(item_product, '_') > 0
          THEN SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1)
          ELSE item_product
          END, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Item_1 Product'
      WHEN ROUND(SAFE_CAST(COALESCE(item_gross_mass_measure, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Gross Mass Measure'
      WHEN ROUND(SAFE_CAST(COALESCE(item_net_weight_measure, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Net Weight Measure'
      WHEN ROUND(SAFE_CAST(COALESCE(item_charge_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Item_1 Charge Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(item_pieces, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Item_1 Pieces'
      WHEN ROUND(SAFE_CAST(COALESCE(item_tariff_quantity, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Item_1 Tariff Quantity'
      WHEN ROUND(SAFE_CAST(COALESCE(item_excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Item_1 Excise Payment Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Item_1 Value for Duty'
      WHEN ROUND(SAFE_CAST(COALESCE(item_duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Item_1 Duty Payment Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'Item_1 Value for VAT'
      WHEN ROUND(SAFE_CAST(COALESCE(item_vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'VAT Payment Amount'
      WHEN ROUND(SAFE_CAST(COALESCE(item_vat_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN 'VAT Tax Assessed Amount'
      ELSE NULL
      END AS attribute_name,
      CASE
      WHEN ROUND(SAFE_CAST(COALESCE(total_package_quantity, '0') AS BIGNUMERIC), 0) IS NULL
      THEN total_package_quantity
      WHEN ROUND(SAFE_CAST(COALESCE(excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN excise_payment_amount
      WHEN ROUND(SAFE_CAST(COALESCE(value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
      THEN value_for_duty
      WHEN ROUND(SAFE_CAST(COALESCE(duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN duty_payment_amount
      WHEN ROUND(SAFE_CAST(COALESCE(duty_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN duty_tax_assessed_amount
      WHEN ROUND(SAFE_CAST(COALESCE(value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
      THEN value_for_vat
      WHEN ROUND(SAFE_CAST(COALESCE(vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN vat_payment_amount
      WHEN ROUND(SAFE_CAST(COALESCE(vat_taxassessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN vat_taxassessed_amount
      WHEN ROUND(SAFE_CAST(COALESCE(CASE
          WHEN STRPOS(item_product, '_') > 0
          THEN SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1)
          ELSE item_product
          END, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_product
      WHEN ROUND(SAFE_CAST(COALESCE(item_gross_mass_measure, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_gross_mass_measure
      WHEN ROUND(SAFE_CAST(COALESCE(item_net_weight_measure, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_net_weight_measure
      WHEN ROUND(SAFE_CAST(COALESCE(item_charge_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_charge_amount
      WHEN ROUND(SAFE_CAST(COALESCE(item_pieces, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_pieces
      WHEN ROUND(SAFE_CAST(COALESCE(item_tariff_quantity, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_tariff_quantity
      WHEN ROUND(SAFE_CAST(COALESCE(item_excise_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_excise_payment_amount
      WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_duty, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_value_for_duty
      WHEN ROUND(SAFE_CAST(COALESCE(item_duty_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_duty_payment_amount
      WHEN ROUND(SAFE_CAST(COALESCE(item_value_for_vat, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_value_for_vat
      WHEN ROUND(SAFE_CAST(COALESCE(item_vat_payment_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_vat_payment_amount
      WHEN ROUND(SAFE_CAST(COALESCE(item_vat_tax_assessed_amount, '0') AS BIGNUMERIC), 0) IS NULL
      THEN item_vat_tax_assessed_amount
      ELSE NULL
      END AS attribute_value_txt,
     dwh_valid_fg,
     dwh_src_file_name,
     dwh_src_1_tmsp,
     dwh_mapping_tmsp,
     tf_error_fg,
     deleted_fg,
     record_id,
     filename
    FROM (SELECT job_type_code,
       mrn AS movement_ref_number,
       COALESCE(item_sequence_number, '-1') AS item_position,
       'BROKER' AS broker_declarant_party_key_type_cd,
       declarant_eori AS broker_declarant_party_cd,
        CASE
        WHEN TRIM(cds_acceptance_date) = '' OR TRIM(cds_acceptance_date) = 'NULL'
        THEN NULL
        ELSE DATE(SUBSTR(cds_acceptance_date, 1, 10))
        END AS cds_acceptance_date,
        CASE
        WHEN TRIM(cds_clearance_date) = '' OR TRIM(cds_clearance_date) = 'NULL'
        THEN NULL
        ELSE DATE(SUBSTR(cds_clearance_date, 1, 10))
        END AS cds_clearance_date,
        CASE
        WHEN TRIM(acceptance_date_time) = '' OR TRIM(acceptance_date_time) = 'NULL'
        THEN NULL
        ELSE DATE(SUBSTR(acceptance_date_time, 1, 10))
        END AS acceptance_date_time,
        CASE
        WHEN TRIM(total_package_quantity) = '' OR TRIM(total_package_quantity) = 'NULL'
        THEN NULL
        ELSE total_package_quantity
        END AS total_package_quantity,
        CASE
        WHEN TRIM(excise_payment_amount) = '' OR TRIM(excise_payment_amount) = 'NULL'
        THEN NULL
        ELSE excise_payment_amount
        END AS excise_payment_amount,
        CASE
        WHEN TRIM(value_for_duty) = '' OR TRIM(value_for_duty) = 'NULL'
        THEN NULL
        ELSE value_for_duty
        END AS value_for_duty,
        CASE
        WHEN TRIM(duty_payment_amount) = '' OR TRIM(duty_payment_amount) = 'NULL'
        THEN NULL
        ELSE duty_payment_amount
        END AS duty_payment_amount,
        CASE
        WHEN TRIM(duty_tax_assessed_amount) = '' OR TRIM(duty_tax_assessed_amount) = 'NULL'
        THEN NULL
        ELSE duty_tax_assessed_amount
        END AS duty_tax_assessed_amount,
        CASE
        WHEN TRIM(value_for_vat) = '' OR TRIM(value_for_vat) = 'NULL'
        THEN NULL
        ELSE value_for_vat
        END AS value_for_vat,
        CASE
        WHEN TRIM(vat_payment_amount) = '' OR TRIM(vat_payment_amount) = 'NULL'
        THEN NULL
        ELSE vat_payment_amount
        END AS vat_payment_amount,
        CASE
        WHEN TRIM(vat_taxassessed_amount) = '' OR TRIM(vat_taxassessed_amount) = 'NULL'
        THEN NULL
        ELSE vat_taxassessed_amount
        END AS vat_taxassessed_amount,
        CASE
        WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
        THEN NULL
        ELSE item_product
        END AS item_product,
        CASE
        WHEN TRIM(item_gross_mass_measure) = '' OR TRIM(item_gross_mass_measure) = 'NULL'
        THEN NULL
        ELSE item_gross_mass_measure
        END AS item_gross_mass_measure,
        CASE
        WHEN TRIM(item_net_weight_measure) = '' OR TRIM(item_net_weight_measure) = 'NULL'
        THEN NULL
        ELSE item_net_weight_measure
        END AS item_net_weight_measure,
        CASE
        WHEN TRIM(item_charge_amount) = '' OR TRIM(item_charge_amount) = 'NULL'
        THEN NULL
        ELSE item_charge_amount
        END AS item_charge_amount,
        CASE
        WHEN TRIM(item_pieces) = '' OR TRIM(item_pieces) = 'NULL'
        THEN NULL
        ELSE item_pieces
        END AS item_pieces,
        CASE
        WHEN TRIM(item_tariff_quantity) = '' OR TRIM(item_tariff_quantity) = 'NULL'
        THEN NULL
        ELSE item_tariff_quantity
        END AS item_tariff_quantity,
        CASE
        WHEN TRIM(item_excise_payment_amount) = '' OR TRIM(item_excise_payment_amount) = 'NULL'
        THEN NULL
        ELSE item_excise_payment_amount
        END AS item_excise_payment_amount,
        CASE
        WHEN TRIM(item_value_for_duty) = '' OR TRIM(item_value_for_duty) = 'NULL'
        THEN NULL
        ELSE item_value_for_duty
        END AS item_value_for_duty,
        CASE
        WHEN TRIM(item_duty_payment_amount) = '' OR TRIM(item_duty_payment_amount) = 'NULL'
        THEN NULL
        ELSE item_duty_payment_amount
        END AS item_duty_payment_amount,
        CASE
        WHEN TRIM(item_value_for_vat) = '' OR TRIM(item_value_for_vat) = 'NULL'
        THEN NULL
        ELSE item_value_for_vat
        END AS item_value_for_vat,
        CASE
        WHEN TRIM(item_vat_payment_amount) = '' OR TRIM(item_vat_payment_amount) = 'NULL'
        THEN NULL
        ELSE item_vat_payment_amount
        END AS item_vat_payment_amount,
        CASE
        WHEN TRIM(item_vat_tax_assessed_amount) = '' OR TRIM(item_vat_tax_assessed_amount) = 'NULL'
        THEN NULL
        ELSE item_vat_tax_assessed_amount
        END AS item_vat_tax_assessed_amount,
       1 AS dwh_valid_fg,
       dwh_src_file_name,
       dwh_src_1_tmsp,
       dwh_src_1_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       dwh_src_file_name AS filename
      FROM szd_production_etl.t_cache_maersk_lukt_1
      WHERE job_type_code IN ('IMY', 'IMA', 'IMD')
       AND (ROUND(SAFE_CAST(COALESCE(CASE
                               WHEN TRIM(total_package_quantity) = '' OR TRIM(total_package_quantity) = 'NULL'
                               THEN NULL
                               ELSE total_package_quantity
                               END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                               WHEN TRIM(excise_payment_amount) = '' OR TRIM(excise_payment_amount) = 'NULL'
                               THEN NULL
                               ELSE excise_payment_amount
                               END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                              WHEN TRIM(value_for_duty) = '' OR TRIM(value_for_duty) = 'NULL'
                              THEN NULL
                              ELSE value_for_duty
                              END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                             WHEN TRIM(duty_payment_amount) = '' OR TRIM(duty_payment_amount) = 'NULL'
                             THEN NULL
                             ELSE duty_payment_amount
                             END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                            WHEN TRIM(duty_tax_assessed_amount) = '' OR TRIM(duty_tax_assessed_amount) = 'NULL'
                            THEN NULL
                            ELSE duty_tax_assessed_amount
                            END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                           WHEN TRIM(value_for_vat) = '' OR TRIM(value_for_vat) = 'NULL'
                           THEN NULL
                           ELSE value_for_vat
                           END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                          WHEN TRIM(vat_payment_amount) = '' OR TRIM(vat_payment_amount) = 'NULL'
                          THEN NULL
                          ELSE vat_payment_amount
                          END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                         WHEN TRIM(vat_taxassessed_amount) = '' OR TRIM(vat_taxassessed_amount) = 'NULL'
                         THEN NULL
                         ELSE vat_taxassessed_amount
                         END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                        WHEN STRPOS(CASE
                           WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                           THEN NULL
                           ELSE item_product
                           END, '_') > 0
                        THEN SUBSTR(CASE
                          WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                          THEN NULL
                          ELSE item_product
                          END, 1, STRPOS(CASE
                            WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                            THEN NULL
                            ELSE item_product
                            END, '_') - 1)
                        ELSE CASE
                         WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
                         THEN NULL
                         ELSE item_product
                         END
                        END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                       WHEN TRIM(item_gross_mass_measure) = '' OR TRIM(item_gross_mass_measure) = 'NULL'
                       THEN NULL
                       ELSE item_gross_mass_measure
                       END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                      WHEN TRIM(item_net_weight_measure) = '' OR TRIM(item_net_weight_measure) = 'NULL'
                      THEN NULL
                      ELSE item_net_weight_measure
                      END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                     WHEN TRIM(item_charge_amount) = '' OR TRIM(item_charge_amount) = 'NULL'
                     THEN NULL
                     ELSE item_charge_amount
                     END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                    WHEN TRIM(item_pieces) = '' OR TRIM(item_pieces) = 'NULL'
                    THEN NULL
                    ELSE item_pieces
                    END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                   WHEN TRIM(item_tariff_quantity) = '' OR TRIM(item_tariff_quantity) = 'NULL'
                   THEN NULL
                   ELSE item_tariff_quantity
                   END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                  WHEN TRIM(item_excise_payment_amount) = '' OR TRIM(item_excise_payment_amount) = 'NULL'
                  THEN NULL
                  ELSE item_excise_payment_amount
                  END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                 WHEN TRIM(item_value_for_duty) = '' OR TRIM(item_value_for_duty) = 'NULL'
                 THEN NULL
                 ELSE item_value_for_duty
                 END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
                WHEN TRIM(item_duty_payment_amount) = '' OR TRIM(item_duty_payment_amount) = 'NULL'
                THEN NULL
                ELSE item_duty_payment_amount
                END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
               WHEN TRIM(item_value_for_vat) = '' OR TRIM(item_value_for_vat) = 'NULL'
               THEN NULL
               ELSE item_value_for_vat
               END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
              WHEN TRIM(item_vat_payment_amount) = '' OR TRIM(item_vat_payment_amount) = 'NULL'
              THEN NULL
              ELSE item_vat_payment_amount
              END, '0') AS BIGNUMERIC), 0) IS NULL OR ROUND(SAFE_CAST(COALESCE(CASE
             WHEN TRIM(item_vat_tax_assessed_amount) = '' OR TRIM(item_vat_tax_assessed_amount) = 'NULL'
             THEN NULL
             ELSE item_vat_tax_assessed_amount
             END, '0') AS BIGNUMERIC), 0) IS NULL)) AS t8) AS t11);