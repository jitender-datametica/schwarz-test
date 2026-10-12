CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_DSBRD_BLK_REL_ACT_1
     (
       dsbrd_id
     , phy_doc_type_id
     , blk_id
     , dsbrd_blk_ord
     , deleted_fg
     , dwh_valid_from
     , dwh_valid_to
     , dwh_load_id
     , dwh_created
     , dwh_updated
     )
     AS
        SELECT
          dsbrd_id,
        phy_doc_type_id,
        blk_id,
        dsbrd_blk_ord,
        deleted_fg,
        dwh_valid_from,
        dwh_valid_to,
        dwh_load_id,
        dwh_created,
        dwh_updated
 FROM p_lew_process_mstr.t_ref_dsbrd_blk_rel_1
 WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0
;