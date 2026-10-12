
-- cpc.dwh_valid_from_tmsp dwh_mapping_tmsp,
 -- cpc.dwh_valid_fg,
 -- dwh_valid_fg,
 INSERT INTO
${temp_db}.${src2tgt_temp_table1}_${src_context_area} (dwh_src_file_name
 , tf_error_fg, dwh_src_1_tmsp, deleted_fg, record_id, dwh_mapping_tmsp, filename, requested_procedure_cd,
 requested_procedure_descr, customs_procedure_cd, dwh_load_id, customs_procedure_approve_status_name,
 additional_procedure_descr, customs_procedure_approved_fg, additional_procedure_cd, customs_procedure_approve_status_cd
 )
(SELECT cpc.dwh_src_file_name,
  0 AS tf_error_fg,
  cpc.dwh_src_1_tmsp,
  CAST(0 AS BOOL) AS deleted_fg,
  CAST(0 AS STRING) AS record_id,
  cpc.dwh_src_1_tmsp AS dwh_mapping_tmsp,
  cpc.dwh_src_file_name AS filename,
  COALESCE(crc.requested_procedure_cd, '-1') AS requested_procedure_cd,
  COALESCE(crc.requested_procedure_descr, 'Unknown') AS requested_procedure_descr,
  cpc.customs_procedure_cd,
  0 AS dwh_load_id,
  cpa.customs_procedure_approve_status_name,
  COALESCE(cac.additional_procedure_descr, 'Unknown') AS additional_procedure_descr,
  cpa.customs_procedure_approved_fg,
  COALESCE(cac.additional_procedure_cd, '-1') AS additional_procedure_cd,
  cpa.customs_procedure_approve_status_cd
 FROM szd_production_core_rel.t_customs_procedure_1 AS cpc
  INNER JOIN szd_production_core.t_dim_customs_procedure_approve_status_1 AS cpa ON CASE
    WHEN cpc.customs_procedure_cd = '-1'
    THEN '-1'
    WHEN cpc.approved_fg
    THEN 'APPROVED'
    ELSE 'NOT_APPROVED'
    END = cpa.customs_procedure_approve_status_cd
  LEFT JOIN szd_production_core_rel.t_customs_requested_procedure_1 AS crc ON cpc.requested_procedure_cd = crc.requested_procedure_cd
   
  LEFT JOIN szd_production_core_rel.t_customs_additional_procedure_1 AS cac ON cpc.additional_procedure_cd = cac.additional_procedure_cd
   );