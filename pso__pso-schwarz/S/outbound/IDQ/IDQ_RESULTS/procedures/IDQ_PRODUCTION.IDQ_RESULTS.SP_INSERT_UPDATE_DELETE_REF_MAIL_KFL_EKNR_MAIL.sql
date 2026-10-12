CREATE OR REPLACE PROCEDURE idq_results.sp_insert_update_delete_ref_mail_kfl_eknr_mail(IN REF_MAIL_KFL_EKNR_MAIL_ID INT64, IN COUNTRY_ID INT64, IN CONTACT STRING, IN DEL INT64, IN RULE_ID INT64, IN EK_NR_ID INT64, IN FLAGGED INT64, OUT out_param INT64)
BEGIN
DECLARE mail_exist INT64;
DECLARE FLAGGED_RULE_COUNTRY_COMB INT64;
BEGIN TRANSACTION;
SET mail_exist  =  (SELECT id
FROM idq_results.ref_mail_kfl_mail
WHERE mail = CONTACT);

IF 1 = DEL THEN
    DELETE FROM idq_results.ref_mail_kfl_rule_eknr_mail
WHERE id = REF_MAIL_KFL_EKNR_MAIL_ID;
ELSEIF 0 = DEL AND 0 = REF_MAIL_KFL_EKNR_MAIL_ID AND mail_exist IS NULL AND EK_NR_ID > 0 THEN
    BEGIN
    INSERT INTO idq_results.ref_mail_kfl_mail (id, mail)
(SELECT CONTACT AS mail);
    SET mail_exist  =  (SELECT id
FROM idq_results.ref_mail_kfl_mail
WHERE mail = CONTACT);
    SET FLAGGED_RULE_COUNTRY_COMB  =  (SELECT ref_mail_kfl_rule_eknr_flag_id
FROM dwh.ref_mail_kfl_rule_eknr_flag
WHERE ek_nr_flag = FLAGGED AND ref_rule_id = RULE_ID AND ref_country_id = COUNTRY_ID);
    INSERT INTO idq_results.ref_mail_kfl_rule_eknr_mail (id, country_id, rule_id, mail_ek_nr_id, mail_id, ref_mail_kfl_rule_eknr_flag_id)
(SELECT COUNTRY_ID AS country_id, RULE_ID AS rule_id, EK_NR_ID AS mail_ek_nr_id, mail_exist AS mail_id, FLAGGED_RULE_COUNTRY_COMB AS ref_mail_kfl_rule_eknr_flag_id);
    END;
ELSEIF 0 = DEL AND 0 = REF_MAIL_KFL_EKNR_MAIL_ID AND mail_exist IS NULL AND EK_NR_ID = 0 THEN
    BEGIN
    INSERT INTO idq_results.ref_mail_kfl_mail (id, mail)
(SELECT CONTACT AS mail);
    SET mail_exist  =  (SELECT id
FROM idq_results.ref_mail_kfl_mail
WHERE mail = CONTACT);
    SET FLAGGED_RULE_COUNTRY_COMB  =  (SELECT ref_mail_kfl_rule_eknr_flag_id
FROM dwh.ref_mail_kfl_rule_eknr_flag
WHERE ek_nr_flag = FLAGGED AND ref_rule_id = RULE_ID AND ref_country_id = COUNTRY_ID);
    INSERT INTO idq_results.ref_mail_kfl_rule_eknr_mail (id, country_id, rule_id, mail_ek_nr_id, mail_id, ref_mail_kfl_rule_eknr_flag_id)
(SELECT COUNTRY_ID AS country_id, RULE_ID AS rule_id, NULL AS mail_ek_nr_id, mail_exist AS mail_id, FLAGGED_RULE_COUNTRY_COMB AS ref_mail_kfl_rule_eknr_flag_id);
    END;
ELSEIF 0 = DEL AND 0 = REF_MAIL_KFL_EKNR_MAIL_ID AND mail_exist IS NOT NULL AND EK_NR_ID > 0 THEN
    BEGIN
    SET FLAGGED_RULE_COUNTRY_COMB  =  (SELECT ref_mail_kfl_rule_eknr_flag_id
FROM dwh.ref_mail_kfl_rule_eknr_flag
WHERE ek_nr_flag = FLAGGED AND ref_rule_id = RULE_ID AND ref_country_id = COUNTRY_ID);
    INSERT INTO idq_results.ref_mail_kfl_rule_eknr_mail (id, country_id, rule_id, mail_ek_nr_id, mail_id, ref_mail_kfl_rule_eknr_flag_id)
(SELECT COUNTRY_ID AS country_id, RULE_ID AS rule_id, EK_NR_ID AS mail_ek_nr_id, mail_exist AS mail_id, FLAGGED_RULE_COUNTRY_COMB AS ref_mail_kfl_rule_eknr_flag_id);
    END;
ELSEIF 0 = DEL AND 0 = REF_MAIL_KFL_EKNR_MAIL_ID AND mail_exist IS NOT NULL AND EK_NR_ID = 0 THEN
    BEGIN
    SET FLAGGED_RULE_COUNTRY_COMB  =  (SELECT ref_mail_kfl_rule_eknr_flag_id
FROM dwh.ref_mail_kfl_rule_eknr_flag
WHERE ek_nr_flag = FLAGGED AND ref_rule_id = RULE_ID AND ref_country_id = COUNTRY_ID);
    INSERT INTO idq_results.ref_mail_kfl_rule_eknr_mail (id, country_id, rule_id, mail_ek_nr_id, mail_id, ref_mail_kfl_rule_eknr_flag_id)
(SELECT COUNTRY_ID AS country_id, RULE_ID AS rule_id, NULL AS mail_ek_nr_id, mail_exist AS mail_id, FLAGGED_RULE_COUNTRY_COMB AS ref_mail_kfl_rule_eknr_flag_id);
    END;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;

