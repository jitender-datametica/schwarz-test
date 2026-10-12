CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_MEAS_GRP_ACT_1
  (
    meas_grp_id
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
 FROM p_lew_process_mstr.t_ref_meas_grp_1
 WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
 AND deleted_fg = 0
;