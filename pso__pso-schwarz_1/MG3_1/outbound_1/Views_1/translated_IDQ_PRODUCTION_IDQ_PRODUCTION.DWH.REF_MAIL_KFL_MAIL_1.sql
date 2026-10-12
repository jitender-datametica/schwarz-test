CREATE OR REPLACE VIEW idq_production_dwh.ref_mail_kfl_mail_1 (ref_mail_kfl_mail_id, mail) AS SELECT id AS
 ref_mail_kfl_mail_id,
 mail
FROM idq_production_idq_results.ref_mail_kfl_mail_1;