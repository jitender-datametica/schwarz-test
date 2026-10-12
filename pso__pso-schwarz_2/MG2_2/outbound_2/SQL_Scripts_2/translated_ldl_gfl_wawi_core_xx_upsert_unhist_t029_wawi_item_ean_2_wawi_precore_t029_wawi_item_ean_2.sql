TRUNCATE TABLE   ${target_db}.${tgt_target_table};

INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  ctrcode,
  extraction_tmsp,
  seqid,
  posno,
  itemno,
  ean_2,
  eandesc,
  location_2,
  transferdate,
  transferflag,
  action_flag,
  scn,
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
SELECT
  left(src.ctrcode, 2) AS ctrcode,
  src.extraction_tmsp,
  src.seqid,
  src.posno,
  src.itemno,
  src.ean_2,
  src.eandesc,
  src.location_2,
  src.transferdate,
  src.transferflag,
  src.action_flag,
  src.scn,
  'UNSET' AS source_system,
  CURRENT_DATE AS extraction_dt,
  current_timestamp() AS dwh_mapping_tmsp,
  0 AS tf_error_fg,
  0 AS deleted_fg,
  0 AS record_id,
  '${SRC_INPUT_TABLE}' AS filename,
  'WAWI' AS dwh_node_cd,
  '${LOAD_ID}' AS dwh_load_id
FROM ${temp_db}.${src_input_table} AS src
INNER JOIN (
  SELECT
    a.ctrcode,
    rank() OVER (
      ORDER BY IF(
        CASE
          WHEN a.ctrcode = 'DE'
          THEN 1
          WHEN NOT a.ctrcode IN ('BG', 'CY', 'GR')
          THEN 2
          WHEN a.ctrcode = 'GR'
          THEN 3
          WHEN a.ctrcode IN ('BG', 'CY')
          THEN 4
        END IS NULL,
        0,
        1
      ) DESC, CASE
        WHEN a.ctrcode = 'DE'
        THEN 1
        WHEN NOT a.ctrcode IN ('BG', 'CY', 'GR')
        THEN 2
        WHEN a.ctrcode = 'GR'
        THEN 3
        WHEN a.ctrcode IN ('BG', 'CY')
        THEN 4
      END, IF(a.ctrcode IS NULL, 0, 1) DESC, a.ctrcode
    ) AS eks_rank
  FROM (
    SELECT DISTINCT
      ${src_input_table}.ctrcode
    FROM ${temp_db}.${src_input_table}
  ) AS a
) AS csrc
  ON src.ctrcode = csrc.ctrcode
QUALIFY
  csrc.eks_rank = MIN(csrc.eks_rank) OVER (PARTITION BY src.itemno, src.ean_2)
  AND row_number() OVER (
    PARTITION BY src.itemno, src.ean_2, src.ctrcode
    ORDER BY IF(src.seqid IS NULL, 0, 1), src.seqid DESC
  ) = 1;