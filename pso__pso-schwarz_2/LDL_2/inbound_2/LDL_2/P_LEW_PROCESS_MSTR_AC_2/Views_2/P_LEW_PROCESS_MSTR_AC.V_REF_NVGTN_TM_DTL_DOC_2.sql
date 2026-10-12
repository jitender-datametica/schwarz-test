CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_NVGTN_TM_DTL_DOC_2
( int_id
, client_ctry_id
, client_id
, aspect_id
, wh_id
, move_to_store_id
, org_lvl_id
, org_ele_link
, cy_month
, cy_week
, byr
, tm_ele_link
, dsbrd_id
, phy_doc_id
, meas_grp_id
, dsbrd_meas_grp_ord
, meas_grp_id_prmt
, phy_doc_type_id
, html_doc_kpi_url
)
AS
   SELECT
     int_id,
   client_ctry_id,
   client_id,
   aspect_id,
   wh_id,
   move_to_store_id,
   org_lvl_id,
   org_ele_link,
   cy_month,
   cy_week,
   byr,
   tm_ele_link,
   dsbrd_id,
   phy_doc_id,
   meas_grp_id,
   dsbrd_meas_grp_ord,
   meas_grp_id_prmt,
   phy_doc_type_id,
   html_doc_kpi_url
  FROM p_lew_process_mstr.v_ref_nvgtn_tm_dtl_doc_2
;