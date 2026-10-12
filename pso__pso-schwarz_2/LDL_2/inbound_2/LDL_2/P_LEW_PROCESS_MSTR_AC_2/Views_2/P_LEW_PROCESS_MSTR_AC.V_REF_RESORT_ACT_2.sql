CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_RESORT_ACT_2
( resort_id
, resort_desc
, resort_ord
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     resort_id,
   resort_desc,
   resort_ord,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.v_ref_resort_act_2
;