CREATE OR REPLACE VIEW idq_production_dwh.ref_rel_scope_notification_mail_1 (ref_rel_scope_notification_mail_id,
ref_scope_id, ref_notification_id, email, frequency, inserted_at, ref_source_system_type_id) AS SELECT RRSNM.id AS
 ref_rel_scope_notification_mail_id,
 RRSNM.scope_id AS ref_scope_id,
 RRSNM.notification_id AS ref_notification_id,
 RRSNM.email,
 RRSNM.frequency,
 RRSNM.inserted_at,
 RS.source_system_type_id AS ref_source_system_type_id
FROM idq_production_idq_results.ref_rel_scope_notification_mail_1 AS RRSNM
 INNER JOIN idq_production_idq_results.ref_scope_1 AS RS_1 ON RRSNM.scope_id = RS.id;