CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_DSBRD_PHDOC_MEAS_1
( phy_doc_type_id
, dsbrd_id
, meas_id
, phy_doc_dsbrd_meas_ord
, meas_titl
, tm_lvl_id
, meas_fmt_id
, meas_grp_titl
, tot_fl
, avg_fl
)
AS
   SELECT
     phy_doc_type_id,
   dsbrd_id,
   meas_id,
   phy_doc_dsbrd_meas_ord,
   meas_titl,
   tm_lvl_id,
   meas_fmt_id,
   meas_grp_titl,
   tot_fl,
   avg_fl
  FROM p_lew_process_mstr.v_ref_dsbrd_phdoc_meas_1
;