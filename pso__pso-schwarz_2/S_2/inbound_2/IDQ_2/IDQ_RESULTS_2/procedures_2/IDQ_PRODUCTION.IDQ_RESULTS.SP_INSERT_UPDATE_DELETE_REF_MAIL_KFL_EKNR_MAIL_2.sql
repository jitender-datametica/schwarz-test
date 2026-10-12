CREATE OR REPLACE PROCEDURE IDQ_PRODUCTION.IDQ_RESULTS.SP_INSERT_UPDATE_DELETE_REF_MAIL_KFL_EKNR_MAIL("REF_MAIL_KFL_EKNR_MAIL_ID" NUMBER(38,0), "COUNTRY_ID" NUMBER(38,0), "CONTACT_2" VARCHAR(16777216), "DEL" NUMBER(38,0), "RULE_ID" NUMBER(38,0), "EK_NR_ID" NUMBER(38,0), "FLAGGED" NUMBER(38,0))
RETURNS NUMBER(38,0)
LANGUAGE SQL
EXECUTE AS OWNER
AS 'DECLARE mail_exist number(38,0);
FLAGGED_RULE_COUNTRY_COMB number(38,0);
BEGIN
 mail_exist := (SELECT ID FROM IDQ_RESULTS.REF_MAIL_KFL_MAIL_2 WHERE MAIL = :CONTACT_2);
-- Delete rule mail combinations from REF_MAIL_KFL_RULE_EKNR_MAIL_2
  IF (1 = :DEL) THEN
  DELETE from IDQ_RESULTS.REF_MAIL_KFL_RULE_EKNR_MAIL_2 WHERE ID = :REF_MAIL_KFL_EKNR_MAIL_ID;
-- Insert new mail and rule mail combination
   elseif (0 = :DEL and 0 = :REF_MAIL_KFL_EKNR_MAIL_ID and mail_exist is NULL and :EK_NR_ID > 0) THEN
 INSERT INTO IDQ_RESULTS.REF_MAIL_KFL_MAIL_2(MAIL) VALUES (:contact_2);
    mail_exist := (SELECT ID FROM IDQ_RESULTS.REF_MAIL_KFL_MAIL_2 WHERE MAIL = :CONTACT_2);
    FLAGGED_RULE_COUNTRY_COMB := (select REF_MAIL_KFL_RULE_EKNR_FLAG_ID from dwh.ref_mail_kfl_rule_eknr_flag_2 where ek_nr_flag = :FLAGGED and ref_rule_id = :RULE_ID and ref_country_id = :COUNTRY_ID);
            INSERT INTO IDQ_RESULTS.REF_MAIL_KFL_RULE_EKNR_MAIL_2 (COUNTRY_ID, RULE_ID, MAIL_ID, MAIL_EK_NR_ID, REF_MAIL_KFL_RULE_EKNR_FLAG_ID) VALUES (:COUNTRY_ID, :RULE_ID, :mail_exist, :EK_NR_ID, :FLAGGED_RULE_COUNTRY_COMB);
-- Insert new mail and rule mail combination without EK Nr
    elseif (0 = :DEL and 0 = :REF_MAIL_KFL_EKNR_MAIL_ID and mail_exist is NULL and :EK_NR_ID = 0) THEN
    INSERT INTO IDQ_RESULTS.REF_MAIL_KFL_MAIL_2(MAIL) VALUES (:contact_2);
    mail_exist := (SELECT ID FROM IDQ_RESULTS.REF_MAIL_KFL_MAIL_2 WHERE MAIL = :CONTACT_2);
    FLAGGED_RULE_COUNTRY_COMB := (select REF_MAIL_KFL_RULE_EKNR_FLAG_ID from dwh.ref_mail_kfl_rule_eknr_flag_2 where ek_nr_flag = :FLAGGED and ref_rule_id = :RULE_ID and ref_country_id = :COUNTRY_ID);
    INSERT INTO IDQ_RESULTS.REF_MAIL_KFL_RULE_EKNR_MAIL_2 (COUNTRY_ID, RULE_ID, MAIL_ID, MAIL_EK_NR_ID, REF_MAIL_KFL_RULE_EKNR_FLAG_ID) VALUES (:COUNTRY_ID, :RULE_ID, :mail_exist, NULL, :FLAGGED_RULE_COUNTRY_COMB);
-- Insert rule mail combination with existing mail
  elseif (0 = :DEL and 0 = :REF_MAIL_KFL_EKNR_MAIL_ID  and mail_exist is not NULL and :EK_NR_ID > 0) THEN
  FLAGGED_RULE_COUNTRY_COMB := (select REF_MAIL_KFL_RULE_EKNR_FLAG_ID from dwh.ref_mail_kfl_rule_eknr_flag_2 where ek_nr_flag = :FLAGGED and ref_rule_id = :RULE_ID and ref_country_id = :COUNTRY_ID);
 INSERT INTO IDQ_RESULTS.REF_MAIL_KFL_RULE_EKNR_MAIL_2 (COUNTRY_ID, RULE_ID, MAIL_ID, MAIL_EK_NR_ID, REF_MAIL_KFL_RULE_EKNR_FLAG_ID) VALUES (:COUNTRY_ID, :RULE_ID, :mail_exist, :EK_NR_ID, :FLAGGED_RULE_COUNTRY_COMB);
    -- Insert rule mail combination with existing mail
    elseif (0 = :DEL and 0 = :REF_MAIL_KFL_EKNR_MAIL_ID and mail_exist is not NULL and :EK_NR_ID = 0) THEN
    FLAGGED_RULE_COUNTRY_COMB := (select REF_MAIL_KFL_RULE_EKNR_FLAG_ID from dwh.ref_mail_kfl_rule_eknr_flag_2 where ek_nr_flag = :FLAGGED and ref_rule_id = :RULE_ID and ref_country_id = :COUNTRY_ID);
  INSERT INTO IDQ_RESULTS.REF_MAIL_KFL_RULE_EKNR_MAIL_2 (COUNTRY_ID, RULE_ID, MAIL_ID, MAIL_EK_NR_ID, REF_MAIL_KFL_RULE_EKNR_FLAG_ID) VALUES (:COUNTRY_ID, :RULE_ID, :mail_exist, NULL, :FLAGGED_RULE_COUNTRY_COMB);

  END IF;
  commit;
  return 1;
END';