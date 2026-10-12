
-- dwh_valid_fg,
 INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(dwh_src_file_name, tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename,
 requested_procedure_cd, customs_procedure_cd, additional_procedure_cd, approved_fg)
(SELECT dwh_src_file_name,
  tf_error_fg,
  dwh_src_1_tmsp,
   deleted_fg <> 0 AS deleted_fg,
  CAST(record_id AS STRING) AS record_id,
  dwh_mapping_tmsp,
  filename,
  requested_procedure_cd,
  customs_procedure_cd,
  additional_procedure_cd,
   approved_fg <> 0 AS approved_fg
 FROM (SELECT *
   FROM (((SELECT DISTINCT LPAD(CASE
             WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
               'NULL'
             THEN NULL
             ELSE item_government_procedure_current_code
             END, 2, '0') || LPAD(CASE
             WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
               'NULL'
             THEN NULL
             ELSE item_government_procedure_previous_code
             END, 2, '0') || LPAD(CASE
            WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
               ) = 'NULL'
            THEN NULL
            ELSE item_government_procedure_current_code_special
            END, 3, '0') AS customs_procedure_cd,
          LPAD(CASE
            WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
              'NULL'
            THEN NULL
            ELSE item_government_procedure_current_code
            END, 2, '0') || LPAD(CASE
            WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
              'NULL'
            THEN NULL
            ELSE item_government_procedure_previous_code
            END, 2, '0') AS requested_procedure_cd,
         LPAD(CASE
           WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
              ) = 'NULL'
           THEN NULL
           ELSE item_government_procedure_current_code_special
           END, 3, '0') AS additional_procedure_cd,
         0 AS approved_fg,
         -- 1 as dwh_valid_fg,
 dwh_src_file_name,
         dwh_src_1_tmsp,
         dwh_src_1_tmsp AS dwh_mapping_tmsp,
         0 AS tf_error_fg,
         0 AS deleted_fg,
         0 AS record_id,
         dwh_src_file_name AS filename
        FROM szd_production_etl.t_cache_ceva_1
        WHERE LPAD(CASE
              WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
                'NULL'
              THEN NULL
              ELSE item_government_procedure_current_code
              END, 2, '0') || LPAD(CASE
              WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
                'NULL'
              THEN NULL
              ELSE item_government_procedure_previous_code
              END, 2, '0') || LPAD(CASE
             WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
                ) = 'NULL'
             THEN NULL
             ELSE item_government_procedure_current_code_special
             END, 3, '0') <> 'NULL'
        UNION DISTINCT
        SELECT DISTINCT LPAD(CASE
             WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
               'NULL'
             THEN NULL
             ELSE item_government_procedure_current_code
             END, 2, '0') || LPAD(CASE
             WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
               'NULL'
             THEN NULL
             ELSE item_government_procedure_previous_code
             END, 2, '0') || LPAD(CASE
            WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
               ) = 'NULL'
            THEN NULL
            ELSE item_government_procedure_current_code_special
            END, 3, '0') AS customs_procedure_cd,
          LPAD(CASE
            WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
              'NULL'
            THEN NULL
            ELSE item_government_procedure_current_code
            END, 2, '0') || LPAD(CASE
            WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
              'NULL'
            THEN NULL
            ELSE item_government_procedure_previous_code
            END, 2, '0') AS requested_procedure_cd,
         LPAD(CASE
           WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
              ) = 'NULL'
           THEN NULL
           ELSE item_government_procedure_current_code_special
           END, 3, '0') AS additional_procedure_cd,
         0 AS approved_fg,
         -- 1 as dwh_valid_fg,
 dwh_src_file_name,
         dwh_src_1_tmsp,
         dwh_src_1_tmsp AS dwh_mapping_tmsp,
         0 AS tf_error_fg,
         0 AS deleted_fg,
         0 AS record_id,
         dwh_src_file_name AS filename
        FROM szd_production_etl.t_cache_maersk_lgb_1
        WHERE LPAD(CASE
              WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
                'NULL'
              THEN NULL
              ELSE item_government_procedure_current_code
              END, 2, '0') || LPAD(CASE
              WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
                'NULL'
              THEN NULL
              ELSE item_government_procedure_previous_code
              END, 2, '0') || LPAD(CASE
             WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
                ) = 'NULL'
             THEN NULL
             ELSE item_government_procedure_current_code_special
             END, 3, '0') <> 'NULL')
       UNION DISTINCT
       SELECT DISTINCT LPAD(CASE
            WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
              'NULL'
            THEN NULL
            ELSE item_government_procedure_current_code
            END, 2, '0') || LPAD(CASE
            WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
              'NULL'
            THEN NULL
            ELSE item_government_procedure_previous_code
            END, 2, '0') || LPAD(CASE
           WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
              ) = 'NULL'
           THEN NULL
           ELSE item_government_procedure_current_code_special
           END, 3, '0') AS customs_procedure_cd,
         LPAD(CASE
           WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
             'NULL'
           THEN NULL
           ELSE item_government_procedure_current_code
           END, 2, '0') || LPAD(CASE
           WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
             'NULL'
           THEN NULL
           ELSE item_government_procedure_previous_code
           END, 2, '0') AS requested_procedure_cd,
        LPAD(CASE
          WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
             ) = 'NULL'
          THEN NULL
          ELSE item_government_procedure_current_code_special
          END, 3, '0') AS additional_procedure_cd,
        0 AS approved_fg,
        -- 1 as dwh_valid_fg,
 dwh_src_file_name,
        dwh_src_1_tmsp,
        dwh_src_1_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        dwh_src_file_name AS filename
       FROM szd_production_etl.t_cache_maersk_lukt_1
       WHERE LPAD(CASE
             WHEN TRIM(item_government_procedure_current_code) = '' OR TRIM(item_government_procedure_current_code) =
               'NULL'
             THEN NULL
             ELSE item_government_procedure_current_code
             END, 2, '0') || LPAD(CASE
             WHEN TRIM(item_government_procedure_previous_code) = '' OR TRIM(item_government_procedure_previous_code) =
               'NULL'
             THEN NULL
             ELSE item_government_procedure_previous_code
             END, 2, '0') || LPAD(CASE
            WHEN TRIM(item_government_procedure_current_code_special) = '' OR TRIM(item_government_procedure_current_code_special
               ) = 'NULL'
            THEN NULL
            ELSE item_government_procedure_current_code_special
            END, 3, '0') <> 'NULL')
      UNION DISTINCT
      SELECT DISTINCT cpc AS customs_procedure_cd,
       cpc AS requested_procedure_cd,
       cpc AS additional_procedure_cd,
       0 AS approved_fg,
       -- 1 as dwh_valid_fg,
 dwh_src_file_name,
       dwh_src_1_tmsp,
       dwh_src_1_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       dwh_src_file_name AS filename
      FROM szd_production_etl.t_cache_cds_item_1
      WHERE cpc <> 'NULL')
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY customs_procedure_cd ORDER BY dwh_src_file_name IS NULL, dwh_src_file_name)
      ) = 1) AS ct);