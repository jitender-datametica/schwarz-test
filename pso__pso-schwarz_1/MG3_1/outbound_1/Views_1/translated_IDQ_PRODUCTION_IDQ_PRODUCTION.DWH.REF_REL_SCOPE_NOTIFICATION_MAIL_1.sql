CREATE OR REPLACE VIEW idq_production_dwh.ref_rel_scope_notification_mail_1 (ref_rel_scope_notification_mail_id,
ref_scope_id, ref_notification_id, email, frequency, inserted_at, ref_source_system_type_id) AS SELECT rrsnm.id AS
 ref_rel_scope_notification_mail_id,
 rrsnm.scope_id AS ref_scope_id,
 rrsnm.notification_id AS ref_notification_id,
 rrsnm.email,
 rrsnm.frequency,
 rrsnm.inserted_at,
 rs.source_system_type_id AS ref_source_system_type_id
FROM idq_production_idq_results.ref_rel_scope_notification_mail_1 AS rrsnm
 INNER JOIN idq_production_idq_results.ref_scope_1 AS rs_1 ON rrsnm.scope_id = rs.id;