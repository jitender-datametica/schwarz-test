/* Extraction/Filter Logic: */
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  prod_key_type_cd,
  prod_nr,
  prod_grp_key_type_cd,
  prod_grp_nr,
  prod_grp_type_cd,
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
WITH eks_item AS (
  SELECT
    t026_wawi_item.itemno,
    t026_wawi_item.itemgrshortdesc AS uwgnr,
    t026_wawi_item.itemgroupid AS fgnr,
    CASE t026_wawi_item.bitflag WHEN 0 THEN 1 WHEN 4 THEN 2 WHEN 2 THEN 3 END AS level,
    t026_wawi_item.extraction_tmsp /* BA */
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_2
  WHERE
    t026_wawi_item.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY itemno
      ORDER BY IF(t026_wawi_item.seqid IS NULL, 0, 1), t026_wawi_item.seqid DESC
    ) = 1
)
SELECT
  'EKS' AS prod_key_type_cd, /* FRAMEWORK AND TECHNICAL COLUMNS */
  subselect.prod_num AS prod_nr,
  'IFG' AS prod_grp_key_type_cd,
  CONCAT(subselect.uwgnr, '|', subselect.fgnr) AS prod_grp_nr,
  'IFG' AS prod_grp_type_cd,
  'WAWI' AS source_system, /* FRAMEWORK AND TECHNICAL COLUMNS */
  CURRENT_DATE AS extraction_dt,
  subselect.extraction_tmsp AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI_HQ' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT
    subselect_0.prod_num,
    subselect_0.extraction_tmsp,
    subselect_0.uwgnr,
    subselect_0.fgnr
  FROM (
    SELECT
      eks.prod_num,
      eksp.extraction_tmsp,
      CASE
        WHEN NOT CONCAT(eksp.uwgnr, '|', eksp.fgnr) IS NULL
        THEN eksp.uwgnr
        ELSE eksi.uwgnr
      END AS uwgnr,
      CASE
        WHEN NOT CONCAT(eksp.uwgnr, '|', eksp.fgnr) IS NULL
        THEN eksp.fgnr
        ELSE eksi.fgnr
      END AS fgnr
    FROM (
      SELECT
        t_tcache_eks_hierarchy.itemno_ba AS prod_num,
        t_tcache_eks_hierarchy.itemno_sk AS itemno
      FROM etl.t_tcache_eks_hierarchy_2
      UNION DISTINCT
      SELECT
        t_tcache_eks_hierarchy.itemno_ba AS prod_num,
        t_tcache_eks_hierarchy.itemno_ea AS itemno
      FROM etl.t_tcache_eks_hierarchy_2
    ) AS eks
    INNER JOIN eks_item AS eksp
      ON eks.prod_num = eksp.itemno
    INNER JOIN eks_item AS eksi
      ON eks.itemno = eksi.itemno
    QUALIFY
      row_number() OVER (
        PARTITION BY eks.prod_num
        ORDER BY IF(
          CASE WHEN NOT CONCAT(eksp.uwgnr, '|', eksp.fgnr) IS NULL THEN 1 ELSE 2 END IS NULL,
          0,
          1
        ) DESC, CASE WHEN NOT CONCAT(eksp.uwgnr, '|', eksp.fgnr) IS NULL THEN 1 ELSE 2 END, IF(
          CASE WHEN NOT CONCAT(eksi.uwgnr, '|', eksi.fgnr) IS NULL THEN 1 ELSE 2 END IS NULL,
          0,
          1
        ) DESC, CASE WHEN NOT CONCAT(eksi.uwgnr, '|', eksi.fgnr) IS NULL THEN 1 ELSE 2 END, IF(eksi.level IS NULL, 0, 1), eksi.level DESC
      ) = 1
  ) AS subselect_0
  WHERE
    NOT subselect_0.uwgnr IS NULL AND NOT subselect_0.fgnr IS NULL
) AS subselect;