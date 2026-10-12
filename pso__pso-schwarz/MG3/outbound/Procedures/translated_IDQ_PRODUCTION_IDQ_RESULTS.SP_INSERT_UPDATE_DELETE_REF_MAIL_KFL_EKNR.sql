CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_update_delete_ref_mail_kfl_eknr(IN REF_MAIL_KFL_EKNR_ID INT64, IN EK_NR STRING, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE EKNR_exist INT64;
BEGIN TRANSACTION;
SET EKNR_exist  =  (SELECT id
FROM idq_production_idq_results.ref_mail_kfl_eknr
WHERE ek_nr = EK_NR);

IF DEL = 1 THEN
    BEGIN

    DELETE FROM idq_production_idq_results.ref_mail_kfl_eknr
WHERE id = REF_MAIL_KFL_EKNR_ID;
    --  RETURN 0;
    -- END IF;
    -- INSERT NEW EKNR
    END;
ELSEIF REF_MAIL_KFL_EKNR_ID = 0 AND DEL = 0 AND EKNR_exist IS NULL THEN
    BEGIN

    INSERT INTO idq_production_idq_results.ref_mail_kfl_eknr (id, ek_nr)
(SELECT (SELECT MAX(id) + 1
            FROM idq_production_idq_results.ref_mail_kfl_eknr) AS id, EK_NR AS ek_nr);
    --   RETURN 0;
    --END IF;
    END;
ELSE

    MERGE INTO idq_production_idq_results.ref_mail_kfl_eknr AS target
USING (SELECT REF_MAIL_KFL_EKNR_ID AS id) AS SOURCE
ON target.id = SOURCE.id
WHEN MATCHED AND target.ek_nr <> EK_NR THEN UPDATE SET
    ek_nr = EK_NR;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
