CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_update_delete_ref_mail_sp_werk(IN REF_MAIL_SP_WERK_ID BIGNUMERIC, IN WERK STRING, IN DEL BIGNUMERIC, OUT out_param INT64)
BEGIN 
DECLARE WERK_exist BIGNUMERIC;
BEGIN TRANSACTION;
SET WERK_exist  =  (SELECT id
FROM idq_production_idq_results.ref_mail_sp_werk_1
WHERE werk = WERK);

IF DEL = 1 THEN
    DELETE FROM idq_production_idq_results.ref_mail_sp_werk_1
WHERE id = REF_MAIL_SP_WERK_ID;
ELSEIF REF_MAIL_SP_WERK_ID = 0 AND DEL = 0 AND WERK_exist IS NULL THEN
    INSERT INTO idq_production_idq_results.ref_mail_sp_werk_1 (id, werk)
(SELECT (SELECT MAX(id) + 1
            FROM idq_production_idq_results.ref_mail_sp_werk_1) AS id, WERK AS werk);
ELSE MERGE INTO idq_production_idq_results.ref_mail_sp_werk_1 AS TARGET
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
