CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_update_delete_ref_mail_sp_wg(IN REF_MAIL_SP_WG_ID BIGNUMERIC, IN WG STRING, IN DEL BIGNUMERIC, OUT out_param INT64)
BEGIN
DECLARE WG_exist BIGNUMERIC;
BEGIN TRANSACTION;
SET WG_exist  =  (SELECT id
FROM idq_production_idq_results.ref_mail_sp_wg_2
WHERE wg = WG);

IF DEL = 1 THEN
    DELETE FROM idq_production_idq_results.ref_mail_sp_wg_2
WHERE id = REF_MAIL_SP_WG_ID;
ELSEIF REF_MAIL_SP_WG_ID = 0 AND DEL = 0 AND WG_exist IS NULL THEN
    INSERT INTO idq_production_idq_results.ref_mail_sp_wg_2 (id, wg)
(SELECT (SELECT MAX(id) + 1
            FROM idq_production_idq_results.ref_mail_sp_wg_2) AS id, WG AS wg);
ELSE MERGE INTO idq_production_idq_results.ref_mail_sp_wg_2 AS TARGET
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
