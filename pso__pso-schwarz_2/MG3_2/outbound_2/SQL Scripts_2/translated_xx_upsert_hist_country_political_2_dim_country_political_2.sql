
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, curr_cd, latitude,
 eu_member_fg, location_sid, country_name_en, iso_country_cd, country_name_de, longitude)
(SELECT DISTINCT de.dwh_src_file_name,
  0 AS tf_error_fg,
  de.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(1 AS BOOL) AS dwh_valid_fg,
  CAST(0 AS STRING) AS record_id,
  de.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
  de.dwh_src_file_name AS filename,
  de.curr_cd,
  de.latitude,
  cur.country_location_sid IS NOT NULL AS eu_member_fg,
  de.location_sid,
  en.country_name AS country_name_en,
  de.iso_country_cd,
  de.country_name AS country_name_de,
  de.longitude
 FROM (SELECT *
   FROM szd_production_core_rel.t_country_political_2
   WHERE (lang_cd = 'DE' OR location_sid = - 1)
    AND dwh_valid_fg) AS de
  INNER JOIN (SELECT *
   FROM szd_production_core_rel.t_country_political_2
   WHERE (lang_cd = 'EN' OR location_sid = - 1)
    AND dwh_valid_fg) AS en ON de.location_sid = en.location_sid
  LEFT JOIN szd_production_core_rel.t_country_union_rel_2 AS cur ON de.location_sid = cur.country_location_sid AND cur.country_union_cd
     = 'EU'
 WHERE de.location_sid <> - 1);