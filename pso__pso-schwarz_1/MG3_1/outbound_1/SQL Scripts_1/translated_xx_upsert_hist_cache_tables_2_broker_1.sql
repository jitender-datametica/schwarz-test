
INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, party_key_type_cd, broker_number,
 broker_name, broker_authorized_fg, broker_party_id, broker_postcode)
(SELECT ct.dwh_src_file_name,
  ct.tf_error_fg,
  ct.dwh_src_1_tmsp,
   ct.deleted_fg <> 0 AS deleted_fg,
  CAST(ct.record_id AS STRING) AS record_id,
  ct.dwh_mapping_tmsp,
  ct.filename,
  ct.party_key_type_cd,
  ct.broker_number,
  ct.broker_name,
   ct.broker_authorized_fg <> 0 AS broker_authorized_fg,
  ct.broker_party_id,
  CAST(ct.broker_postcode AS STRING) AS broker_postcode
 FROM (SELECT *
   FROM (((SELECT DISTINCT 'BROKER' AS party_key_type_cd,
         declarant_eori AS broker_party_id,
         declarant_eori AS broker_number,
         COALESCE(NULLIF(declarant_name, 'NULL'), 'Unknown') AS broker_name,
         NULL AS broker_postcode,
         0 AS broker_authorized_fg,
         dwh_src_file_name,
         dwh_src_1_tmsp,
         dwh_src_1_tmsp AS dwh_mapping_tmsp,
         0 AS tf_error_fg,
         0 AS deleted_fg,
         0 AS record_id,
         dwh_src_file_name AS filename
        FROM szd_production_etl.t_cache_ceva_1
        WHERE declarant_eori <> 'NULL'
        UNION DISTINCT
        SELECT DISTINCT 'BROKER' AS party_key_type_cd,
         declarant_eori AS broker_party_id,
         declarant_eori AS broker_number,
         COALESCE(NULLIF(declarant_name, 'NULL'), 'Unknown') AS broker_name,
         NULL AS broker_postcode,
         0 AS broker_authorized_fg,
         dwh_src_file_name,
         dwh_src_1_tmsp,
         dwh_src_1_tmsp AS dwh_mapping_tmsp,
         0 AS tf_error_fg,
         0 AS deleted_fg,
         0 AS record_id,
         dwh_src_file_name AS filename
        FROM szd_production_etl.t_cache_maersk_lgb_1
        WHERE declarant_eori <> 'NULL')
       UNION DISTINCT
       SELECT DISTINCT 'BROKER' AS party_key_type_cd,
        declarant_eori AS broker_party_id,
        declarant_eori AS broker_number,
        COALESCE(NULLIF(declarant_name, 'NULL'), 'Unknown') AS broker_name,
        NULL AS broker_postcode,
        0 AS broker_authorized_fg,
        dwh_src_file_name,
        dwh_src_1_tmsp,
        dwh_src_1_tmsp AS dwh_mapping_tmsp,
        0 AS tf_error_fg,
        0 AS deleted_fg,
        0 AS record_id,
        dwh_src_file_name AS filename
       FROM szd_production_etl.t_cache_maersk_lukt_1
       WHERE declarant_eori <> 'NULL')
      UNION DISTINCT
      SELECT DISTINCT 'BROKER' AS party_key_type_cd,
       declarant_eori AS broker_party_id,
       declarant_eori AS broker_number,
       COALESCE(NULLIF(declarant_name, 'NULL'), 'Unknown') AS broker_name,
       NULL AS broker_postcode,
       0 AS broker_authorized_fg,
       dwh_src_file_name,
       dwh_src_1_tmsp,
       dwh_src_1_tmsp AS dwh_mapping_tmsp,
       0 AS tf_error_fg,
       0 AS deleted_fg,
       0 AS record_id,
       dwh_src_file_name AS filename
      FROM szd_production_etl.t_cache_cds_header_1
      WHERE declarant_eori <> 'NULL')
   QUALIFY (ROW_NUMBER() OVER (PARTITION BY broker_party_id ORDER BY dwh_src_file_name IS NULL, dwh_src_file_name)) = 1
   ) AS ct
  LEFT JOIN szd_production_meta.t_party_key_1 AS pk ON ct.broker_party_id = pk.party_nat_key_nr AND pk.party_key_type_cd =
    'BROKER'
  LEFT JOIN szd_production_core_rel.t_broker_1 AS b ON pk.party_sid = b.party_sid
 WHERE b.party_sid IS NULL);