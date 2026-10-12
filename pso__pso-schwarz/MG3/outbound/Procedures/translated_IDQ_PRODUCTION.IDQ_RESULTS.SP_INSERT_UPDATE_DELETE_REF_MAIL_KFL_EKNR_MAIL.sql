CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_update_delete_ref_mail_kfl_eknr_mail(
  IN REF_MAIL_KFL_EKNR_MAIL_ID BIGNUMERIC, 
  IN COUNTRY_ID BIGNUMERIC, 
  IN CONTACT STRING, 
  IN DEL BIGNUMERIC, 
  IN RULE_ID BIGNUMERIC, 
  IN EK_NR_ID BIGNUMERIC, 
  IN FLAGGED BIGNUMERIC, 
  OUT out_param INT64)
BEGIN
DECLARE mail_exist BIGNUMERIC;
DECLARE FLAGGED_RULE_COUNTRY_COMB BIGNUMERIC;
BEGIN
BEGIN TRANSACTION;
SET mail_exist  =  (SELECT id FROM idq_production_idq_results.ref_mail_kfl_mail WHERE mail = CONTACT);
-- Delete rule mail combinations from REF_MAIL_KFL_RULE_EKNR_MAIL

IF 1 = DEL THEN
    BEGIN
    DELETE FROM idq_production_idq_results.ref_mail_kfl_rule_eknr_mail WHERE id = REF_MAIL_KFL_EKNR_MAIL_ID; 
    END;

-- Insert new mail and rule mail combination
ELSEIF 0 = DEL AND 0 = REF_MAIL_KFL_EKNR_MAIL_ID AND mail_exist IS NULL AND EK_NR_ID > 0 THEN
    BEGIN
    INSERT INTO idq_production_idq_results.ref_mail_kfl_mail (mail)(SELECT CONTACT AS mail);
    
    SET mail_exist  =  (SELECT id FROM idq_production_idq_results.ref_mail_kfl_mail WHERE mail = CONTACT);
    
    SET FLAGGED_RULE_COUNTRY_COMB  =  (SELECT ref_mail_kfl_rule_eknr_flag_id FROM idq_production_dwh.ref_mail_kfl_rule_eknr_flag
                                        WHERE ek_nr_flag = FLAGGED AND ref_rule_id = RULE_ID AND ref_country_id = COUNTRY_ID);

    INSERT INTO idq_production_idq_results.ref_mail_kfl_rule_eknr_mail (
      country_id, 
      rule_id, 
      mail_ek_nr_id, 
      mail_id, 
      ref_mail_kfl_rule_eknr_flag_id)
    (SELECT CAST(COUNTRY_ID AS INTEGER) AS country_id, 
    CAST(RULE_ID AS INTEGER) AS rule_id, 
    CAST(EK_NR_ID AS INTEGER) AS mail_ek_nr_id, 
    CAST(mail_exist AS INTEGER) AS mail_id, 
    CAST(FLAGGED_RULE_COUNTRY_COMB AS INTEGER) AS ref_mail_kfl_rule_eknr_flag_id);
    END;

    -- Insert new mail and rule mail combination without EK Nr
ELSEIF 0 = DEL AND 0 = REF_MAIL_KFL_EKNR_MAIL_ID AND mail_exist IS NULL AND EK_NR_ID = 0 THEN
    BEGIN
    INSERT INTO idq_production_idq_results.ref_mail_kfl_mail (mail)
    (SELECT CONTACT AS mail);

    SET mail_exist  =  (SELECT id FROM idq_production_idq_results.ref_mail_kfl_mail WHERE mail = CONTACT);

    SET FLAGGED_RULE_COUNTRY_COMB  =  (SELECT ref_mail_kfl_rule_eknr_flag_id FROM idq_production_dwh.ref_mail_kfl_rule_eknr_flag
                                        WHERE ek_nr_flag = FLAGGED AND ref_rule_id = RULE_ID AND ref_country_id = COUNTRY_ID);

    INSERT INTO idq_production_idq_results.ref_mail_kfl_rule_eknr_mail (
      country_id, 
      rule_id, 
      mail_ek_nr_id, 
      mail_id, 
      ref_mail_kfl_rule_eknr_flag_id)
    (SELECT CAST(COUNTRY_ID AS INTEGER) AS country_id, 
    CAST(RULE_ID AS INTEGER) AS rule_id, 
    NULL AS mail_ek_nr_id, 
    CAST(mail_exist AS INTEGER) AS mail_id, 
    CAST(FLAGGED_RULE_COUNTRY_COMB AS INTEGER) AS ref_mail_kfl_rule_eknr_flag_id);
    END;

    -- Insert rule mail combination with existing mail
ELSEIF 0 = DEL AND 0 = REF_MAIL_KFL_EKNR_MAIL_ID AND mail_exist IS NOT NULL AND EK_NR_ID > 0 THEN
    BEGIN
    SET FLAGGED_RULE_COUNTRY_COMB  =  (SELECT ref_mail_kfl_rule_eknr_flag_id FROM idq_production_dwh.ref_mail_kfl_rule_eknr_flag
                                        WHERE ek_nr_flag = FLAGGED AND ref_rule_id = RULE_ID AND ref_country_id = COUNTRY_ID);
    
    INSERT INTO idq_production_idq_results.ref_mail_kfl_rule_eknr_mail (
      country_id, 
      rule_id, 
      mail_ek_nr_id, 
      mail_id, 
      ref_mail_kfl_rule_eknr_flag_id)
    (SELECT CAST(COUNTRY_ID AS INTEGER) AS country_id, 
    CAST(RULE_ID AS INTEGER) AS rule_id, 
    CAST(EK_NR_ID AS INTEGER) AS mail_ek_nr_id, 
    CAST(mail_exist AS INTEGER) AS mail_id, 
    CAST(FLAGGED_RULE_COUNTRY_COMB AS INTEGER) AS ref_mail_kfl_rule_eknr_flag_id);
    END;

    -- Insert rule mail combination with existing mail
ELSEIF 0 = DEL AND 0 = REF_MAIL_KFL_EKNR_MAIL_ID AND mail_exist IS NOT NULL AND EK_NR_ID = 0 THEN
    BEGIN
    SET FLAGGED_RULE_COUNTRY_COMB  =  (SELECT ref_mail_kfl_rule_eknr_flag_id FROM idq_production_dwh.ref_mail_kfl_rule_eknr_flag
                                        WHERE ek_nr_flag = FLAGGED AND ref_rule_id = RULE_ID AND ref_country_id = COUNTRY_ID);

    INSERT INTO idq_production_idq_results.ref_mail_kfl_rule_eknr_mail (
      country_id, 
      rule_id, 
      mail_ek_nr_id, 
      mail_id, 
      ref_mail_kfl_rule_eknr_flag_id)
    (SELECT CAST(COUNTRY_ID AS INTEGER) AS country_id, 
    CAST(RULE_ID AS INTEGER) AS rule_id, 
    NULL AS mail_ek_nr_id, 
    CAST(mail_exist AS INTEGER) AS mail_id, 
    CAST(FLAGGED_RULE_COUNTRY_COMB AS INTEGER) AS ref_mail_kfl_rule_eknr_flag_id);
    END;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
END;


