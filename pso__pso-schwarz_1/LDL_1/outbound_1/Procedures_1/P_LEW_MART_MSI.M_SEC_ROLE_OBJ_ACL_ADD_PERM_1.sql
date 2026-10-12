CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_obj_acl_add_perm(
  PERMISSION_TYPE STRING, 
  ENTRY_USER STRING
)
BEGIN
  BEGIN TRANSACTION;

  EXECUTE IMMEDIATE '''-- Insert the new permission type into the perms table
    INSERT INTO p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_1 (
    security_role_id
    , security_role_desc
    , permission_type
    , authorized
    , entry_user
    , entry_datetime
    , approval_user
    , approval_datetime
    , approved
    , active_fg) SELECT
    p.security_role_id   AS security_role_id,
    p.security_role_desc AS security_role_desc,
    @PERMISSION_TYPE     AS permission_type,
    0                    AS authorized,
    @ENTRY_USER          AS entry_user,
    CAST(CURRENT_TIMESTAMP() AS DATETIME)  AS entry_datetime,
    @ENTRY_USER          AS approval_user,
    CAST(CURRENT_TIMESTAMP() AS DATETIME)  AS approval_datetime,
    1                    AS  approved,
    1                    AS active_fg
    FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_1 AS p
    WHERE @PERMISSION_TYPE NOT IN(SELECT
    permission_type
    FROM p_lew_mart_msi.t_ct_sec_role_obj_acl_perms_1
                                          )
  ''' USING PERMISSION_TYPE AS PERMISSION_TYPE, ENTRY_USER AS ENTRY_USER;

  COMMIT TRANSACTION;
END;