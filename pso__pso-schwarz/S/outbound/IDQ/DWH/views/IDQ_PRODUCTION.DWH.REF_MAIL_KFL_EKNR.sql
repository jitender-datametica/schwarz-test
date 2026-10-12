CREATE OR REPLACE VIEW idq_production_dwh.ref_mail_kfl_eknr (ref_mail_kfl_eknr_id, ek_nr, ref_source_system_type_id) AS
SELECT id AS ref_mail_kfl_eknr_id,
 ek_nr,
 14 AS ref_source_system_type_id
FROM idq_production_idq_results.ref_mail_kfl_eknr;