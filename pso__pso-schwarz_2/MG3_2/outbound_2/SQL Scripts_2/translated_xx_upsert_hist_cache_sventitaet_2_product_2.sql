
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, product_status_cd, incoterm_name,
 product_division_type_cd, product_name_txt, product_key_type_cd, product_name, prod_id, ian_nr)
(SELECT DISTINCT src.dwh_src_file_name,
  src.tf_error_fg,
  src.dwh_src_1_tmsp,
   src.deleted_fg <> 0 AS deleted_fg,
  CAST(src.record_id AS STRING) AS record_id,
  CAST(src.dwh_mapping_tmsp AS TIMESTAMP) AS dwh_mapping_tmsp,
  src.filename,
  src.product_status_cd,
  CAST(src.incoterm_name AS STRING) AS incoterm_name,
  src.product_division_type_cd,
  src.product_name_txt,
  src.product_key_type_cd,
  src.product_name,
  src.prod_id,
  src.ian_nr
 FROM (SELECT DISTINCT CASE
     WHEN STRPOS(TRIM(e.entitaetsnr), '_') > 0
     THEN SUBSTR(TRIM(e.entitaetsnr), 1, STRPOS(TRIM(e.entitaetsnr), '_') - 1)
     ELSE TRIM(e.entitaetsnr)
     END AS ian_nr,
    'PRODUCT' AS product_key_type_cd,
     CASE
     WHEN STRPOS(TRIM(e.entitaetsnr), '_') > 0
     THEN SUBSTR(TRIM(e.entitaetsnr), 1, STRPOS(TRIM(e.entitaetsnr), '_') - 1)
     ELSE TRIM(e.entitaetsnr)
     END AS prod_id,
    MAX(SUBSTR(TRIM(t0.bez), 1, 100)) OVER (PARTITION BY CASE
        WHEN STRPOS(TRIM(e.entitaetsnr), '_') > 0
        THEN SUBSTR(TRIM(e.entitaetsnr), 1, STRPOS(TRIM(e.entitaetsnr), '_') - 1)
        ELSE TRIM(e.entitaetsnr)
        END ORDER BY t0.bez IS NULL DESC, t0.bez DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS product_name
    ,
    MAX(t0.bez) OVER (PARTITION BY CASE
        WHEN STRPOS(TRIM(e.entitaetsnr), '_') > 0
        THEN SUBSTR(TRIM(e.entitaetsnr), 1, STRPOS(TRIM(e.entitaetsnr), '_') - 1)
        ELSE TRIM(e.entitaetsnr)
        END ORDER BY t0.bez IS NULL DESC, t0.bez DESC RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS
    product_name_txt,
    '-1' AS product_division_type_cd,
    NULL AS incoterm_name,
    /* NULL as hs_list_txt, */ 'A' AS product_status_cd,
    MAX(t0.dwh_src_file_name) OVER (PARTITION BY CASE
        WHEN STRPOS(TRIM(e.entitaetsnr), '_') > 0
        THEN SUBSTR(TRIM(e.entitaetsnr), 1, STRPOS(TRIM(e.entitaetsnr), '_') - 1)
        ELSE TRIM(e.entitaetsnr)
        END ORDER BY t0.dwh_src_file_name IS NULL DESC, t0.dwh_src_file_name DESC RANGE BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW) AS dwh_src_file_name,
    t0.dwh_src_1_tmsp,
    t0.aenddatum AS dwh_mapping_tmsp,
    0 AS tf_error_fg,
    0 AS deleted_fg,
    0 AS record_id,
    MAX(t0.dwh_src_file_name) OVER (PARTITION BY CASE
        WHEN STRPOS(TRIM(e.entitaetsnr), '_') > 0
        THEN SUBSTR(TRIM(e.entitaetsnr), 1, STRPOS(TRIM(e.entitaetsnr), '_') - 1)
        ELSE TRIM(e.entitaetsnr)
        END ORDER BY t0.dwh_src_file_name IS NULL DESC, t0.dwh_src_file_name DESC RANGE BETWEEN UNBOUNDED PRECEDING AND
     CURRENT ROW) AS filename
   FROM (SELECT prodid,
      bez,
      aenddatum,
      dwh_src_1_tmsp,
      dwh_src_file_name
     FROM szd_production_etl.t_cache_spprod_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY prodid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) = 1) AS
    t0
    INNER JOIN (SELECT entitaetsid,
      entitaetsnr
     FROM szd_production_etl.t_cache_sventitaet_2
     QUALIFY (ROW_NUMBER() OVER (PARTITION BY entitaetsid ORDER BY dwh_src_1_tmsp IS NULL DESC, dwh_src_1_tmsp DESC)) =
       1) AS e ON t0.prodid = e.entitaetsid
   WHERE t0.bez <> 'NULL'
    AND 0 <> REGEXP_CONTAINS(CASE
       WHEN STRPOS(TRIM(e.entitaetsnr), '_') > 0
       THEN SUBSTR(TRIM(e.entitaetsnr), 1, STRPOS(TRIM(e.entitaetsnr), '_') - 1)
       ELSE TRIM(e.entitaetsnr)
       END , r'^-?[0-9.]+$')) AS src
  LEFT JOIN szd_production_meta.t_product_key_2 AS mpk ON src.ian_nr = mpk.product_nat_key_nr AND src.product_key_type_cd
    = mpk.product_key_type_cd
  LEFT JOIN szd_production_core_rel.t_product_2 AS tp ON mpk.product_sid = tp.product_sid AND tp.dwh_valid_fg
 WHERE tp.product_sid IS NULL);