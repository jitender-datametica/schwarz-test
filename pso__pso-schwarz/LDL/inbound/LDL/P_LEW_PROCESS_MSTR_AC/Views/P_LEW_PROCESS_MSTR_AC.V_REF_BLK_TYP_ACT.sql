CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_BLK_TYP_ACT
( blk_type_id
, blk_type_desc
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
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
  FROM p_lew_process_mstr.v_ref_blk_typ_act
;