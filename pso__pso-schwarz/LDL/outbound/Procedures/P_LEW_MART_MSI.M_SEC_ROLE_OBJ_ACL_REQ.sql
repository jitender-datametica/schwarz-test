CREATE OR REPLACE PROCEDURE p_lew_mart_msi.m_sec_role_obj_acl_req(
    SECURITY_ROLE_ID FLOAT64,
    OBJECT_NAME STRING,
    AUTHORIZED FLOAT64,
    NSTD_LFT_ID FLOAT64,
    NSTD_RGT_ID FLOAT64,
    ENTRY_USER STRING
)
BEGIN
  BEGIN TRANSACTION;

  -- Delete the table, which is the intermediate table to store the parent or child objects
  EXECUTE IMMEDIATE """
    DELETE FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id WHERE TRUE
  """;

  -- Insert the parent objects into the update_lft_id_table
  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id (nstd_lft_id) 
    SELECT x.nstd_lft_id
    FROM (
        SELECT
            o.object_name,
            o.object_path,
            o.nstd_lft_id,
            o.nstd_rgt_id,
            o.authorized,
            o.approved,
            o.active_fg,
            COUNT(DISTINCT p.nstd_lft_id) - 1 AS ebene
        FROM p_lew_mart_msi.t_ct_sec_role_obj_acl AS n
        INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl AS o
            ON o.nstd_lft_id BETWEEN n.nstd_lft_id AND n.nstd_rgt_id
            AND o.security_role_id = n.security_role_id
        INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl AS p
            ON o.nstd_lft_id BETWEEN p.nstd_lft_id AND p.nstd_rgt_id
            AND o.security_role_id = p.security_role_id
        WHERE n.nstd_lft_id = 1
          AND n.security_role_id = @SECURITY_ROLE_ID
        GROUP BY 1, 2, 3, 4, 5, 6, 7
    ) AS x
    WHERE nstd_lft_id BETWEEN x.nstd_lft_id AND x.nstd_rgt_id
      AND authorized = 1
      AND authorized = 0
      AND approved = 1
      AND active_fg = 1
  """ USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID;

  -- Delete from the ACL table all never approved and inactive requests
  EXECUTE IMMEDIATE """
    DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
    WHERE security_role_id = @SECURITY_ROLE_ID
      AND approved = 0
      AND active_fg = 0
      AND nstd_lft_id IN (
          SELECT nstd_lft_id
          FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
      )
  """ USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID;

  -- Set the last active request to inactive
  EXECUTE IMMEDIATE """
    UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl
    SET active_fg = 0
    WHERE security_role_id = @SECURITY_ROLE_ID
      AND approved = 0
      AND active_fg = 1
      AND nstd_lft_id IN (
          SELECT nstd_lft_id
          FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
      )
  """ USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID;

  -- Insert the new request for the object and all his parent objects
  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_ct_sec_role_obj_acl (
        security_role_id,
        security_role_desc,
        object_name,
        object_type_id,
        object_path,
        nstd_lft_id,
        nstd_rgt_id,
        authorized,
        entry_user,
        entry_datetime,
        approval_user,
        approval_datetime,
        approved,
        active_fg,
        zero_val
    ) 
    SELECT
        security_role_id AS security_role_id,
        security_role_desc AS security_role_desc,
        object_name AS object_name,
        object_type_id AS object_type_id,
        object_path AS object_path,
        nstd_lft_id AS nstd_lft_id,
        nstd_rgt_id AS nstd_rgt_id,
        CAST(@AUTHORIZED AS INT64) AS authorized,
        @ENTRY_USER AS entry_user,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS entry_datetime,
        'NOT APPROVED' AS approval_user,
        CAST(NULL AS DATETIME) AS approval_datetime,
        0 AS approved,
        1 AS active_fg,
        0 AS zero_val
    FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
    WHERE security_role_id = @SECURITY_ROLE_ID
      AND approved = 1
      AND active_fg = 1
      AND authorized = 1
      AND authorized = 0
      AND nstd_lft_id IN (
          SELECT nstd_lft_id
          FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
      )
  """ USING AUTHORIZED AS AUTHORIZED, ENTRY_USER AS ENTRY_USER, SECURITY_ROLE_ID AS SECURITY_ROLE_ID;

  EXECUTE IMMEDIATE """
    DELETE FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id WHERE TRUE
  """;

  -- Here comes the same logic as before, just for the children objects.   
  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id (nstd_lft_id) 
    SELECT x.nstd_lft_id
    FROM (
        SELECT
            o.object_name,
            o.object_path,
            o.nstd_lft_id,
            o.nstd_rgt_id,
            o.authorized,
            o.approved,
            o.active_fg,
            COUNT(DISTINCT p.nstd_lft_id) - 1 AS ebene
        FROM p_lew_mart_msi.t_ct_sec_role_obj_acl AS n
        INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl AS o
            ON o.nstd_lft_id BETWEEN n.nstd_lft_id AND n.nstd_rgt_id
            AND o.security_role_id = n.security_role_id
        INNER JOIN p_lew_mart_msi.t_ct_sec_role_obj_acl AS p
            ON o.nstd_lft_id BETWEEN p.nstd_lft_id AND p.nstd_rgt_id
            AND o.security_role_id = p.security_role_id
        WHERE n.nstd_lft_id = 1
          AND n.security_role_id = @SECURITY_ROLE_ID
        GROUP BY 1, 2, 3, 4, 5, 6, 7
    ) AS x
    WHERE x.nstd_lft_id BETWEEN @NSTD_LFT_ID AND @NSTD_RGT_ID
      AND authorized = 0
      AND authorized = 1
      AND approved = 1
      AND active_fg = 1
  """ USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID, NSTD_LFT_ID AS NSTD_LFT_ID, NSTD_RGT_ID AS NSTD_RGT_ID;

  EXECUTE IMMEDIATE """
    DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
    WHERE security_role_id = @SECURITY_ROLE_ID
      AND approved = 0
      AND active_fg = 0
      AND nstd_lft_id IN (
          SELECT nstd_lft_id
          FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
      )
  """ USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID;

  EXECUTE IMMEDIATE """
    UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl
    SET active_fg = 0
    WHERE security_role_id = @SECURITY_ROLE_ID
      AND approved = 0
      AND active_fg = 1
      AND nstd_lft_id IN (
          SELECT nstd_lft_id
          FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
      )
  """ USING SECURITY_ROLE_ID AS SECURITY_ROLE_ID;

  EXECUTE IMMEDIATE """
    INSERT INTO p_lew_mart_msi.t_ct_sec_role_obj_acl (
        security_role_id,
        security_role_desc,
        object_name,
        object_type_id,
        object_path,
        nstd_lft_id,
        nstd_rgt_id,
        authorized,
        entry_user,
        entry_datetime,
        approval_user,
        approval_datetime,
        approved,
        active_fg,
        zero_val
    ) 
    SELECT
        security_role_id AS security_role_id,
        security_role_desc AS security_role_desc,
        object_name AS object_name,
        object_type_id AS object_type_id,
        object_path AS object_path,
        nstd_lft_id AS nstd_lft_id,
        nstd_rgt_id AS nstd_rgt_id,
        CAST(@AUTHORIZED AS INT64) AS authorized,
        @ENTRY_USER AS entry_user,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS entry_datetime,
        'NOT APPROVED' AS approval_user,
        CAST(NULL AS DATETIME) AS approval_datetime,
        0 AS approved,
        1 AS active_fg,
        0 AS zero_val
    FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
    WHERE security_role_id = @SECURITY_ROLE_ID
      AND approved = 1
      AND active_fg = 1
      AND authorized = 0
      AND authorized = 1
      AND nstd_lft_id IN (
          SELECT nstd_lft_id
          FROM p_lew_mart_msi.t_sec_role_obj_acl_upd_lft_id
      )
  """ USING AUTHORIZED AS AUTHORIZED, ENTRY_USER AS ENTRY_USER, SECURITY_ROLE_ID AS SECURITY_ROLE_ID;

  EXECUTE IMMEDIATE """
    DELETE FROM p_lew_mart_msi.t_ct_sec_role_obj_acl
    WHERE active_fg = 0
      AND approved = 0
  """;

  -- object_type_id 0 and 32 are the startpoint of MIS Reports the projects (MIS International, MIS lead..) 
  -- there should be default authorized = 1 for all groups
  -- "Öffentliche Objekte" and "Berichte" are also objects, where for all groups are default authorized = 1
  EXECUTE IMMEDIATE """
    UPDATE p_lew_mart_msi.t_ct_sec_role_obj_acl
    SET authorized = 1
    WHERE object_type_id IN (0, 32)
       OR object_name IN ('Öffentliche Objekte', 'Berichte')
  """;

  COMMIT TRANSACTION;
END;