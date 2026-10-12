CREATE OR REPLACE PROCEDURE idq_results.sp_insert_update_delete_ref_mail_sp_matart(IN REF_MAIL_SP_MATART_ID INT64, IN MATART STRING, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE MATART_exist INT64;
BEGIN TRANSACTION;
SET MATART_exist  =  (SELECT id
FROM idq_results.ref_mail_sp_matart_1
WHERE matart = MATART);

IF DEL = 1 THEN
    DELETE FROM idq_results.ref_mail_sp_matart_1
WHERE id = REF_MAIL_SP_MATART_ID;
ELSEIF REF_MAIL_SP_MATART_ID = 0 AND DEL = 0 AND MATART_exist IS NULL THEN
    INSERT INTO idq_results.ref_mail_sp_matart_1 (id, matart)
(SELECT (SELECT MAX(id) + 1
            FROM idq_results.ref_mail_sp_matart_1) AS id, MATART AS matart);
ELSE MERGE INTO idq_results.ref_mail_sp_matart_1 AS TARGET
USING (SELECT REF_MAIL_SP_MATART_ID AS id) AS SOURCE
ON TARGET.id = SOURCE.id
WHEN MATCHED AND TARGET.matart <> MATART THEN UPDATE SET
    matart = MATART;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
