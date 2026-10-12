CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_DSBRD_BLK_PHY_MEAS_FMT_2
( dsbrd_id
, blk_id
, phy_doc_type_id
, meas_id
, dsbrd_meas_ord
, pg_meas_ord
, pg_no
, meas_fmt_id
)
AS
   SELECT
     dsbrd_id,
   blk_id,
   phy_doc_type_id,
   meas_id,
   dsbrd_meas_ord,
   pg_meas_ord,
   pg_no,
   meas_fmt_id
  FROM p_lew_process_mstr.v_ref_dsbrd_blk_phy_meas_fmt_2
;