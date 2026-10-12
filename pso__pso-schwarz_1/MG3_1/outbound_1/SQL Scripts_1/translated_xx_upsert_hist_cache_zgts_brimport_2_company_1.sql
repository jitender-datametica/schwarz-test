
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, company_id, party_key_type_cd,
 source_company_name_address_city_txt, company_type_cd, company_name, company_nr, company_status_cd)
(SELECT ct.dwh_src_file_name,
  ct.tf_error_fg,
  ct.dwh_src_1_tmsp,
   ct.deleted_fg <> 0 AS deleted_fg,
  CAST(ct.record_id AS STRING) AS record_id,
  ct.dwh_mapping_tmsp,
  ct.filename,
  ct.company_id,
  ct.party_key_type_cd,
  ct.source_company_name_address_city_txt,
  ct.company_type_cd,
  ct.company_name,
  CAST(ct.company_nr AS STRING) AS company_nr,
  ct.company_status_cd
 FROM (SELECT *
   FROM (SELECT DISTINCT NULL AS company_nr,
       TRIM(parno_car_name1) AS company_name,
       '-1' AS company_id,
       'HAULER' AS company_type_cd,
       'HAULER' AS party_key_type_cd,
       dwh_src_file_name,
       TRIM(parno_car_name1) AS source_company_name_address_city_txt,
       'A' AS company_status_cd,
       dwh_src_1_tmsp,
       dwh_src_1_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       dwh_src_file_name AS filename
      FROM szd_production_etl.t_cache_zgts_brimport_1
      UNION DISTINCT
      SELECT DISTINCT NULL AS company_nr,
       SUBSTR(UPPER(TRIM(entitaetsnr)), 1, 100) AS company_name,
       '-1' AS company_id,
       'HAULER' AS company_type_cd,
       'HAULER' AS party_key_type_cd,
       dwh_src_file_name,
       UPPER(TRIM(entitaetsnr)) AS source_company_name_address_city_txt,
       'A' AS company_status_cd,
       dwh_src_1_tmsp,
       dwh_src_1_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       dwh_src_file_name AS filename
      FROM szd_production_etl.t_cache_sventitaet_1
      WHERE entitaetsart = 'SPED'
       AND entitaetsnr IS NOT NULL)
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY source_company_name_address_city_txt ORDER BY dwh_src_file_name IS NULL,
         dwh_src_file_name)) = 1) AS ct
  LEFT JOIN szd_production_meta.t_party_key_1 AS pk ON ct.party_key_type_cd = pk.party_key_type_cd AND TRIM(ct.source_company_name_address_city_txt
     ) = pk.party_nat_key_nr
  LEFT JOIN szd_production_core_rel.t_company_1 AS c ON pk.party_sid = c.party_sid
 WHERE c.party_sid IS NULL);