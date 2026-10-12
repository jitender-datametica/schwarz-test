CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_DSBRD_BLK_PHY_MEAS_DESC_1
( phy_doc_type_id
, dsbrd_id
, blk_meas_ord
, pg_no
, blk_id
, meas_id
, meas_titl
, meas_titl_2
, tm_lvl_id
, meas_grp_id
, dsbrd_meas_ord
, pg_meas_ord
, meas_grp_titl
, blk_titl
)
AS
   SELECT
     phy_doc_type_id,
   dsbrd_id,
   blk_meas_ord,
   pg_no,
   blk_id,
   meas_id,
   meas_titl,
   meas_titl_2,
   tm_lvl_id,
   meas_grp_id,
   dsbrd_meas_ord,
   pg_meas_ord,
   meas_grp_titl,
   blk_titl
  FROM p_lew_process_mstr.v_ref_dsbrd_blk_phy_meas_desc_1
;