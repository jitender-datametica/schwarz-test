CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_MEAS_TYP_ACT_1
( meas_type_id
, meas_type_desc
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     meas_type_id,
   meas_type_desc,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.v_ref_meas_typ_act_1
;