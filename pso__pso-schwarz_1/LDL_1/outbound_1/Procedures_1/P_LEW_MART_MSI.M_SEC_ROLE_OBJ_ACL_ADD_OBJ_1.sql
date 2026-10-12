CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.m_sec_role_obj_acl_add_obj`(
  NSTD_LFT_ID FLOAT64,
  NSTD_RGT_ID FLOAT64,
  OBJECT_PATH_PARENT STRING,
  OBJECT_NAME STRING,
  OBJECT_TYPE_ID FLOAT64,
  ENTRY_USER STRING
)
BEGIN
  BEGIN
    EXECUTE IMMEDIATE """
      UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl_1` 
      SET nstd_rgt_id = nstd_rgt_id + 2
      WHERE nstd_rgt_id >= @nstd_rgt_id
    """ USING CAST(NSTD_RGT_ID AS INT64) AS nstd_rgt_id;

    EXECUTE IMMEDIATE """
      UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl_1` 
      SET nstd_lft_id = nstd_lft_id + 2
      WHERE nstd_lft_id > @nstd_rgt_id
    """ USING CAST(NSTD_RGT_ID AS INT64) AS nstd_rgt_id;

    EXECUTE IMMEDIATE """
      INSERT INTO `p_lew_mart_msi.t_ct_sec_role_obj_acl_1` (
        security_role_id, security_role_desc, object_name, object_type_id, object_path,
        nstd_lft_id, nstd_rgt_id, authorized, entry_user, entry_datetime,
        approval_user, approval_datetime, approved, active_fg, zero_val
      )
      SELECT
        sec.security_role_id AS security_role_id,
        sec.security_role_desc AS security_role_desc,
        @object_name AS object_name,
        @object_type_id AS object_type_id,
        CONCAT(@object_path_parent, @object_name, '\\\\') AS object_path,
        @nstd_rgt_id AS nstd_lft_id,
        @nstd_rgt_id + 1 AS nstd_rgt_id,
        0 AS authorized,
        @entry_user AS entry_user,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS entry_datetime,
        @entry_user AS approval_user,
        CAST(CURRENT_TIMESTAMP() AS DATETIME) AS approval_datetime,
        1 AS approved,
        1 AS active_fg,
        0 AS zero_val
      FROM (
        SELECT security_role_id, security_role_desc
        FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_1`
        GROUP BY 1, 2
      ) AS sec
    """ USING 
      OBJECT_NAME AS object_name, 
      CAST(OBJECT_TYPE_ID AS INT64) AS object_type_id, 
      OBJECT_PATH_PARENT AS object_path_parent, 
      CAST(NSTD_RGT_ID AS INT64) AS nstd_rgt_id, 
      ENTRY_USER AS entry_user;

    EXECUTE IMMEDIATE """
      UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child_1` 
      SET p_rgt_id = p_rgt_id + 2
      WHERE p_rgt_id >= @nstd_rgt_id
    """ USING CAST(NSTD_RGT_ID AS INT64) AS nstd_rgt_id;

    EXECUTE IMMEDIATE """
      UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child_1` 
      SET p_lft_id = p_lft_id + 2
      WHERE p_lft_id > @nstd_rgt_id
    """ USING CAST(NSTD_RGT_ID AS INT64) AS nstd_rgt_id;

    EXECUTE IMMEDIATE """
      UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child_1` 
      SET c_rgt_id = c_rgt_id + 2
      WHERE c_rgt_id >= @nstd_rgt_id
    """ USING CAST(NSTD_RGT_ID AS INT64) AS nstd_rgt_id;

    EXECUTE IMMEDIATE """
      UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child_1` 
      SET c_lft_id = c_lft_id + 2
      WHERE c_lft_id > @nstd_rgt_id
    """ USING CAST(NSTD_RGT_ID AS INT64) AS nstd_rgt_id;

    EXECUTE IMMEDIATE """
      INSERT INTO `p_lew_mart_msi.t_ref_obj_acl_parent_child_1` (
        p_lft_id, p_rgt_id, p_object_name, c_lft_id, c_rgt_id
      )
      SELECT
        p.nstd_lft_id AS p_lft_id,
        p.nstd_rgt_id AS p_rgt_id,
        p.object_name AS p_object_name,
        @nstd_rgt_id AS c_lft_id,
        @nstd_rgt_id + 1 AS c_rgt_id
      FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_1` AS p
      WHERE @nstd_rgt_id BETWEEN nstd_lft_id AND nstd_rgt_id
      GROUP BY 1, 2, 3
    """ USING CAST(NSTD_RGT_ID AS INT64) AS nstd_rgt_id;

    -- object_type_id 0 and 32 are the startpoint of MIS Reports the projects (MIS International, MIS lead..) 
    -- there should be default authorized = 1 for all groups
    -- "Öffentliche Objekte" and "Berichte" are also objects, where for all groups are default authorized = 1
    EXECUTE IMMEDIATE """
      UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl_1` 
      SET authorized = 1
      WHERE object_type_id IN (0, 32)
         OR object_name IN ('Öffentliche Objekte', 'Berichte')
    """;

  EXCEPTION WHEN ERROR THEN
    -- Simply raise the error exactly as Snowflake threw it, no OUT parameter needed
    RAISE USING MESSAGE = 'MESSAGE: ' || @@error.message;
  END;
END;