CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_MEAS_GRP_ACT_2
( meas_grp_id
, meas_grp_desc
, img_meas_url_link
, meas_grp_text_id
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     meas_grp_id,
   meas_grp_desc,
   img_meas_url_link,
   meas_grp_text_id,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.v_ref_meas_grp_act_2
;