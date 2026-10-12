CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_obj_acl_del_obj_type(
  OBJECT_TYPE_ID FLOAT64, 
  DUMMY_ID FLOAT64
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''
    DELETE FROM p_lew_mart_msi.t_ref_obj_type_acl_1
    WHERE object_type_id = CAST(@OBJECT_TYPE_ID AS INT64)
    AND CAST(@OBJECT_TYPE_ID_1 AS INT64) NOT IN(SELECT
    DISTINCT object_type_id
    FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_1
    )
  ''' USING OBJECT_TYPE_ID AS OBJECT_TYPE_ID, OBJECT_TYPE_ID AS OBJECT_TYPE_ID_1;

  COMMIT TRANSACTION;
END;