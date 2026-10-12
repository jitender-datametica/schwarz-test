CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_PHDOC_DSBRD_MEAS_GRP_ACT_2
(
  meas_grp_id
, dsbrd_id
, phy_doc_id
, dsbrd_meas_grp_ord
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
   dsbrd_id,
   phy_doc_id,
   dsbrd_meas_grp_ord,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.t_ref_phdoc_dsbrd_meas_grp_2
  WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
  AND deleted_fg = 0;