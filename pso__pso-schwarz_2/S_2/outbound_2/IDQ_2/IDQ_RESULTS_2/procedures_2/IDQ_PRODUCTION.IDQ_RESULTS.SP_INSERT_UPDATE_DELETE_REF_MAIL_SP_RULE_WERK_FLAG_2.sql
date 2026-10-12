CREATE OR REPLACE PROCEDURE idq_results.sp_insert_update_delete_ref_mail_sp_rule_werk_flag(IN REF_MAIL_SP_RULE_WERK_FLAG_ID INT64, IN RULE_ID INT64, IN BRANCH_ID INT64, IN WERK_FLAG INT64, IN WG_FLAG INT64, IN MATART_FLAG INT64, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE WERK_BRANCH_Comb_exist INT64;
BEGIN TRANSACTION;
SET WERK_BRANCH_Comb_exist  =  (SELECT id
FROM idq_results.ref_mail_sp_rule_werk_flag_2
WHERE rule_id = RULE_ID AND branch_id = BRANCH_ID AND werk_flag = WERK_FLAG AND wg_flag = WG_FLAG AND matart_flag = WERK_FLAG);

IF DEL = 1 THEN
    DELETE FROM idq_results.ref_mail_sp_rule_werk_flag_2
WHERE id = REF_MAIL_SP_RULE_WERK_FLAG_ID;
ELSEIF DEL = 0 AND REF_MAIL_SP_RULE_WERK_FLAG_ID = 0 AND WERK_BRANCH_Comb_exist IS NULL THEN
    INSERT INTO idq_results.ref_mail_sp_rule_werk_flag_2 (id, rule_id, branch_id, werk_flag, matart_flag, wg_flag)
(SELECT (SELECT MAX(id) + 1
            FROM idq_results.ref_mail_sp_rule_werk_flag_2) AS id, RULE_ID AS rule_id, BRANCH_ID AS branch_id, WERK_FLAG AS werk_flag, MATART_FLAG AS matart_flag, WG_FLAG AS wg_flag);
ELSE MERGE INTO idq_results.ref_mail_sp_rule_werk_flag_2 AS TARGET
USING (SELECT REF_MAIL_SP_RULE_WERK_FLAG_ID AS id) AS SOURCE
ON TARGET.id = SOURCE.id
WHEN MATCHED AND TARGET.werk_flag <> WERK_FLAG OR TARGET.werk_flag <> WG_FLAG OR TARGET.werk_flag <> MATART_FLAG THEN UPDATE SET
    werk_flag =WERK_FLAG ,
    wg_flag =WG_FLAG ,
    matart_flag = MATART_FLAG;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
