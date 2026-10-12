CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_BLK_TYP_ACT
  (
  blk_type_id
  ,blk_type_desc
  ,deleted_fg
  ,dwh_valid_from
  ,dwh_valid_to
  ,dwh_load_id
  ,dwh_created
  ,dwh_updated
  )
  AS
     SELECT
     blk_type_id,
     blk_type_desc,
     deleted_fg,
     dwh_valid_from,
     dwh_valid_to,
     dwh_load_id,
     dwh_created,
     dwh_updated
     FROM p_lew_process_mstr.t_ref_blk_typ
     WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
     AND deleted_fg = 0;