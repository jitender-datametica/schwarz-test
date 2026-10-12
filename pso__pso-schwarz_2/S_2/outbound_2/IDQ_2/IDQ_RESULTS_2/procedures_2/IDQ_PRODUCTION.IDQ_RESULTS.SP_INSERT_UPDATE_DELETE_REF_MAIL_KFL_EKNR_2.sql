CREATE OR REPLACE PROCEDURE idq_results.sp_insert_update_delete_ref_mail_kfl_eknr(IN REF_MAIL_KFL_EKNR_ID INT64, IN EK_NR STRING, IN DEL INT64, OUT out_param INT64)
BEGIN

DECLARE EKNR_exist INT64;
BEGIN TRANSACTION;
SET EKNR_exist  =  (SELECT id
FROM idq_results.ref_mail_kfl_eknr_2
WHERE ek_nr = EK_NR);

IF DEL = 1 THEN
    DELETE FROM idq_results.ref_mail_kfl_eknr_2
WHERE id = REF_MAIL_KFL_EKNR_ID;
ELSEIF REF_MAIL_KFL_EKNR_ID = 0 AND DEL = 0 AND EKNR_exist IS NULL THEN
    INSERT INTO idq_results.ref_mail_kfl_eknr_2 (id, ek_nr)
(SELECT (SELECT MAX(id) + 1
            FROM idq_results.ref_mail_kfl_eknr_2) AS id, EK_NR AS ek_nr);
ELSE MERGE INTO idq_results.ref_mail_kfl_eknr_2 AS TARGET
USING (SELECT REF_MAIL_KFL_EKNR_ID AS id) AS SOURCE
ON TARGET.id = SOURCE.id
WHEN MATCHED AND TARGET.ek_nr <> EK_NR THEN UPDATE SET
    ek_nr = EK_NR;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;

