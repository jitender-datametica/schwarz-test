
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, agreement_sid,
 origin_country_location_sid, origin_country_name_de, import_country_name_de, origin_iso_country_cd,
 origin_country_name_en, import_country_name_en, free_trade_agreement_category_descr, import_iso_country_cd,
 import_country_location_sid, free_trade_agreement_category_cd, free_trade_agreement_category_name)
(SELECT DISTINCT fta.dwh_src_file_name,
  0 AS tf_error_fg,
  fta.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  fta.dwh_valid_fg,
  CAST(0 AS STRING) AS record_id,
  fta.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  fta.dwh_src_file_name AS filename,
  fta.agreement_sid,
  fta.origin_country_location_sid,
  COALESCE(oct_de.country_name, 'Unbekannt') AS origin_country_name_de,
  COALESCE(ict_de.country_name, 'Unbekannt') AS import_country_name_de,
  COALESCE(oct_de.iso_country_cd, 'UNKNOWN') AS origin_iso_country_cd,
  COALESCE(oct_en.country_name, 'Unknown') AS origin_country_name_en,
  COALESCE(ict_en.country_name, 'Unknown') AS import_country_name_en,
  cta.free_trade_agreement_category_descr,
  COALESCE(ict_de.iso_country_cd, 'UNKNOWN') AS import_iso_country_cd,
  fta.import_country_location_sid,
  fta.free_trade_agreement_category_cd,
  cta.free_trade_agreement_category_name
 FROM szd_production_core_rel.t_free_trade_agreement_rel_1 AS fta
  LEFT JOIN szd_production_core_rel.t_country_political_1 AS ict_de ON fta.import_country_location_sid = ict_de.location_sid
     AND ict_de.lang_cd = 'DE'
  LEFT JOIN szd_production_core_rel.t_country_political_1 AS ict_en ON fta.import_country_location_sid = ict_en.location_sid
     AND ict_en.lang_cd = 'EN'
  LEFT JOIN szd_production_core_rel.t_country_political_1 AS oct_de ON fta.origin_country_location_sid = oct_de.location_sid
     AND oct_de.lang_cd = 'DE'
  LEFT JOIN szd_production_core_rel.t_country_political_1 AS oct_en ON fta.origin_country_location_sid = oct_en.location_sid
     AND oct_en.lang_cd = 'EN'
  LEFT JOIN szd_production_core_rel.t_free_trade_agreement_category_1 AS cta ON fta.free_trade_agreement_category_cd = cta
   .free_trade_agreement_category_cd
 WHERE fta.dwh_valid_fg);