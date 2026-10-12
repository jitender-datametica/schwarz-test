--SP_INSERT_UPDATE_DELETE_REF_REL_SCOPE_NOTIFICATION_MAIL( NUMBER, STRING , NUMBER, STRING , NUMBER, NUMBER)



CREATE OR REPLACE PROCEDURE idq_results.sp_insert_update_delete_ref_rel_scope_notification_mail(IN REF_REL_SCOPE_NOTIFICATION_MAIL_ID INT64, IN REF_SCOPE_ID STRING, IN REF_NOTIFICATION_ID INT64, IN EMAIL STRING, IN FREQUENCY INT64, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE Notification_Mail_exist INT64;
BEGIN TRANSACTION;
SET Notification_Mail_exist  =  (SELECT id
FROM idq_results.ref_rel_scope_notification_mail_2
WHERE scope_id = CAST(REF_SCOPE_ID AS FLOAT64) AND notification_id = REF_NOTIFICATION_ID AND email = EMAIL AND frequency = FREQUENCY);

IF DEL = 1 THEN
    BEGIN
    DELETE FROM idq_results.ref_rel_scope_notification_mail_2
WHERE id = REF_REL_SCOPE_NOTIFICATION_MAIL_ID;
    -- INSERT NEW MAIL
    END;
ELSEIF REF_REL_SCOPE_NOTIFICATION_MAIL_ID = 0 AND DEL = 0 AND Notification_Mail_exist IS NULL THEN
    BEGIN
    INSERT INTO idq_results.ref_rel_scope_notification_mail_2 (id, scope_id, notification_id, email, frequency, inserted_at)
(SELECT (SELECT MAX(id) + 1
            FROM idq_results.ref_rel_scope_notification_mail_2) AS id, CAST(REF_SCOPE_ID AS INTEGER) AS scope_id, REF_NOTIFICATION_ID AS notification_id, EMAIL AS email, FREQUENCY AS frequency, CURRENT_DATETIME() AS inserted_at);
    -- Abort inserting existing combination mail
    --elseIF (:REF_REL_SCOPE_NOTIFICATION_MAIL_ID = 0 AND :DEL = 0 and Notification_Mail_exist is not NULL) THEN
    -- Update existing row with new mail
    END;
ELSE MERGE INTO idq_results.ref_rel_scope_notification_mail_2 AS TARGET
USING (SELECT REF_REL_SCOPE_NOTIFICATION_MAIL_ID AS id) AS SOURCE
ON TARGET.id = SOURCE.id
WHEN MATCHED AND TARGET.email <> EMAIL THEN UPDATE SET
    email = EMAIL;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;

