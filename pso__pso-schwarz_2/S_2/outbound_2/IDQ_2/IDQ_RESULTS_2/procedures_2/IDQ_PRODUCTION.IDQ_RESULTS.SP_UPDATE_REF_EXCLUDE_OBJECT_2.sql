-- SP_UPDATE_REF_EXCLUDE_OBJECT(NUMBER,STRING ,STRING ,NUMBER)



CREATE OR REPLACE PROCEDURE idq_results.sp_update_ref_exclude_object(IN EXCLUDE_ID INT64, IN INSERTED_BY STRING, IN EXCLUDE_REASON STRING, IN EXCLUDE_FLAG INT64)
BEGIN
DECLARE COUNT_INSERT INT64 DEFAULT 0;
DECLARE excluded INT64 DEFAULT NULL;
BEGIN TRANSACTION;
SET excluded  =  (SELECT exclude_flag
FROM idq_results.ref_exclude_2
WHERE id = EXCLUDE_ID
LIMIT 1);

IF excluded = 1 AND EXCLUDE_FLAG = 0 THEN
    UPDATE idq_results.ref_exclude_2 SET
    exclude_flag = EXCLUDE_FLAG,
    exclude_reason = EXCLUDE_REASON,
    inserted_by = INSERTED_BY,
    undone_at = CURRENT_DATETIME()
WHERE id = EXCLUDE_ID;
END IF;


IF excluded = 0 AND EXCLUDE_FLAG = 1 THEN
    UPDATE idq_results.ref_exclude_2 SET
    exclude_flag = 1,
    inserted_at = CURRENT_DATETIME(),
    exclude_reason = EXCLUDE_REASON,
    inserted_by = INSERTED_BY,
    undone_at = NULL
WHERE id = EXCLUDE_ID;
END IF;

COMMIT TRANSACTION;
END;
