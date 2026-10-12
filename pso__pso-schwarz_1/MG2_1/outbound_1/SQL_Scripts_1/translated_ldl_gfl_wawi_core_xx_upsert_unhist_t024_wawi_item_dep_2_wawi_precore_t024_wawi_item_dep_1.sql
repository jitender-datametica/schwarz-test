TRUNCATE TABLE   ${target_db}.${tgt_target_table};

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  extraction_tmsp,
  seqid,
  itemno_head,
  level_head,
  itemno_detail,
  level_detail,
  posno,
  quantity,
  transferdate,
  transferflag,
  action_flag,
  location_1,
  scn,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_load_id
)
WITH eks_item AS (
  SELECT
    t_wawi_precore_t026_wawi_item.itemno,
    CASE t_wawi_precore_t026_wawi_item.bitflag
      WHEN 0
      THEN 1
      WHEN 4
      THEN 2
      WHEN 2
      THEN 3
    END AS hier_level
  /* BA */
  FROM etl.t_wawi_precore_t026_wawi_item_1
), eks_dep AS (
  SELECT
    d.ctrcode,
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
    d.location_1,
    d.scn,
    CASE
      WHEN i1.hier_level = 1 AND i2.hier_level = 2
      THEN 'EA-SK'
      WHEN i1.hier_level = 1 AND i2.hier_level = 3
      THEN 'EA-BA'
      WHEN i1.hier_level = 2 AND i2.hier_level = 3
      THEN 'SK-BA'
    END AS dep_descr
  /* Keep source data per Item_1 pair with the most recent SeqID */
  FROM (
    SELECT
      s.*
    FROM etl.t024_wawi_item_dep_1 AS s
    INNER JOIN etl.wawi_control_table_1 AS ctrl
      ON ctrl.source_table_name = upper('${TEMP_DB}.${SRC_INPUT_TABLE}')
      AND ctrl.source_status = 'A'
      AND s.extraction_tmsp BETWEEN ctrl.begin_tmsp AND ctrl.end_tmsp
    QUALIFY
      row_number() OVER (
        PARTITION BY s.itemno_head, s.itemno_detail
        ORDER BY IF(s.seqid IS NULL, 0, 1), s.seqid DESC
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
)
SELECT
  left(subselect.ctrcode, 2) AS ctrcode, /* FRAMEWORK AND TECHNICAL COLUMNS */
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
  subselect.location_1,
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
) AS subselect;