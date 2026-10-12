/*
#----------------------------------------------------------------------------
# History:
#
#  Vrs Date       Developer               Task
#  --- ---------- ----------------------- --------------------------------
#  1.0 2024-05-21 Marcin Kikola          AP0206303 Introduction of Loyalty_attribute
#  1.1 2024-06-11 Marcin Kikola          Added Commit
#----------------------------------------------------------------------------
*/



CREATE OR REPLACE PROCEDURE p_lew_process_mstr.p_ref_ldpl_feature_group_loyal_mod(IN FEATURE_GROUP_ID FLOAT64, IN LOYALTY_ID FLOAT64, OUT out_param STRING)
BEGIN
DECLARE query_id STRING(16777216);
DECLARE captured_row_count INT64;
BEGIN
BEGIN TRANSACTION;
UPDATE p_lew_process_mstr.t_ref_ldpl_feature_group_2 SET
    loyalty_id = CAST(LOYALTY_ID AS INTEGER),
    dwh_updated = CAST(CURRENT_TIMESTAMP() AS DATETIME)
WHERE feature_group_id = FEATURE_GROUP_ID;
SET captured_row_count = @@row_count;
SET query_id = @@last_job_id;
COMMIT TRANSACTION;
SET out_param  =  'NumRowsUpdated: ' || CAST(captured_row_count AS STRING) || ', QueryId:' || query_id;
SELECT out_param;
RETURN;
END;
END;
