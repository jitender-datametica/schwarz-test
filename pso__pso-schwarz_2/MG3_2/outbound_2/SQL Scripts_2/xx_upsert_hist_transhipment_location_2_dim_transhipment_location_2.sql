INSERT INTO szd_producton.${temp_db}.${src2tgt_temp_table1}_${src_context_area} (
  location_sid,
  country_location_sid,
  iso_country_cd,
  country_name_de,
  country_name_en,
  transhipment_location_cd,
  transhipment_location_name,
  city_name,
  transhipment_location_type_cd,
  transhipment_location_type_name,
  dwh_valid_fg,
  dwh_mapping_tmsp,
  dwh_src_file_name,
  dwh_src_1_tmsp,
  tf_error_fg,
  record_id,
  filename,
  deleted_fg
)
SELECT DISTINCT
  tl.location_sid,
  tl.country_location_sid,
  cp_de.iso_country_cd,
  cp_de.country_name AS country_name_de,
  cp_en.country_name AS country_name_en,
  tl.transhipment_location_cd,
  tl.transhipment_location_name,
  tl.city_name,
  tl.transhipment_location_type_cd,
  tlt.transhipment_location_type_descr,
  tl.dwh_valid_fg,
  tl.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  tl.dwh_src_file_name,
  tl.dwh_src_1_tmsp,
  CAST('0' AS NUMERIC) AS tf_error_fg,
  CAST('0' AS NUMERIC) AS record_id,
  tl.dwh_src_file_name AS filename,
  CAST('0' AS NUMERIC) AS deleted_fg
FROM szd_production.core_rel.t_transhipment_location_2 AS tl
LEFT OUTER JOIN szd_production.core_rel.t_country_political_2 AS cp_de
  ON tl.country_location_sid = cp_de.location_sid
  AND (
    tl.country_location_sid <> -CAST('1' AS NUMERIC)
    OR tl.location_sid = -CAST('1' AS NUMERIC)
  )
  AND cp_de.lang_cd = CASE tl.country_location_sid WHEN -CAST('1' AS NUMERIC) THEN '-1' ELSE 'DE' END
LEFT OUTER JOIN szd_production.core_rel.t_country_political_2 AS cp_en
  ON tl.country_location_sid = cp_en.location_sid
  AND (
    tl.country_location_sid <> -CAST('1' AS NUMERIC)
    OR tl.location_sid = -CAST('1' AS NUMERIC)
  )
  AND cp_en.lang_cd = CASE tl.country_location_sid WHEN -CAST('1' AS NUMERIC) THEN '-1' ELSE 'EN' END
INNER JOIN szd_production.core_rel.t_transhipment_location_type_2 AS tlt
  ON tl.transhipment_location_type_cd = tlt.transhipment_location_type_cd
WHERE
  tl.location_sid <> -CAST('1' AS NUMERIC)
  AND tl.dwh_valid_fg
  AND (
    tl.country_location_sid <> -CAST('1' AS NUMERIC)
    OR tl.location_sid = -CAST('1' AS NUMERIC)
  );