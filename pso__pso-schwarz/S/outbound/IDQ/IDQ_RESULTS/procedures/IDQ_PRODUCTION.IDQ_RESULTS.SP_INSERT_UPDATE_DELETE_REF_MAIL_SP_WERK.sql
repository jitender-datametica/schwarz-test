CREATE OR REPLACE PROCEDURE idq_results.sp_insert_update_delete_ref_mail_sp_werk(IN REF_MAIL_SP_WERK_ID INT64, IN WERK STRING, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE WERK_exist INT64;
BEGIN TRANSACTION;
SET WERK_exist  =  (SELECT id
FROM idq_results.ref_mail_sp_werk
WHERE werk = WERK);

IF DEL = 1 THEN
    DELETE FROM idq_results.ref_mail_sp_werk
WHERE id = REF_MAIL_SP_WERK_ID;
ELSEIF REF_MAIL_SP_WERK_ID = 0 AND DEL = 0 AND WERK_exist IS NULL THEN
    INSERT INTO idq_results.ref_mail_sp_werk (id, werk)
(SELECT (SELECT MAX(id) + 1
            FROM idq_results.ref_mail_sp_werk) AS id, WERK AS werk);
ELSE MERGE INTO idq_results.ref_mail_sp_werk AS TARGET
USING (SELECT REF_MAIL_SP_WERK_ID AS id) AS SOURCE
ON TARGET.id = SOURCE.id
WHEN MATCHED AND TARGET.werk <> WERK THEN UPDATE SET
    werk = WERK;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
