CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_update_delete_ref_mail_sp_werk_mail(IN REF_MAIL_SP_WERK_MAIL_ID INT64, IN MAIL STRING, IN DEL INT64, IN RULE_ID INT64, IN WERK_ID INT64, IN WG_ID INT64, IN MATART_ID INT64, OUT out_param INT64)
BEGIN
DECLARE mail2_exist INT64;
BEGIN TRANSACTION;
SET mail2_exist  =  (SELECT id
FROM idq_production_idq_results.ref_mail_sp_mail
WHERE mail = MAIL);

IF 1 = DEL THEN

    DELETE FROM idq_production_idq_results.ref_mail_sp_rule_werk_mail
WHERE id = REF_MAIL_SP_WERK_MAIL_ID;
ELSEIF 0 = DEL AND 0 = REF_MAIL_SP_WERK_MAIL_ID AND mail2_exist IS NULL THEN
    BEGIN

    INSERT INTO idq_production_idq_results.ref_mail_sp_mail (id, mail)
(SELECT MAIL AS mail);
    SET mail2_exist  =  (SELECT id
FROM idq_production_idq_results.ref_mail_sp_mail
WHERE mail = MAIL);

    INSERT INTO idq_production_idq_results.ref_mail_sp_rule_werk_mail (id, rule_id, ref_mail_sp_werk_id, ref_mail_sp_matart_id, ref_mail_sp_wg_id, mail_id)
(SELECT (SELECT COALESCE(MAX(id), 0) + 1
            FROM idq_production_idq_results.ref_mail_sp_rule_werk_mail) AS id, RULE_ID AS rule_id, WERK_ID AS ref_mail_sp_werk_id, MATART_ID AS ref_mail_sp_matart_id, WG_ID AS ref_mail_sp_wg_id, mail2_exist AS mail_id);
    END;
ELSEIF 0 = DEL AND 0 = REF_MAIL_SP_WERK_MAIL_ID AND mail2_exist IS NOT NULL THEN

    INSERT INTO idq_production_idq_results.ref_mail_sp_rule_werk_mail (id, rule_id, ref_mail_sp_werk_id, ref_mail_sp_matart_id, ref_mail_sp_wg_id, mail_id)
(SELECT (SELECT COALESCE(MAX(id), 0) + 1
            FROM idq_production_idq_results.ref_mail_sp_rule_werk_mail) AS id, RULE_ID AS rule_id, WERK_ID AS ref_mail_sp_werk_id, MATART_ID AS ref_mail_sp_matart_id, WG_ID AS ref_mail_sp_wg_id, mail2_exist AS mail_id);
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
