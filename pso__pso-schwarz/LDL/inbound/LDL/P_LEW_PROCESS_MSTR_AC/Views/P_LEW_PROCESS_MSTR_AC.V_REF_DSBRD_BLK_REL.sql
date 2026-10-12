CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_DSBRD_BLK_REL
( dsbrd_id
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
  FROM p_lew_process_mstr.t_ref_dsbrd_blk_rel
;