
TRUNCATE TABLE ${temp_db}.${src2tgt_temp_table1}_${src_context_area};


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_1_tmsp
 , filename, item_product, error_message, item_sequence_number, trader_reference, mrn)
(SELECT dwh_src_1_tmsp,
  filename,
  dm__operand0,
  error_message,
  dm__operand,
  trader_reference,
  mrn
 FROM (SELECT mrn,
     trader_reference,
     dm__operand,
     dm__operand0,
     SUBSTR(dwh_src_file_name, 151, 16) AS filename,
     dwh_src_1_tmsp,
     'Duplicates_detected' AS error_message
    FROM (SELECT mrn,
       trader_reference,
       TRIM(item_sequence_number) AS dm__operand,
       TRIM(item_product) AS dm__operand0,
       dwh_src_file_name,
       dwh_src_1_tmsp
      FROM szd_production_etl.t_cache_ceva
      WHERE job_type_code IN ('IMY', 'IMD', 'IMA')
      GROUP BY mrn,
       trader_reference,
       dm__operand,
       dm__operand0,
       dwh_src_file_name,
       dwh_src_1_tmsp
      HAVING COUNT(job_ref) > 1) AS t2
    UNION ALL
    SELECT mrn,
     trader_reference,
     TRIM(item_sequence_number) AS item_sequence_number,
      CASE
      WHEN STRPOS(item_product, '_') > 0
      THEN TRIM(SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1))
      ELSE TRIM(item_product)
      END AS item_product,
     SUBSTR(dwh_src_file_name, 151, 16) AS filename,
     dwh_src_1_tmsp,
     'Characters_detected' AS error_message
    FROM szd_production_etl.t_cache_ceva
    WHERE job_type_code IN ('IMY', 'IMD', 'IMA')
     AND (LOWER(TRIM(item_product)) LIKE '%article%' OR NOT REGEXP_CONTAINS(CASE
          WHEN STRPOS(item_product, '_') > 0
          THEN TRIM(SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1))
          ELSE TRIM(item_product)
          END , r'^[0-9]*$') OR NOT REGEXP_CONTAINS(TRIM(item_sequence_number) , r'^[0-9]*$'))
    UNION ALL
    SELECT mrn,
     trader_reference,
     dm__operand,
     dm__operand0,
     SUBSTR(dwh_src_file_name, 154, 19) AS filename,
     dwh_src_1_tmsp,
     'Duplicates_detected' AS error_message
    FROM (SELECT mrn,
       trader_reference,
       TRIM(item_sequence_number) AS dm__operand,
       TRIM(item_product) AS dm__operand0,
       dwh_src_file_name,
       dwh_src_1_tmsp
      FROM szd_production_etl.t_cache_maersk_lgb
      WHERE job_type_code IN ('IMY', 'IMD', 'IMA')
      GROUP BY mrn,
       trader_reference,
       dm__operand,
       dm__operand0,
       dwh_src_file_name,
       dwh_src_1_tmsp
      HAVING COUNT(job_ref) > 1) AS t9
    UNION ALL
    SELECT mrn,
     trader_reference,
     TRIM(item_sequence_number) AS item_sequence_number,
      CASE
      WHEN STRPOS(item_product, '_') > 0
      THEN TRIM(SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1))
      ELSE TRIM(item_product)
      END AS item_product,
     SUBSTR(dwh_src_file_name, 154, 19) AS filename,
     dwh_src_1_tmsp,
     'Characters_detected' AS error_message
    FROM szd_production_etl.t_cache_maersk_lgb
    WHERE job_type_code IN ('IMY', 'IMD', 'IMA')
     AND (LOWER(TRIM(item_product)) LIKE '%article%' OR NOT REGEXP_CONTAINS(CASE
          WHEN STRPOS(item_product, '_') > 0
          THEN TRIM(SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1))
          ELSE TRIM(item_product)
          END , r'^[0-9]*$') OR NOT REGEXP_CONTAINS(TRIM(item_sequence_number) , r'^[0-9]*$'))
    UNION ALL
    SELECT mrn,
     trader_reference,
     dm__operand,
     dm__operand0,
     SUBSTR(dwh_src_file_name, 155, 20) AS filename,
     dwh_src_1_tmsp,
     'Duplicates_detected' AS error_message
    FROM (SELECT mrn,
       trader_reference,
       TRIM(item_sequence_number) AS dm__operand,
       TRIM(item_product) AS dm__operand0,
       dwh_src_file_name,
       dwh_src_1_tmsp
      FROM szd_production_etl.t_cache_maersk_lukt
      WHERE job_type_code IN ('IMY', 'IMD', 'IMA')
      GROUP BY mrn,
       trader_reference,
       dm__operand,
       dm__operand0,
       dwh_src_file_name,
       dwh_src_1_tmsp
      HAVING COUNT(job_ref) > 1) AS t16
    UNION ALL
    SELECT mrn,
     trader_reference,
     TRIM(item_sequence_number) AS item_sequence_number,
      CASE
      WHEN STRPOS(item_product, '_') > 0
      THEN TRIM(SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1))
      ELSE TRIM(item_product)
      END AS item_product,
     SUBSTR(dwh_src_file_name, 155, 20) AS filename,
     dwh_src_1_tmsp,
     'Characters_detected' AS error_message
    FROM szd_production_etl.t_cache_maersk_lukt
    WHERE job_type_code IN ('IMY', 'IMD', 'IMA')
     AND (LOWER(TRIM(item_product)) LIKE '%article%' OR NOT REGEXP_CONTAINS(CASE
          WHEN STRPOS(item_product, '_') > 0
          THEN TRIM(SUBSTR(item_product, 1, STRPOS(item_product, '_') - 1))
          ELSE TRIM(item_product)
          END , r'^[0-9]*$') OR NOT REGEXP_CONTAINS(TRIM(item_sequence_number) , r'^[0-9]*$'))) AS t20);