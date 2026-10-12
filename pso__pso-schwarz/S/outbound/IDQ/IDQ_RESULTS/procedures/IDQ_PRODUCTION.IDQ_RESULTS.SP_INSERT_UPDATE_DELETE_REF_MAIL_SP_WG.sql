CREATE OR REPLACE PROCEDURE idq_results.sp_insert_update_delete_ref_mail_sp_wg(IN REF_MAIL_SP_WG_ID INT64, IN WG STRING, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE WG_exist INT64;
BEGIN TRANSACTION;
SET WG_exist  =  (SELECT id
FROM idq_results.ref_mail_sp_wg
WHERE wg = WG);

IF DEL = 1 THEN
    DELETE FROM idq_results.ref_mail_sp_wg
WHERE id = REF_MAIL_SP_WG_ID;
ELSEIF REF_MAIL_SP_WG_ID = 0 AND DEL = 0 AND WG_exist IS NULL THEN
    INSERT INTO idq_results.ref_mail_sp_wg (id, wg)
(SELECT (SELECT MAX(id) + 1
            FROM idq_results.ref_mail_sp_wg) AS id, WG AS wg);
ELSE MERGE INTO idq_results.ref_mail_sp_wg AS TARGET
USING (SELECT REF_MAIL_SP_WG_ID AS id) AS SOURCE
ON TARGET.id = SOURCE.id
WHEN MATCHED AND TARGET.wg <> WG THEN UPDATE SET
    wg = WG;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;

