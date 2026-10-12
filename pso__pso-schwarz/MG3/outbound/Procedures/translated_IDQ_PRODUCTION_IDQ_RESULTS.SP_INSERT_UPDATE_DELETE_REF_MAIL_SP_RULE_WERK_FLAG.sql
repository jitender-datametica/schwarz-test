CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_update_delete_ref_mail_sp_rule_werk_flag(IN REF_MAIL_SP_RULE_WERK_FLAG_ID INT64, IN RULE_ID INT64, IN BRANCH_ID INT64, IN WERK_FLAG INT64, IN WG_FLAG INT64, IN MATART_FLAG INT64, IN DEL INT64, OUT out_param INT64)
BEGIN
DECLARE WERK_BRANCH_Comb_exist INT64;
BEGIN TRANSACTION;
SET WERK_BRANCH_Comb_exist  =  (SELECT id
FROM idq_production_idq_results.ref_mail_sp_rule_werk_flag
WHERE rule_id = RULE_ID AND branch_id = BRANCH_ID AND werk_flag = WERK_FLAG AND wg_flag = WG_FLAG AND matart_flag = WERK_FLAG);
-- Delete from contact table for @REF_MAIL_SP_WERK_MAIL_ID if @DELETE equals 1

IF DEL = 1 THEN
    BEGIN

    DELETE FROM idq_production_idq_results.ref_mail_sp_rule_werk_flag
WHERE id = REF_MAIL_SP_RULE_WERK_FLAG_ID;
    --    RETURN 0;
    -- END IF;
    -- INSERT NEW WERK RULE COMBINATION
    END;
ELSEIF DEL = 0 AND REF_MAIL_SP_RULE_WERK_FLAG_ID = 0 AND WERK_BRANCH_Comb_exist IS NULL THEN
    BEGIN

    INSERT INTO idq_production_idq_results.ref_mail_sp_rule_werk_flag (id, rule_id, branch_id, werk_flag, matart_flag, wg_flag)
(SELECT (SELECT MAX(id) + 1
            FROM idq_production_idq_results.ref_mail_sp_rule_werk_flag) AS id, RULE_ID AS rule_id, BRANCH_ID AS branch_id, WERK_FLAG AS werk_flag, MATART_FLAG AS matart_flag, WG_FLAG AS wg_flag);
    -- RETURN 0;
    --  END IF;
    --    Merge into REF_MAIL_SP_RULE_WERK_FLAG
    END;
ELSE

    MERGE INTO idq_production_idq_results.ref_mail_sp_rule_werk_flag AS target
USING (SELECT REF_MAIL_SP_RULE_WERK_FLAG_ID AS id) AS SOURCE
ON target.id = SOURCE.id
WHEN MATCHED AND target.werk_flag <> WERK_FLAG OR target.werk_flag <> WG_FLAG OR target.werk_flag <> MATART_FLAG THEN UPDATE SET
    werk_flag = WERK_FLAG,
    wg_flag = WG_FLAG,
    matart_flag = MATART_FLAG;
END IF;

COMMIT TRANSACTION;
SET out_param  =  1;
SELECT out_param;
RETURN;
END;
