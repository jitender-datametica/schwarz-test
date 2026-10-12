CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_NVGTN_DOC
(
   int_id
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
   mno.int_id,
   mno.client_ctry_id,
   mno.client_id,
   mno.curr_client_id,
   mno.aspect_id,
   mno.wh_id,
   mno.move_to_store_id,
   mno.org_lvl_id,
   mno.org_ele_link,
   mnt.cy_month,
   mnt.cy_week,
   mnt.byr,
   mnt.tm_ele_link,
   ou.dsbrd_id,
   ou.phy_doc_id,
   dt.phy_doc_type_ord,
   thres_type.phy_doc_type_id AS phy_doc_type_id_prmt,
   '<a style="background-color:'
     || CASE
          WHEN ou.phy_doc_type_id = thres_type.phy_doc_type_id THEN '#0B3E6C;color:white'
          ELSE '#FFFFFF;color:black'
         END
     ||';padding:10pt;text-decoration:none;" href="#" onclick="javascript:window.location.href=''mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
     || ou.url_mtrc
     || ou.sub_nav_prmpt
     || mnt.tm_ele_link
     || ','
     || mno.org_ele_link
     || '&selectorMode=2&originMessageID=''+mstrApp.docModel.mid;">'
     || dt.phy_doc_type_desc
     || '</a>' AS html_doc_url,
   mno.org_ele_desc,
   mno.org_brdcrum
     || ' | '
     || mnt.tm_brdcrum AS cmbn_brdcrum
   FROM p_lew_process_mstr.t_agg_obj_url AS ou
   INNER JOIN p_lew_process_mstr.v_ref_phdoc_typ_act AS dt
   ON ou.phy_doc_type_id = dt.phy_doc_type_id
   CROSS JOIN p_lew_process_mstr.t_agg_nvgtn_org AS mno
   CROSS JOIN p_lew_process_mstr.t_agg_nvgtn_tm AS mnt
   CROSS JOIN p_lew_process_mstr.v_ref_phdoc_typ_act AS thres_type
;