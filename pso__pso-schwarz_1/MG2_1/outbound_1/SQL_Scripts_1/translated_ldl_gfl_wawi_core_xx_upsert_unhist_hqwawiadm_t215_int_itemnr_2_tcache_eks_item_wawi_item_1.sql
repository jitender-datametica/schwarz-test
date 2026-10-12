TRUNCATE TABLE   ${target_db}.${tgt_target_table};

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_num,
  itemno,
  wawi_instanz_kzl,
  itemno_wawi,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_load_id
)
WITH tmp_t026_wawi_item AS (
  SELECT
    * /* FRAMEWORK AND TECHNICAL COLUMNS */
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_1
  WHERE
    t026_wawi_item.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY t026_wawi_item.itemno
      ORDER BY IF(t026_wawi_item.seqid IS NULL, 0, 1), t026_wawi_item.seqid DESC
    ) = 1
)
SELECT
  eh.prod_num,
  eh.itemno,
  ii.wawi_instanz_kzl,
  ii.itemnr,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    t_tcache_eks_hierarchy.itemno_ba AS prod_num,
    t_tcache_eks_hierarchy.itemno_ea AS itemno
  FROM etl.t_tcache_eks_hierarchy_1
  UNION DISTINCT
  SELECT
    t_tcache_eks_hierarchy.itemno_ba AS prod_num,
    t_tcache_eks_hierarchy.itemno_sk AS itemno
  FROM etl.t_tcache_eks_hierarchy_1
  UNION DISTINCT
  SELECT
    t_tcache_eks_hierarchy.itemno_ba AS prod_num,
    t_tcache_eks_hierarchy.itemno_ba AS itemno
  FROM etl.t_tcache_eks_hierarchy_1
) AS eh
INNER JOIN (
  SELECT DISTINCT
    left(waw.wawi_instanz_kzl, 2) AS wawi_instanz_kzl,
    round(
      CAST(substr(waw.c215_itemnr, 1, CAST(length(waw.c215_itemnr) - 4 AS INT64)) AS NUMERIC),
      0
    ) AS itemnr,
    CAST(waw.c215_int_itemnr AS NUMERIC) AS itemno_int
  FROM (
    SELECT
      src.*
    FROM ${ldl_wawi_common_snflk_cl_db_name}.${src_input_table} AS src
    WHERE
      src.delete_fg IS NULL
  ) AS waw
) AS ii
  ON eh.itemno = ii.itemno_int
INNER JOIN tmp_t026_wawi_item AS wi
  ON eh.prod_num = wi.itemno
WHERE
  wi.delete_fg IS NULL
QUALIFY
  dense_rank() OVER (PARTITION BY eh.itemno ORDER BY IF(wi.seqid IS NULL, 0, 1), wi.seqid DESC) = 1;