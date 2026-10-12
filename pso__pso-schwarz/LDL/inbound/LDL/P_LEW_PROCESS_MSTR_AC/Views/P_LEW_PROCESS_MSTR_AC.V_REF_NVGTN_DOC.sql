CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR_AC.V_REF_NVGTN_DOC
( int_id
, client_ctry_id
, client_id
, curr_client_id
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
, phy_doc_type_ord
, phy_doc_type_id_prmt
, html_doc_url
, org_ele_desc
, cmbn_brdcrum
)
AS
   SELECT
     int_id,
   client_ctry_id,
   client_id,
   curr_client_id,
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
   phy_doc_type_ord,
   phy_doc_type_id_prmt,
   html_doc_url,
   org_ele_desc,
   cmbn_brdcrum
  FROM p_lew_process_mstr.v_ref_nvgtn_doc
;