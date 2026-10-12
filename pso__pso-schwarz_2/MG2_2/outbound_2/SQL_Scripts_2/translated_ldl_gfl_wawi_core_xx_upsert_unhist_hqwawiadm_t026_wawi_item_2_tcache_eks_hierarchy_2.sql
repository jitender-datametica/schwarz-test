TRUNCATE TABLE   ${target_db}.${tgt_target_table};

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  itemno_ea,
  itemno_sk,
  itemno_ba,
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
  FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t026_wawi_item_2
  WHERE
    t026_wawi_item.delete_fg IS NULL
  QUALIFY
    row_number() OVER (
      PARTITION BY t026_wawi_item.itemno
      ORDER BY IF(t026_wawi_item.seqid IS NULL, 0, 1), t026_wawi_item.seqid DESC
    ) = 1
), eks_item AS (
  SELECT
    tmp_t026_wawi_item.itemno,
    CASE tmp_t026_wawi_item.bitflag WHEN 0 THEN 1 WHEN 4 THEN 2 WHEN 2 THEN 3 END AS hier_level
  /* BA */
  FROM tmp_t026_wawi_item
), eks_dep AS (
  SELECT
    d.wawi_instanz_kzl AS ctrcode,
    d.extraction_tmsp,
    d.seqid,
    d.itemno_head,
    i2.hier_level AS level_head,
    d.itemno_detail,
    i1.hier_level AS level_detail,
    d.posno,
    d.quantity,
    d.transferdate,
    d.transferflag,
    d.action_flag,
    d.location_2,
    d.scn,
    CASE
      WHEN i1.hier_level = 1 AND i2.hier_level = 2
      THEN 'EA-SK'
      WHEN i1.hier_level = 1 AND i2.hier_level = 3
      THEN 'EA-BA'
      WHEN i1.hier_level = 2 AND i2.hier_level = 3
      THEN 'SK-BA'
    END AS dep_descr
  /* Keep source data per Item_2 pair with the most recent SeqID */
  FROM (
    SELECT
      src.*
    FROM ${ldl_wawi_common_snflk_cl_db_name}.hqwawiadm.t024_wawi_item_dep_2 AS src
    WHERE
      src.delete_fg IS NULL
    QUALIFY
      row_number() OVER (
        PARTITION BY src.itemno_head, src.itemno_detail
        ORDER BY IF(src.seqid IS NULL, 0, 1), src.seqid DESC
      ) = 1
  ) AS d
  INNER JOIN eks_item AS i1
    ON d.itemno_detail = i1.itemno
  INNER JOIN eks_item AS i2
    ON d.itemno_head = i2.itemno AND i1.hier_level < i2.hier_level
  QUALIFY
    dep_descr = 'EA-SK'
    AND d.seqid = MAX(d.seqid) OVER (PARTITION BY d.itemno_head, dep_descr)
    OR dep_descr IN ('EA-BA', 'SK-BA')
    AND row_number() OVER (
      PARTITION BY i1.itemno, dep_descr
      ORDER BY IF(d.seqid IS NULL, 0, 1), d.seqid DESC
    ) = 1
), wawi_item_dep AS (
  SELECT
    left(subselect.ctrcode, 2) AS ctrcode,
    subselect.extraction_tmsp,
    subselect.seqid,
    subselect.itemno_head,
    subselect.level_head,
    subselect.itemno_detail,
    subselect.level_detail,
    subselect.posno,
    subselect.quantity,
    subselect.transferdate,
    subselect.transferflag,
    subselect.action_flag,
    subselect.location_2,
    subselect.scn,
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
      d1.*
    FROM eks_dep AS d1
    LEFT OUTER JOIN eks_dep AS d2
      ON d1.dep_descr = 'EA-SK'
      AND d2.dep_descr = 'SK-BA'
      AND d1.itemno_head = d2.itemno_detail
    QUALIFY
      d1.dep_descr <> 'EA-SK'
      OR /* Verify EA-SK dependencies additionally using the BA (product), use only most recent BA. */ first_value(d2.itemno_head IGNORE NULLS) OVER (
        PARTITION BY d1.itemno_detail
        ORDER BY d2.seqid DESC
        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
      ) = d2.itemno_head
  ) AS subselect
)
SELECT
  subselect.itemno_1 AS itemno_ea,
  CASE
    WHEN subselect.itemno_3 IS NULL
    THEN subselect.itemno_1
    ELSE subselect.itemno_2
  END AS itemno_sk,
  CASE
    WHEN subselect.itemno_2 IS NULL AND subselect.itemno_3 IS NULL
    THEN subselect.itemno_1
    WHEN subselect.itemno_3 IS NULL
    THEN subselect.itemno_2
    ELSE subselect.itemno_3
  END AS itemno_ba,
  'WAWI' AS source_system,
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  '${LOAD_ID}' AS dwh_load_id
FROM (
  SELECT DISTINCT
    i1.itemno AS itemno_1,
    d1.level_detail AS level_1,
    i2.itemno AS itemno_2,
    d1.level_head AS level_2,
    i3.itemno AS itemno_3,
    d2.level_head AS level_3,
    prod_num AS prod_num
  FROM tmp_t026_wawi_item AS i1
  LEFT OUTER JOIN wawi_item_dep AS d1
    ON i1.itemno = d1.itemno_detail
  LEFT OUTER JOIN tmp_t026_wawi_item AS i2
    ON d1.itemno_head = i2.itemno
  LEFT OUTER JOIN wawi_item_dep AS d2
    ON i2.itemno = d2.itemno_detail
  LEFT OUTER JOIN tmp_t026_wawi_item AS i3
    ON d2.itemno_head = i3.itemno
  LEFT OUTER JOIN (
    SELECT DISTINCT
      wawi_item_dep.itemno_detail
    FROM wawi_item_dep
  ) AS dx
    ON i1.itemno = dx.itemno_detail
  CROSS JOIN UNNEST([
    CASE
      WHEN dx.itemno_detail IS NULL
      THEN i1.itemno
      WHEN d1.level_head = 3
      THEN i2.itemno
      WHEN d2.level_head = 3
      THEN i3.itemno
    END
  ]) AS prod_num
  WHERE
    i1.bitflag IN (0)
    AND /* EA */ (
      i1.itemgrshortdesc BETWEEN CAST('20' AS NUMERIC) AND CAST('99' AS NUMERIC)
      OR i2.itemgrshortdesc BETWEEN CAST('20' AS NUMERIC) AND CAST('99' AS NUMERIC)
      OR i3.itemgrshortdesc BETWEEN CAST('20' AS NUMERIC) AND CAST('99' AS NUMERIC)
    )
    AND NOT prod_num IS NULL
    AND i1.delete_fg IS NULL
    AND i2.delete_fg IS NULL
    AND i3.delete_fg IS NULL
) AS subselect;