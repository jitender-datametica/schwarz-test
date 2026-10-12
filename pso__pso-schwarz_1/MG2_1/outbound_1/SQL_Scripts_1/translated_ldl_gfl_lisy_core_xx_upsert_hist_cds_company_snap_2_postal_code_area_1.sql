INSERT INTO etl.${src2tgt_temp_table1}_${src_context_area} (
  postal_cd_area_nat_key_nr,
  postal_cd_area_key_type_cd,
  country_nat_key_nr,
  country_key_type_cd,
  iso_country_cd,
  country_name,
  zip,
  postal_cd_area_name,
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
    CONCAT(COALESCE(src.igl_isocode2, ''), '|', COALESCE(src.igl_postalcode, '')) AS postal_cd_area_nat_key_nr,
    'ZIP' AS postal_cd_area_key_type_cd,
    COALESCE(src.igl_isocode2, '') AS country_nat_key_nr,
    'CTRY' AS country_key_type_cd,
    CASE
      WHEN igl_isocode2 = 'NI' THEN 'GB'
      ELSE igl_isocode2
    END AS iso_country_cd,
    CASE
      WHEN igl_isocode2 = 'NI' THEN 'Vereinigtes Königreich'
      ELSE ctry.country_name
    END AS country_name,
    src.igl_postalcode AS zip,
    '' AS postal_cd_area_name,
    'LISY' AS source_system,
    CURRENT_DATE() AS extraction_dt,
    src.sinkmodifiedon AS dwh_mapping_tmsp,
    NUMERIC '0' AS tf_error_fg,
    NUMERIC '0' AS deleted_fg,
    NUMERIC '0' AS record_id,
    't_${SRC_INPUT_TABLE}' AS filename,
    'LISY' AS dwh_node_cd,
    '${LOAD_ID}' AS dwh_load_id
FROM
  etl_process.t_${src_input_table} AS src
  LEFT JOIN core_rel.t_country_1 AS ctry
    ON src.igl_isocode2 = ctry.iso_country_cd
WHERE
  src.igl_isocode2 IS NOT NULL
  AND src.igl_postalcode IS NOT NULL
  AND src.deleted <> 'x'
-- "Grossebersdorf" is same as "Großebersdorf" when converted to UPPER
-- so we eliminate such duplicates of NK by taking the longer ( "ss" instead of "ß")
QUALIFY
  ROW_NUMBER() OVER (
    PARTITION BY CONCAT(src.igl_isocode2, '|', UPPER(COALESCE(zip, postal_cd_area_name)))
    ORDER BY
      IF(LENGTH(CONCAT(src.igl_isocode2, '|', UPPER(COALESCE(zip, postal_cd_area_name)))) IS NULL, 0, 1) DESC,
      CAST(LENGTH(CONCAT(src.igl_isocode2, '|', UPPER(COALESCE(zip, postal_cd_area_name)))) AS BIGNUMERIC),
      IF(src.sinkmodifiedon IS NULL, 0, 1),
      src.sinkmodifiedon DESC
  ) = NUMERIC '1'
;
