INSERT INTO ldl_data_production_${temp_db}.${src2tgt_temp_table1}_${src_context_area}
(
  prod_nat_key_nr,
  prod_key_type_cd,
  prod_variant_key_type_cd,
  prod_variant_nr,
  int_org_key_type_cd,
  party_nat_key_nr,

  prod_variant_nat_key_nr,
  local_prod_variant_nr,
  local_prod_variant_name,

  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
SELECT DISTINCT
  LEFT(art.wawi_instanz_kzl, 2) || '|' || LTRIM(CAST(art.itemnr AS STRING), '0') AS prod_nat_key_nr,
  'WAWI' AS prod_key_type_cd,
  'WAW_SLS' AS prod_variant_key_type_cd,
  LEFT(art.wawi_instanz_kzl, 2) || '|' || CAST(art.itemnr AS STRING) AS prod_variant_nr,
  'COUNTRY' AS int_org_key_type_cd,
  LEFT(art.wawi_instanz_kzl, 2) AS party_nat_key_nr,

  LEFT(art.wawi_instanz_kzl, 2) || '|' || CAST(art.itemnr AS STRING) AS prod_variant_nat_key_nr,
  art.itemnr AS local_prod_variant_nr,
  COALESCE(art.bez_lang, art.deutschtext) AS local_prod_variant_name,

  'WAWI' AS source_system,
  art.extraction_tmsp AS extraction_dt,
  art.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM
(
  SELECT
    wawi_instanz_kzl,
    SAFE_CAST(artnrvier AS INT64) AS itemnr,
    bez_lang,
    deutschtext,
    extraction_tmsp
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.artikel
  WHERE delete_fg IS NULL
  QUALIFY ROW_NUMBER() OVER (
    PARTITION BY wawi_instanz_kzl, SAFE_CAST(artnrvier AS INT64)
    ORDER BY artikelnr
  ) = 1
) AS art
LEFT JOIN
(
  SELECT DISTINCT
    wawi_instanz_kzl,
    SAFE_CAST(SUBSTR(c215_itemnr, 1, LENGTH(c215_itemnr) - 4) AS INT64) AS itemnr,
    SAFE_CAST(c215_int_itemnr AS INT64) AS int_itemnr
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t215_int_itemnr
  WHERE delete_fg IS NULL
) AS ii
  ON art.wawi_instanz_kzl = ii.wawi_instanz_kzl
 AND art.itemnr = ii.itemnr
LEFT JOIN ldl_data_production_meta.t_product_key AS ipk
  ON CAST(ii.int_itemnr AS STRING) = ipk.prod_nat_key_nr
 AND ipk.prod_key_type_cd IN ('CBX', 'FV')
 AND ipk.dwh_valid_fg
LEFT JOIN
(
  SELECT DISTINCT
    itemno
  FROM ldl_data_production_etl.t_tcache_eks_item_wawi_item
) AS eks
  ON ii.int_itemnr = eks.itemno
WHERE
(
  ii.itemnr IS NULL -- No link to international item number
  OR
  (
    ipk.prod_sid IS NULL -- International number not found in international keys
    AND eks.itemno IS NULL
  )
);
