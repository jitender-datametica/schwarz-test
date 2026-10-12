CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_BLK
( blk_id
, blk_desc
, blk_type_id
, blk_titl_text_id
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     blk_id,
   blk_desc,
   blk_type_id,
   blk_titl_text_id,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_ref_blk
;