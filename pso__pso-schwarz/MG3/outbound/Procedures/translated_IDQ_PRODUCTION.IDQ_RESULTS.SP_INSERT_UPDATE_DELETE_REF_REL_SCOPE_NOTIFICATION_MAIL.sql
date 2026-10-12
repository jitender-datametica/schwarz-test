CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_update_delete_ref_rel_scope_notification_mail(IN REF_REL_SCOPE_NOTIFICATION_MAIL_ID INT64, IN REF_SCOPE_ID STRING, IN REF_NOTIFICATION_ID INT64, IN EMAIL STRING, IN FREQUENCY INT64, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE Notification_Mail_exist INT64;
SET Notification_Mail_exist  =  (SELECT id
FROM idq_production_idq_results.ref_rel_scope_notification_mail
WHERE scope_id = CAST(REF_SCOPE_ID AS FLOAT64) AND notification_id = REF_NOTIFICATION_ID AND email = EMAIL AND frequency = FREQUENCY);

IF DEL = 1 THEN
    DELETE FROM idq_production_idq_results.ref_rel_scope_notification_mail
WHERE id = REF_REL_SCOPE_NOTIFICATION_MAIL_ID;
ELSEIF REF_REL_SCOPE_NOTIFICATION_MAIL_ID = 0 AND DEL = 0 AND Notification_Mail_exist IS NULL THEN
    INSERT INTO idq_production_idq_results.ref_rel_scope_notification_mail (id, scope_id, notification_id, email, frequency, inserted_at)
(SELECT (SELECT MAX(id) + 1
            FROM idq_production_idq_results.ref_rel_scope_notification_mail) AS id, CAST(REF_SCOPE_ID AS INTEGER) AS scope_id, REF_NOTIFICATION_ID AS notification_id, EMAIL AS email, FREQUENCY AS frequency, CURRENT_DATETIME() AS inserted_at);
ELSE
    MERGE INTO idq_production_idq_results.ref_rel_scope_notification_mail AS target
USING (SELECT REF_REL_SCOPE_NOTIFICATION_MAIL_ID AS id) AS SOURCE
ON target.id = SOURCE.id
WHEN MATCHED AND target.email <> EMAIL THEN UPDATE SET
    email = EMAIL;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
