
-- /* hs_list_txt, */
-- /* 'A' as product_status_cd,
--   spp.dwh_src_file_name, 
--   spp.dwh_src_1_tmsp as dwh_src_1_tmsp,  
--   spp.dwh_src_1_tmsp as dwh_mapping_tmsp,
--   0 as tf_error_fg,
--   0 as deleted_fg,
--   0 as record_id,
--   spp.dwh_src_file_name as filename
--   from SZD_PRODUCTION.etl.t_cache_SPPROD spp
--   join SZD_PRODUCTION.etl.t_cache_SVENTITAET e
--   on spp.PRODID = e.ENTITAETSID
--   where  spp.bez!='NULL' 
--   and  REGEXP_LIKE(case when charindex('_', trim(e.ENTITAETSNR)) > 0
--   then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
--   else trim(e.ENTITAETSNR) end, '^-?[0-9.]+$') */
-- /* union
--         select distinct
--   case when charindex('_', trim(e.ENTITAETSNR)) > 0
--          then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
--          else trim(e.ENTITAETSNR)
--  end as ian_nr,
--   SUBSTR(TRIM(spp.BEZ), 1, 100) as product_name,
--   spp.BEZ as product_name_txt,
--   'PRODUCT' as product_key_type_cd,
--  case when charindex('_', trim(e.ENTITAETSNR)) > 0
--          then substr(trim(e.ENTITAETSNR), 1, charindex('_', trim(e.ENTITAETSNR)) - 1)
--          else trim(e.ENTITAETSNR) end as prod_id,
--   '-1' as product_division_type_cd,
--   NULL as incoterm_name, 
--   /*NULL as hs_list_txt, */

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, product_status_cd, incoterm_name,
 product_division_type_cd, product_name_txt, product_key_type_cd, product_name, prod_id, ian_nr)
(SELECT ct.dwh_src_file_name,
  ct.tf_error_fg,
  ct.dwh_src_1_tmsp,
   ct.deleted_fg <> 0 AS deleted_fg,
  CAST(ct.record_id AS STRING) AS record_id,
  ct.dwh_mapping_tmsp,
  ct.filename,
  ct.product_status_cd,
  CAST(ct.incoterm_name AS STRING) AS incoterm_name,
  ct.product_division_type_cd,
  ct.product_name_txt,
  ct.product_key_type_cd,
  ct.product_name,
  ct.prod_id,
  ct.ian_nr
 FROM (SELECT *
   FROM ((((SELECT DISTINCT CASE
           WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
           THEN NULL
           ELSE CASE
            WHEN TRIM(item_product) IS NOT NULL
            THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END
           END AS ian_nr,
           CASE
           WHEN TRIM(item_description) = '' OR TRIM(item_description) = 'NULL'
           THEN NULL
           ELSE SUBSTR(item_description, 0, 99)
           END AS product_name,
           CASE
           WHEN TRIM(item_description) = '' OR TRIM(item_description) = 'NULL'
           THEN NULL
           ELSE item_description
           END AS product_name_txt,
          'PRODUCT' AS product_key_type_cd,
           CASE
           WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
           THEN NULL
           ELSE CASE
            WHEN TRIM(item_product) IS NOT NULL
            THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END
           END AS prod_id,
          '-1' AS product_division_type_cd,
          NULL AS incoterm_name,
          /* NULL as hs_list_txt, */ 'A' AS product_status_cd,
          dwh_src_file_name,
          dwh_src_1_tmsp,
          dwh_src_1_tmsp AS dwh_mapping_tmsp,
          0 AS tf_error_fg,
          0 AS deleted_fg,
          0 AS record_id,
          dwh_src_file_name AS filename
         FROM szd_production_etl.t_cache_ceva
         WHERE item_product <> 'NULL'
          AND CAST(CASE
             WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
             THEN NULL
             ELSE CASE
              WHEN TRIM(item_product) IS NOT NULL
              THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
              ELSE NULL
              END
             END AS FLOAT64) <> 1234
          AND ROUND(SAFE_CAST(CASE
             WHEN item_product IS NOT NULL
             THEN IFNULL(SPLIT(item_product, '_')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS BIGNUMERIC), 0) IS NOT NULL
         UNION DISTINCT
         SELECT DISTINCT CASE
           WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
           THEN NULL
           ELSE CASE
            WHEN TRIM(item_product) IS NOT NULL
            THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END
           END AS ian_nr,
           CASE
           WHEN TRIM(item_description) = '' OR TRIM(item_description) = 'NULL'
           THEN NULL
           ELSE SUBSTR(item_description, 0, 99)
           END AS product_name,
           CASE
           WHEN TRIM(item_description) = '' OR TRIM(item_description) = 'NULL'
           THEN NULL
           ELSE item_description
           END AS product_name_txt,
          'PRODUCT' AS product_key_type_cd,
           CASE
           WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
           THEN NULL
           ELSE CASE
            WHEN TRIM(item_product) IS NOT NULL
            THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END
           END AS prod_id,
          '-1' AS product_division_type_cd,
          NULL AS incoterm_name,
          /* NULL as hs_list_txt, */ 'A' AS product_status_cd,
          dwh_src_file_name,
          dwh_src_1_tmsp,
          dwh_src_1_tmsp AS dwh_mapping_tmsp,
          0 AS tf_error_fg,
          0 AS deleted_fg,
          0 AS record_id,
          dwh_src_file_name AS filename
         FROM szd_production_etl.t_cache_maersk_lgb
         WHERE item_product <> 'NULL'
          AND CAST(CASE
             WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
             THEN NULL
             ELSE CASE
              WHEN TRIM(item_product) IS NOT NULL
              THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
              ELSE NULL
              END
             END AS FLOAT64) <> 1234
          AND ROUND(SAFE_CAST(CASE
             WHEN item_product IS NOT NULL
             THEN IFNULL(SPLIT(item_product, '_')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END AS BIGNUMERIC), 0) IS NOT NULL)
        UNION DISTINCT
        SELECT DISTINCT CASE
          WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
          THEN NULL
          ELSE CASE
           WHEN TRIM(item_product) IS NOT NULL
           THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
           ELSE NULL
           END
          END AS ian_nr,
          CASE
          WHEN TRIM(item_description) = '' OR TRIM(item_description) = 'NULL'
          THEN NULL
          ELSE SUBSTR(item_description, 0, 99)
          END AS product_name,
          CASE
          WHEN TRIM(item_description) = '' OR TRIM(item_description) = 'NULL'
          THEN NULL
          ELSE item_description
          END AS product_name_txt,
         'PRODUCT' AS product_key_type_cd,
          CASE
          WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
          THEN NULL
          ELSE CASE
           WHEN TRIM(item_product) IS NOT NULL
           THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
           ELSE NULL
           END
          END AS prod_id,
         '-1' AS product_division_type_cd,
         NULL AS incoterm_name,
         /* NULL as hs_list_txt, */ 'A' AS product_status_cd,
         dwh_src_file_name,
         dwh_src_1_tmsp,
         dwh_src_1_tmsp AS dwh_mapping_tmsp,
         0 AS tf_error_fg,
         0 AS deleted_fg,
         0 AS record_id,
         dwh_src_file_name AS filename
        FROM szd_production_etl.t_cache_maersk_lukt
        WHERE item_product <> 'NULL'
         AND CAST(CASE
            WHEN TRIM(item_product) = '' OR TRIM(item_product) = 'NULL'
            THEN NULL
            ELSE CASE
             WHEN TRIM(item_product) IS NOT NULL
             THEN IFNULL(SPLIT(TRIM(item_product), '_')[SAFE_OFFSET(0)], '')
             ELSE NULL
             END
            END AS FLOAT64) <> 1234
         AND ROUND(SAFE_CAST(CASE
            WHEN item_product IS NOT NULL
            THEN IFNULL(SPLIT(item_product, '_')[SAFE_OFFSET(0)], '')
            ELSE NULL
            END AS BIGNUMERIC), 0) IS NOT NULL)
       UNION DISTINCT
       SELECT DISTINCT CASE
         WHEN TRIM(article_number) = '' OR TRIM(article_number) = 'NULL'
         THEN NULL
         ELSE CASE
          WHEN TRIM(article_number) IS NOT NULL
          THEN IFNULL(SPLIT(TRIM(article_number), '_')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END
         END AS ian_nr,
         CASE
         WHEN TRIM(article) = '' OR TRIM(article) = 'NULL'
         THEN NULL
         ELSE SUBSTR(article, 0, 99)
         END AS product_name,
         CASE
         WHEN TRIM(article) = '' OR TRIM(article) = 'NULL'
         THEN NULL
         ELSE article
         END AS product_name_txt,
        'PRODUCT' AS product_key_type_cd,
         CASE
         WHEN TRIM(article_number) = '' OR TRIM(article_number) = 'NULL'
         THEN NULL
         ELSE CASE
          WHEN TRIM(article_number) IS NOT NULL
          THEN IFNULL(SPLIT(TRIM(article_number), '_')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END
         END AS prod_id,
        '-1' AS product_division_type_cd,
        NULL AS incoterm_name,
        /* NULL as hs_list_txt, */ 'A' AS product_status_cd,
        dwh_src_file_name,
        dwh_src_1_tmsp,
        dwh_src_1_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        dwh_src_file_name AS filename
       FROM szd_production_etl.t_cache_owim
       WHERE article_number <> 'NULL'
        AND ROUND(SAFE_CAST(CASE
           WHEN article_number IS NOT NULL
           THEN IFNULL(SPLIT(article_number, '_')[SAFE_OFFSET(0)], '')
           ELSE NULL
           END AS BIGNUMERIC), 0) IS NOT NULL)
      UNION DISTINCT
      SELECT DISTINCT CASE
        WHEN TRIM(article_number) = '' OR TRIM(article_number) = 'NULL'
        THEN NULL
        ELSE CASE
         WHEN TRIM(article_number) IS NOT NULL
         THEN IFNULL(SPLIT(TRIM(article_number), '_')[SAFE_OFFSET(0)], '')
         ELSE NULL
         END
        END AS ian_nr,
        CASE
        WHEN TRIM(article) = '' OR TRIM(article) = 'NULL'
        THEN NULL
        ELSE SUBSTR(article, 0, 99)
        END AS product_name,
        CASE
        WHEN TRIM(article) = '' OR TRIM(article) = 'NULL'
        THEN NULL
        ELSE article
        END AS product_name_txt,
       'PRODUCT' AS product_key_type_cd,
        CASE
        WHEN TRIM(article_number) = '' OR TRIM(article_number) = 'NULL'
        THEN NULL
        ELSE CASE
         WHEN TRIM(article_number) IS NOT NULL
         THEN IFNULL(SPLIT(TRIM(article_number), '_')[SAFE_OFFSET(0)], '')
         ELSE NULL
         END
        END AS prod_id,
       '-1' AS product_division_type_cd,
       NULL AS incoterm_name,
       /* NULL as hs_list_txt, */ 'A' AS product_status_cd,
       dwh_src_file_name,
       dwh_src_1_tmsp,
       dwh_src_1_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       dwh_src_file_name AS filename
      FROM szd_production_etl.t_cache_list
      WHERE article_number <> 'NULL'
       AND ROUND(SAFE_CAST(CASE
          WHEN article_number IS NOT NULL
          THEN IFNULL(SPLIT(article_number, '_')[SAFE_OFFSET(0)], '')
          ELSE NULL
          END AS BIGNUMERIC), 0) IS NOT NULL)
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY ian_nr ORDER BY dwh_src_file_name IS NULL, dwh_src_file_name)) = 1) AS ct
  LEFT JOIN szd_production_meta.t_product_key AS mpk ON ct.ian_nr = mpk.product_nat_key_nr AND ct.product_key_type_cd =
    mpk.product_key_type_cd
  LEFT JOIN szd_production_core_rel.t_product AS tp ON mpk.product_sid = tp.product_sid AND tp.dwh_valid_fg
 WHERE tp.product_sid IS NULL);