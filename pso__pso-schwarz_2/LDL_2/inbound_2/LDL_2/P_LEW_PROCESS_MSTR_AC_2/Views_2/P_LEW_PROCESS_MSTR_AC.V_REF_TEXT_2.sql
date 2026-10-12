CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_TEXT_2
( text_id
, tm_lvl_id
, text_desc
, lang_cd
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     text_id,
   tm_lvl_id,
   text_desc,
   lang_cd,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_ref_text_2
;