CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_PHDOC_DSBRD_MEAS_REL_ACT_2
( meas_id
, dsbrd_id
, phy_doc_id
, phy_doc_dsbrd_meas_ord
, tot_meas_id
, meas_text_id
, deleted_fg
, dwh_valid_from
, dwh_valid_to
, dwh_load_id
, dwh_created
, dwh_updated
)
AS
   SELECT
     meas_id,
   dsbrd_id,
   phy_doc_id,
   phy_doc_dsbrd_meas_ord,
   tot_meas_id,
   meas_text_id,
   deleted_fg,
   dwh_valid_from,
   dwh_valid_to,
   dwh_load_id,
   dwh_created,
   dwh_updated
  FROM p_lew_process_mstr.v_ref_phdoc_dsbrd_meas_rel_act_2
;