CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_NVGTN_MEAS_DOC_1
(
  dsbrd_id
, phy_doc_id
, meas_grp_id
, dsbrd_meas_grp_ord
, phy_doc_desc
, mstr_phy_doc_guid
, phy_doc_type_id
, url_mtrc
, load_id
, dwh_inserted
, dwh_updated
)
AS
   SELECT
     dsbrd_id,
   phy_doc_id,
   meas_grp_id,
   dsbrd_meas_grp_ord,
   phy_doc_desc,
   mstr_phy_doc_guid,
   phy_doc_type_id,
   url_mtrc,
   load_id,
   dwh_inserted,
   dwh_updated
  FROM p_lew_process_mstr.v_ref_nvgtn_meas_doc_1
;