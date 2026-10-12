CREATE OR REPLACE VIEW idq_production_dwh.ref_mail_sp_rule_werk_flag_1 (ref_mail_sp_rule_werk_flag_id, ref_rule_id,
ref_branch_id, werk_flag, matart_flag, wg_flag, ref_source_system_type_id) AS SELECT id AS ref_mail_sp_rule_werk_flag_id
 ,
 rule_id AS ref_rule_id,
 branch_id AS ref_branch_id,
 werk_flag,
 matart_flag,
 wg_flag,
 24 AS ref_source_system_type_id
FROM idq_production_idq_results.ref_mail_sp_rule_werk_flag_1;