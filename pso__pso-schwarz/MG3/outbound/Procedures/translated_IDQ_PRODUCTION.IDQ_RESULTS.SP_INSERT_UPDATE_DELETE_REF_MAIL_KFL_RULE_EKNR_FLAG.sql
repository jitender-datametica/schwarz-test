CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_update_delete_ref_mail_kfl_rule_eknr_flag(IN REF_MAIL_KFL_RULE_EKNR_FLAG_ID INT64, IN RULE_ID INT64, IN COUNTRY_ID INT64, IN EK_NR_FLAG INT64, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE EKNR_COUNTRY_Comb_exist INT64;
SET EKNR_COUNTRY_Comb_exist  =  (SELECT id
FROM idq_production_idq_results.ref_mail_kfl_rule_eknr_flag
WHERE rule_id = RULE_ID AND country_id = COUNTRY_ID AND ek_nr_flag = EK_NR_FLAG);

IF DEL = 1 THEN
    DELETE FROM idq_production_idq_results.ref_mail_kfl_rule_eknr_flag
WHERE id = REF_MAIL_KFL_RULE_EKNR_FLAG_ID;
ELSEIF DEL = 0 AND REF_MAIL_KFL_RULE_EKNR_FLAG_ID = 0 AND EKNR_COUNTRY_Comb_exist IS NULL THEN
    INSERT INTO idq_production_idq_results.ref_mail_kfl_rule_eknr_flag (rule_id, country_id, ek_nr_flag)
(SELECT RULE_ID AS rule_id, COUNTRY_ID AS country_id, EK_NR_FLAG AS ek_nr_flag);
ELSE
    MERGE INTO idq_production_idq_results.ref_mail_kfl_rule_eknr_flag AS target
USING (SELECT REF_MAIL_KFL_RULE_EKNR_FLAG_ID AS id) AS SOURCE
ON target.id = SOURCE.id
WHEN MATCHED AND target.ek_nr_flag <> EK_NR_FLAG THEN UPDATE SET
    ek_nr_flag = EK_NR_FLAG;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
