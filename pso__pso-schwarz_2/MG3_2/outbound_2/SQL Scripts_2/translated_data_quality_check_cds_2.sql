
TRUNCATE TABLE ${temp_db}.${src2tgt_temp_table1}_${src_context_area};


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_1_tmsp
 , filename, error_message, trader_reference, item_number, entry_identifier)
(SELECT dwh_src_1_tmsp,
  filename,
  error_message,
  trader_reference,
  item_number,
  entry_identifier
 FROM (SELECT entry_identifier,
     trader_reference,
     item_number,
     SUBSTR(dwh_src_file_name, 147, 12) AS filename,
     dwh_src_1_tmsp,
     'Duplicates_detected' AS error_message
    FROM szd_production_etl.t_cache_cds_item_2
    GROUP BY entry_identifier,
     item_number,
     trader_reference,
     dwh_src_file_name,
     dwh_src_1_tmsp
    HAVING COUNT(item_number) > 1
    UNION ALL
    SELECT entry_identifier,
     trader_reference,
     item_number,
     SUBSTR(dwh_src_file_name, 147, 12) AS filename,
     dwh_src_1_tmsp,
     'Characters_detected' AS error_message
    FROM szd_production_etl.t_cache_cds_item_2
    WHERE NOT REGEXP_CONTAINS(TRIM(item_number) , r'^[0-9]*$')
    UNION ALL
    SELECT entry_identifier,
     declarant_reference,
     CAST(NULL AS STRING) AS item_number,
     SUBSTR(dwh_src_file_name, 161, 26) AS filename,
     dwh_src_1_tmsp,
     'Duplicates_detected' AS error_message
    FROM szd_production_etl.t_cache_cds_header_2
    GROUP BY entry_identifier,
     declarant_reference,
     dwh_src_file_name,
     dwh_src_1_tmsp
    HAVING COUNT(NULL) > 1) AS t9);