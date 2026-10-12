CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_obj_acl_del_perm(
  PERMISSION_TYPE STRING, 
  DUMMY_ID FLOAT64
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''-- Delete the permission type from the perms table
    DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_1
    WHERE permission_type = @PERMISSION_TYPE''' USING PERMISSION_TYPE AS PERMISSION_TYPE;

  COMMIT TRANSACTION;
END;