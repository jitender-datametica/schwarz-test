-- SP_INSERT_REF_EXCLUDE(NUMBER,NUMBER,STRING ,NUMBER,NUMBER,NUMBER,NUMBER,STRING ,STRING ,NUMBER, NUMBER)



CREATE OR REPLACE PROCEDURE idq_results.sp_insert_ref_exclude(IN RULE_ID INT64, IN BRANCH_ID INT64, IN SOURCE_SYSTEM_PRIMARY_KEY STRING, IN SOURCE_SYSTEM_ID INT64, IN COUNTRY_ID INT64, IN TEST_OBJECT_TYPE_ID INT64, IN INSERTED_BY STRING, IN EXCLUDE_REASON STRING, IN EXCLUDE_FLAG INT64, IN TEST_OBJECT_ID INT64, OUT out_param INT64)
BEGIN

DECLARE COUNT_INSERT INT64 DEFAULT 0;
DECLARE excluded INT64 DEFAULT NULL;
BEGIN TRANSACTION;
IF EXCLUDE_FLAG IS NULL OR EXCLUDE_FLAG <> 1 THEN
    SET out_param  =  0;
    SELECT out_param;
    RETURN;
END IF;

SET excluded  =  (SELECT exclude_flag
FROM idq_results.ref_exclude_1
WHERE rule_id = RULE_ID AND branch_id = BRANCH_ID AND source_system_primary_key = SOURCE_SYSTEM_PRIMARY_KEY AND source_system_id = SOURCE_SYSTEM_ID AND country_id = COUNTRY_ID
LIMIT 1);

IF excluded = 1 THEN
    SET out_param  =  0;
    SELECT out_param;
    RETURN;
END IF;


IF excluded = 0 THEN
    BEGIN
    UPDATE idq_results.ref_exclude_1 SET
    exclude_flag = 1,
    inserted_at = CURRENT_DATETIME(),
    exclude_reason = EXCLUDE_REASON,
    source_system_primary_key = SOURCE_SYSTEM_PRIMARY_KEY,
    inserted_by = INSERTED_BY,
    undone_at = NULL
WHERE rule_id = RULE_ID AND branch_id = BRANCH_ID AND source_system_primary_key = SOURCE_SYSTEM_PRIMARY_KEY AND source_system_id = SOURCE_SYSTEM_ID AND country_id = COUNTRY_ID;
    COMMIT TRANSACTION;
    SET out_param  =  1;
    SELECT out_param;
    RETURN;
    END;
END IF;

INSERT INTO idq_results.ref_exclude_1 (id, rule_id, branch_id, source_system_primary_key, source_system_id, country_id, test_object_type_id, inserted_by, exclude_reason, exclude_flag, inserted_at, test_object_id)
(SELECT (SELECT MAX(id) + 1
            FROM idq_results.ref_exclude_1) AS id, RULE_ID AS rule_id, BRANCH_ID AS branch_id, SOURCE_SYSTEM_PRIMARY_KEY AS source_system_primary_key, SOURCE_SYSTEM_ID AS source_system_id, COUNTRY_ID AS country_id, TEST_OBJECT_TYPE_ID AS test_object_type_id, INSERTED_BY AS inserted_by, EXCLUDE_REASON AS exclude_reason, EXCLUDE_FLAG AS exclude_flag, CURRENT_DATETIME() AS inserted_at, TEST_OBJECT_ID AS test_object_id);
COMMIT TRANSACTION;
END;


