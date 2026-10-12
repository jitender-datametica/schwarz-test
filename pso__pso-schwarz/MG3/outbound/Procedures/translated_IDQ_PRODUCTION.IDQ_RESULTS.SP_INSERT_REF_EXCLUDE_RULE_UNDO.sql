CREATE OR REPLACE PROCEDURE idq_production_idq_results.sp_insert_ref_exclude_rule_undo(
  IN EXCLUDE_ID INT64, 
  IN INSERTED_BY STRING, 
  IN EXCLUDE_REASON STRING, 
  IN EXCLUDE_FLAG INT64)
BEGIN
  /* @TEST_OBJECT_ID for the moment is a Dummy value not used*/
  /* Stop process when Exclude Flag is not 1.*/

  /* get the excluded value*/
DECLARE excluded INT64 DEFAULT NULL;
BEGIN TRANSACTION;
SET excluded  =  (SELECT exclude_flag FROM idq_production_idq_results.ref_exclude
                  WHERE id = EXCLUDE_ID LIMIT 1);

  /* Already there and excluded, set EXCLUDE_FLAG = 0*/
IF excluded = 1 AND EXCLUDE_FLAG = 0 THEN
    UPDATE idq_production_idq_results.ref_exclude SET
    exclude_flag = EXCLUDE_FLAG,
    exclude_reason = EXCLUDE_REASON,
    inserted_by = INSERTED_BY,
    undone_at = CURRENT_DATETIME()
WHERE id = EXCLUDE_ID;
END IF;


  /* Update - there, but exclude flag = 0*/
IF excluded = 0 AND EXCLUDE_FLAG = 1 THEN
    UPDATE idq_production_idq_results.ref_exclude SET
    exclude_flag = 1,
    inserted_at = CURRENT_DATETIME(),
    exclude_reason = EXCLUDE_REASON,
    inserted_by = INSERTED_BY,
    undone_at = NULL
WHERE id = EXCLUDE_ID;
END IF;

COMMIT TRANSACTION;
END;


