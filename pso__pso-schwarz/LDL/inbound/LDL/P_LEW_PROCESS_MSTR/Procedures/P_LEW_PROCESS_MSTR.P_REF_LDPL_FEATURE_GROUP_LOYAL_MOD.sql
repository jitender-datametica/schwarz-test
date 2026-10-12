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

CREATE OR REPLACE PROCEDURE P_LEW_PROCESS_MSTR.P_REF_LDPL_FEATURE_GROUP_LOYAL_MOD(
    FEATURE_GROUP_ID FLOAT,
    LOYALTY_ID FLOAT)
RETURNS VARCHAR
LANGUAGE SQL
EXECUTE AS CALLER
AS
$$
DECLARE
  query_id VARCHAR;
BEGIN                    
    UPDATE P_LEW_PROCESS_MSTR.T_REF_LDPL_FEATURE_GROUP 
    SET 
    loyalty_id   = :LOYALTY_ID
    ,dwh_updated = CURRENT_TIMESTAMP
    WHERE        
    feature_group_id = :FEATURE_GROUP_ID;

    query_id := SQLID;
COMMIT;
    RETURN 'NumRowsUpdated: ' || SQLROWCOUNT || ', QueryId:' || query_id;
END;
$$
;


