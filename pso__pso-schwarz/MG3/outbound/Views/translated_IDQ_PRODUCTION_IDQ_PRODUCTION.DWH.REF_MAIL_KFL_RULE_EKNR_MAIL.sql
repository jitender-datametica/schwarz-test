CREATE OR REPLACE VIEW idq_production_dwh.ref_mail_kfl_rule_eknr_mail (ref_mail_kfl_rule_eknr_mail_id, ref_country_id,
ref_rule_id, ref_mail_kfl_eknr_id, ref_mail_kfl_mail_id, ref_mail_kfl_rule_eknr_flag_id, ref_source_system_type_id) AS
SELECT id AS ref_mail_kfl_rule_eknr_mail_id,
 country_id AS ref_country_id,
 rule_id AS ref_rule_id,
 mail_ek_nr_id AS ref_mail_kfl_eknr_id,
 mail_id AS ref_mail_kfl_mail_id,
 ref_mail_kfl_rule_eknr_flag_id,
 14 AS ref_source_system_type_id
FROM idq_production_idq_results.ref_mail_kfl_rule_eknr_mail;