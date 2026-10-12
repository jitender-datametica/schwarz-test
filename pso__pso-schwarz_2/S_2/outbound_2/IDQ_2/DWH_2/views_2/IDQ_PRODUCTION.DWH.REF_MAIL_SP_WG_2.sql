CREATE OR REPLACE VIEW idq_production_dwh.ref_mail_sp_wg_2 (ref_mail_sp_wg_id, wg, ref_source_system_type_id) AS SELECT id
  AS ref_mail_sp_wg_id,
 wg,
 24 AS ref_source_system_type_id
FROM idq_production_idq_results.ref_mail_sp_wg_2;