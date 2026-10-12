INSERT INTO szd_producton.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  product_variant_id,
  product_variant_key_type_cd,
  product_sid,
  sales_variant_number,
  sales_variant_name,
  dwh_src_file_name,
  dwh_src_1_tmsp,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename
)
SELECT DISTINCT
  ct.*
FROM (
  SELECT
    t_cache_zgts_brimport.prvsy AS product_variant_id,
    'SALES_VARIANT' AS product_variant_key_type_cd,
    -CAST('1' AS NUMERIC) AS product_sid,
    round(SAFE_CAST(t_cache_zgts_brimport.prvsy AS BIGNUMERIC), 0) AS sales_variant_number,
    substr(t_cache_zgts_brimport.prtxt, 1, 100) AS sales_variant_name,
    t_cache_zgts_brimport.dwh_src_file_name,
    t_cache_zgts_brimport.dwh_src_1_tmsp AS dwh_src_1_tmsp,
    t_cache_zgts_brimport.dwh_src_1_tmsp AS dwh_mapping_tmsp,
    CAST('0' AS NUMERIC) AS tf_error_fg,
    CAST('0' AS NUMERIC) AS deleted_fg,
    CAST('0' AS NUMERIC) AS record_id,
    t_cache_zgts_brimport.dwh_src_file_name AS filename
  FROM szd_production.etl.t_cache_zgts_brimport_2
  QUALIFY
    row_number() OVER (
      PARTITION BY sales_variant_number
      ORDER BY IF(dwh_src_file_name IS NULL, 0, 1) DESC, dwh_src_file_name
    ) = CAST('1' AS NUMERIC)
) AS ct
LEFT OUTER JOIN szd_production.meta.t_product_key_2 AS pk
  ON pk.product_key_type_cd = ct.product_variant_key_type_cd
  AND ct.product_variant_id = pk.product_nat_key_nr
LEFT OUTER JOIN szd_production.core_rel.t_sales_variant_2 AS sv
  ON pk.product_sid = sv.product_variant_sid;