CREATE OR REPLACE PROCEDURE `p_lew_mart_msi.m_sec_role_obj_acl_move_obj`(
  NSTD_LFT_ID FLOAT64,
  NSTD_RGT_ID FLOAT64,
  OBJECT_NAME STRING,
  OBJECT_TYPE FLOAT64,
  NSTD_LFT_ID_MOVE FLOAT64
)
BEGIN
  -- Delete move table everytime, so that there is no data at the beginning
  EXECUTE IMMEDIATE """
    DELETE FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` 
    WHERE TRUE
  """;

  -- Insert the data from the object, which will be moved from one parent object to an other parent object
  EXECUTE IMMEDIATE """
    INSERT INTO `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` (
      security_role_id, security_role_desc, object_name, object_type_id, nstd_lft_id, nstd_rgt_id, authorized,
      entry_user, entry_datetime, approval_user, approval_datetime, approved, active_fg, zero_val
    )
    SELECT
      acl.security_role_id, acl.security_role_desc, acl.object_name, acl.object_type_id, acl.nstd_lft_id, id.nstd_rgt_id,
      acl.authorized, acl.entry_user, acl.entry_datetime, acl.approval_user, acl.approval_datetime, acl.approved,
      acl.active_fg, acl.zero_val
    FROM (
      SELECT
        security_role_id, security_role_desc, object_name, object_type_id, @nstd_lft_id_move_param AS nstd_lft_id,
        authorized, entry_user, entry_datetime, approval_user, approval_datetime, approved, active_fg, zero_val
      FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl`
      WHERE nstd_lft_id = @nstd_lft_id_param
    ) AS acl
    JOIN (
      SELECT DISTINCT nstd_rgt_id, nstd_lft_id
      FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl`
      WHERE nstd_lft_id = @nstd_lft_id_move_param_2
    ) AS id ON acl.nstd_lft_id = id.nstd_lft_id
  """ USING 
    CAST(NSTD_LFT_ID_MOVE AS INT64) AS nstd_lft_id_move_param, 
    NSTD_LFT_ID AS nstd_lft_id_param, 
    NSTD_LFT_ID_MOVE AS nstd_lft_id_move_param_2;

  -- Now delete the object, which will be moved to an other parent.
  EXECUTE IMMEDIATE """
    DELETE FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl`
    WHERE nstd_lft_id BETWEEN @lft AND @rgt
  """ USING NSTD_LFT_ID AS lft, NSTD_RGT_ID AS rgt;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl` 
    SET nstd_lft_id = CAST(nstd_lft_id - ROUND((@rgt - @lft + 1)) AS INT64)
    WHERE nstd_lft_id > @rgt
  """ USING NSTD_RGT_ID AS rgt, NSTD_LFT_ID AS lft;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl` 
    SET nstd_rgt_id = CAST(nstd_rgt_id - ROUND((@rgt - @lft + 1)) AS INT64)
    WHERE nstd_rgt_id > @rgt
  """ USING NSTD_RGT_ID AS rgt, NSTD_LFT_ID AS lft;

  -- Now delete the object, also from the parent_child Table.
  EXECUTE IMMEDIATE """
    DELETE FROM `p_lew_mart_msi.t_ref_obj_acl_parent_child`
    WHERE c_lft_id BETWEEN @lft AND @rgt
  """ USING NSTD_LFT_ID AS lft, NSTD_RGT_ID AS rgt;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child` 
    SET c_lft_id = CAST(c_lft_id - ROUND((@rgt - @lft + 1)) AS INT64)
    WHERE c_lft_id > @rgt
  """ USING NSTD_RGT_ID AS rgt, NSTD_LFT_ID AS lft;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child` 
    SET c_rgt_id = CAST(c_rgt_id - ROUND((@rgt - @lft + 1)) AS INT64)
    WHERE c_rgt_id > @rgt
  """ USING NSTD_RGT_ID AS rgt, NSTD_LFT_ID AS lft;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child` 
    SET p_lft_id = CAST(p_lft_id - ROUND((@rgt - @lft + 1)) AS INT64)
    WHERE p_lft_id > @rgt
  """ USING NSTD_RGT_ID AS rgt, NSTD_LFT_ID AS lft;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child` 
    SET p_rgt_id = CAST(p_rgt_id - ROUND((@rgt - @lft + 1)) AS INT64)
    WHERE p_rgt_id > @rgt
  """ USING NSTD_RGT_ID AS rgt, NSTD_LFT_ID AS lft;

  -- Update the move table at the same time
  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` 
    SET nstd_lft_id = CAST(nstd_lft_id - ROUND((@rgt - @lft + 1)) AS INT64)
    WHERE nstd_lft_id > @rgt
  """ USING NSTD_RGT_ID AS rgt, NSTD_LFT_ID AS lft;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` 
    SET nstd_rgt_id = CAST(nstd_rgt_id - ROUND((@rgt - @lft + 1)) AS INT64)
    WHERE nstd_rgt_id > @rgt
  """ USING NSTD_RGT_ID AS rgt, NSTD_LFT_ID AS lft;

  -- Now update the IDs so that the moved object can be inserted
  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl` AS acl 
    SET nstd_rgt_id = acl.nstd_rgt_id + 2 
    FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` AS move
    WHERE acl.nstd_rgt_id >= move.nstd_rgt_id
      AND move.security_role_id = 1
      AND move.approved = 1
      AND move.active_fg = 1
  """;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ct_sec_role_obj_acl` AS acl 
    SET nstd_lft_id = acl.nstd_lft_id + 2 
    FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` AS move
    WHERE acl.nstd_lft_id > move.nstd_rgt_id
      AND move.security_role_id = 1
      AND move.approved = 1
      AND move.active_fg = 1
  """;

  -- Now insert the object again under the new parent object
  EXECUTE IMMEDIATE """
    INSERT INTO `p_lew_mart_msi.t_ct_sec_role_obj_acl` (
      security_role_id, security_role_desc, object_name, object_type_id, object_path,
      nstd_lft_id, nstd_rgt_id, authorized, entry_user, entry_datetime,
      approval_user, approval_datetime, approved, active_fg, zero_val
    )
    SELECT
      move.security_role_id, move.security_role_desc, move.object_name, move.object_type_id,
      acl.object_path || move.object_name || '\\\\', move.nstd_rgt_id, move.nstd_rgt_id + 1,
      move.authorized, move.entry_user, move.entry_datetime, move.approval_user, move.approval_datetime,
      move.approved, move.active_fg, move.zero_val
    FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` AS move
    INNER JOIN `p_lew_mart_msi.t_ct_sec_role_obj_acl` AS acl ON acl.nstd_lft_id = move.nstd_lft_id
  """;

  -- The same insert has to be done to the parent child table
  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child` AS acl 
    SET p_rgt_id = acl.p_rgt_id + 2 
    FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` AS move
    WHERE acl.p_rgt_id >= move.nstd_rgt_id
      AND move.security_role_id = 1
      AND move.approved = 1
      AND move.active_fg = 1
  """;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child` AS acl 
    SET p_lft_id = acl.p_lft_id + 2 
    FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` AS move
    WHERE acl.p_lft_id > move.nstd_rgt_id
      AND move.security_role_id = 1
      AND move.approved = 1
      AND move.active_fg = 1
  """;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child` AS acl 
    SET c_rgt_id = acl.c_rgt_id + 2 
    FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` AS move
    WHERE acl.c_rgt_id >= move.nstd_rgt_id
      AND move.security_role_id = 1
      AND move.approved = 1
      AND move.active_fg = 1
  """;

  EXECUTE IMMEDIATE """
    UPDATE `p_lew_mart_msi.t_ref_obj_acl_parent_child` AS acl 
    SET c_lft_id = acl.c_lft_id + 2 
    FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move` AS move
    WHERE acl.c_lft_id > move.nstd_rgt_id
      AND move.security_role_id = 1
      AND move.approved = 1
      AND move.active_fg = 1
  """;

  EXECUTE IMMEDIATE """
    INSERT INTO `p_lew_mart_msi.t_ref_obj_acl_parent_child` (
      p_lft_id, p_rgt_id, p_object_name, c_lft_id, c_rgt_id
    )
    SELECT
      p.nstd_lft_id, p.nstd_rgt_id, p.object_name, c.nstd_rgt_id, c.nstd_rgt_id + 1
    FROM (
      SELECT nstd_lft_id, nstd_rgt_id, object_name
      FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl`
      GROUP BY 1, 2, 3
    ) AS p
    INNER JOIN (
      SELECT nstd_lft_id, nstd_rgt_id
      FROM `p_lew_mart_msi.t_ct_sec_role_obj_acl_move`
      GROUP BY 1, 2
    ) AS c ON c.nstd_rgt_id >= p.nstd_lft_id AND c.nstd_rgt_id <= p.nstd_rgt_id
  """;

END;