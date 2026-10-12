INSERT INTO ${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, dwh_valid_fg, record_id, dwh_mapping_tmsp, filename, party_sid,
 declarant_authorized_fg, declarant_nr, declarant_type_cd, declarant_type_name, declarant_name,
 declarant_auth_status_name, declarant_auth_status_cd)
(SELECT dwh_src_file_name,
  tf_error_fg,
  dwh_src_1_tmsp,
   deleted_fg <> 0 AS deleted_fg,
  dwh_valid_fg,
  CAST(record_id AS STRING) AS record_id,
  dwh_mapping_tmsp,
  filename,
  party_sid,
  declarant_authorized_fg,
  broker_number,
  declarant_type_cd,
  declarant_type_name,
  broker_name,
  declarant_auth_status_name,
  declarant_auth_status_cd
 FROM (SELECT b.party_sid,
     'BROKER' AS declarant_type_cd,
     'Broker' AS declarant_type_name,
     b.broker_number,
     b.broker_name,
     s.declarant_auth_status_cd,
     s.declarant_auth_status_name,
     s.declarant_authorized_fg,
     b.dwh_valid_fg,
     b.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
     b.dwh_src_file_name,
     b.dwh_src_1_tmsp,
     0 AS tf_error_fg,
     0 AS record_id,
     b.dwh_src_file_name AS filename,
     0 AS deleted_fg
    FROM szd_production_core_rel.t_broker_1 AS b
     INNER JOIN szd_production_core.t_dim_declarant_auth_status_1 AS s ON b.broker_authorized_fg = s.declarant_authorized_fg
        AND s.declarant_auth_status_cd <> '-1'
    WHERE b.party_sid <> - 1
    UNION DISTINCT
    SELECT i.party_sid,
     'IMPORTER' AS declarant_type_cd,
     'Importer' AS declarant_type_name,
     i.importer_number AS declarant_number,
     i.importer_name AS declarant_name,
     s.declarant_auth_status_cd,
     s.declarant_auth_status_name,
     s.declarant_authorized_fg,
     i.dwh_valid_fg,
     i.dwh_valid_from_tmsp AS dwh_mapping_tmsp,
     i.dwh_src_file_name,
     i.dwh_src_1_tmsp,
     0 AS tf_error_fg,
     0 AS record_id,
     i.dwh_src_file_name AS filename,
     0 AS deleted_fg
    FROM szd_production_core_rel.t_importer_1 AS i
     INNER JOIN szd_production_core.t_dim_declarant_auth_status_1 AS s ON s.declarant_authorized_fg AND s.declarant_auth_status_cd
        <> '-1'
    WHERE i.party_sid <> - 1) AS t3);