CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_DYN_DSBRD_ACT
( dsbrd_id
, dsbrd_act_fg
, dsbrd_desc
, app_id
, resort_id
, deleted_fg
, del_fg
, dwh_valid_from
, dwh_vld_from
, dwh_valid_to
, dwh_vld_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     dsbrd_id,
   dsbrd_act_fg,
   dsbrd_desc,
   app_id,
   resort_id,
   deleted_fg,
   del_fg,
   dwh_valid_from,
   dwh_vld_from,
   dwh_valid_to,
   dwh_vld_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.v_ref_dyn_dsbrd_act
;