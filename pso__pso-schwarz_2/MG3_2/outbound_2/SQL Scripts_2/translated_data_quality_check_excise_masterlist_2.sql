
TRUNCATE TABLE ${temp_db}.${src2tgt_temp_table1}_${src_context_area};


INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_1_tmsp
 , filename, error_message, dwh_valid_from_tmsp, single_article_no)
(SELECT dwh_src_1_tmsp,
  filename,
  error_message,
  dwh_valid_from_tmsp,
  dm__operand0
 FROM (SELECT dm__operand AS dm__operand0,
     dwh_valid_from_tmsp,
     SUBSTR(dwh_src_file_name, 161, 26) AS filename,
     dwh_src_1_tmsp,
     'Duplicates_detected' AS error_message
    FROM (SELECT TRIM(single_article_no) AS dm__operand,
       dwh_valid_from_tmsp,
       dwh_src_file_name,
       dwh_src_1_tmsp
      FROM szd_production_etl.t_cache_excise_masterlist_2
      GROUP BY dm__operand,
       dwh_valid_from_tmsp,
       dwh_src_file_name,
       dwh_src_1_tmsp
      HAVING COUNT(item_shortdesc) > 1) AS t1_2
    UNION ALL
    SELECT TRIM(single_article_no) AS single_article_no,
     dwh_valid_from_tmsp,
     SUBSTR(dwh_src_file_name, 161, 26) AS filename,
     dwh_src_1_tmsp,
     'Characters_detected' AS error_message
    FROM szd_production_etl.t_cache_excise_masterlist_2
    WHERE DATE(dwh_valid_from_tmsp) <> DATE('1900-01-01')
     AND NOT REGEXP_CONTAINS(TRIM(single_article_no) , r'^[0-9]*$')) AS t5);