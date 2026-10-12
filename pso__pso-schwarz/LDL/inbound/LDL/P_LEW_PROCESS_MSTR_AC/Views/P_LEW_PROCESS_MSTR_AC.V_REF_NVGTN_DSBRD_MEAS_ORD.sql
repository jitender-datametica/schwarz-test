CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_NVGTN_DSBRD_MEAS_ORD
( dsbrd_id
, blk_id
, phy_doc_type_id
, dsbrd_blk_ord
, meas_grp_id
, meas_grp_cnt
, hd_row_ind
, blk_meas_titl_text_id
, blk_meas_titl2_text_id
, meas_id
, mstr_mtrc_guid
, tot_meas_id
, tot_mstr_mtrc_guid
, blk_meas_ord
, dsbrd_meas_ord
)
AS
   SELECT
     dsbrd_id,
   blk_id,
   phy_doc_type_id,
   dsbrd_blk_ord,
   meas_grp_id,
   meas_grp_cnt,
   hd_row_ind,
   blk_meas_titl_text_id,
   blk_meas_titl2_text_id,
   meas_id,
   mstr_mtrc_guid,
   tot_meas_id,
   tot_mstr_mtrc_guid,
   blk_meas_ord,
   dsbrd_meas_ord
  FROM p_lew_process_mstr.v_ref_nvgtn_dsbrd_meas_ord
;