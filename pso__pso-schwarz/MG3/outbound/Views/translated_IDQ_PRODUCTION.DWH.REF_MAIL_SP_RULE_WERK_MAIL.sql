CREATE OR REPLACE VIEW idq_production_dwh.ref_mail_sp_rule_werk_mail (ref_mail_sp_rule_werk_mail_id, ref_rule_id,
ref_mail_sp_werk_id, ref_mail_sp_matart_id, ref_mail_sp_wg_id, ref_mail_sp_mail_id, ref_source_system_type_id) AS SELECT
 id AS ref_mail_sp_rule_werk_mail_id,
 rule_id AS ref_rule_id,
 ref_mail_sp_werk_id,
 ref_mail_sp_matart_id,
 ref_mail_sp_wg_id,
 mail_id AS ref_mail_sp_mail_id,
 24 AS ref_source_system_type_id
FROM idq_production_idq_results.ref_mail_sp_rule_werk_mail;