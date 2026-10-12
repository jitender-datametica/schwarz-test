INSERT INTO etl.${src2tgt_temp_table1}_${src_context_area} (
  real_estate_key_type_cd,
  real_estate_nk,
  real_estate_status_categ_cd,
  real_estate_status_cd,
  real_estate_status_reason_cd,
  comment_txt,
  source_system,
  extraction_dt,
  dwh_mapping_tmsp,
  dwh_ending_tmsp,
  tf_error_fg,
  deleted_fg,
  record_id,
  filename,
  dwh_node_cd,
  dwh_load_id
)
SELECT
    'RE_2' AS real_estate_key_type_cd,
    CONCAT(src.igl_isocode2, '|', LTRIM(SUBSTR(src.igl_number, 3, 7), '0#')) AS real_estate_nk,
    'BS' AS real_estate_status_categ_cd,
    'TC' AS real_estate_status_cd,
    CASE
       src.igl_measurereasoncode
      WHEN NUMERIC '285540001' THEN 'BS_TC_DNC'
      WHEN NUMERIC '285540002' THEN 'BS_TC_REL'
      WHEN NUMERIC '285540003' THEN 'BS_TC_MOD'
      WHEN NUMERIC '285540004' THEN 'BS_TC_MEX'
      WHEN NUMERIC '285540005' THEN 'BS_TC_OWN'
      WHEN NUMERIC '285540006' THEN 'BS_TC_OTH'
      WHEN NUMERIC '285540007' THEN 'BS_TC_DMG'
      WHEN NUMERIC '285540008' THEN 'BS_TC_NAT'
      WHEN NUMERIC '285540009' THEN 'BS_TC_SRR'
      WHEN NUMERIC '285540010' THEN 'BS_TC_SMC'
      WHEN NUMERIC '285540011' THEN 'BS_TC_SSS'
      WHEN NUMERIC '285540012' THEN 'BS_TC_FMW'
      WHEN NUMERIC '285540013' THEN 'BS_TC_SCC'
    END AS real_estate_status_reason_cd,
    NULL AS comment_txt,
    'LISY' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    -- parse the closing date from string YYYYMMDD to DATETIME
    SAFE.PARSE_DATETIME('%Y%m%d', src.igl_closingdatefrom) AS dwh_mapping_tmsp,
    CASE
      WHEN (src.igl_reopeningdate IS NULL
           OR src.igl_reopeningdate < src.igl_closingdatefrom)
           AND src.igl_closingdateto >= src.igl_closingdatefrom
      THEN
        DATETIME_ADD(
          DATETIME_SUB(
            SAFE.PARSE_DATETIME('%Y%m%d', src.igl_closingdateto),
            INTERVAL 1 MICROSECOND
          ),
          INTERVAL 1 DAY
        )
      ELSE
        DATETIME_ADD(
          DATETIME_SUB(
            SAFE.PARSE_DATETIME('%Y%m%d', src.igl_reopeningdate),
            INTERVAL 1 MICROSECOND
          ),
          INTERVAL 1 DAY
        )
    END AS dwh_ending_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'LISY' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM
  etl_process.t_${src_input_table} AS src
WHERE
  src.igl_number IS NOT NULL -- (only objects with assigned object number should be kept)
  AND src.igl_closingdatefrom IS NOT NULL
  AND (
       src.igl_closingdateto IS NOT NULL
    OR src.igl_reopeningdate IS NOT NULL
  )
  AND (
       src.igl_closingdateto >= src.igl_closingdatefrom
    OR src.igl_reopeningdate >= src.igl_closingdatefrom
  )
  AND src.deleted <> 'x'
QUALIFY
  ROW_NUMBER() OVER (
    PARTITION BY src.igl_number, src.igl_closingdatefrom
    ORDER BY
      IF(src.extraction_ts IS NULL, 0, 1) DESC,
      src.extraction_ts DESC
  ) = NUMERIC '1'
;
