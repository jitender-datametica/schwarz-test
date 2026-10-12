CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_nvgtn_doc_1 (int_id, client_ctry_id, client_id, curr_client_id,
aspect_id, wh_id, move_to_store_id, org_lvl_id, org_ele_link, cy_month, cy_week, byr, tm_ele_link, dsbrd_id, phy_doc_id
, phy_doc_type_ord, phy_doc_type_id_prmt, html_doc_url, org_ele_desc, cmbn_brdcrum) AS SELECT MNO.int_id,
 MNO.client_ctry_id,
 MNO.client_id,
 MNO.curr_client_id,
 MNO.aspect_id,
 MNO.wh_id,
 MNO.move_to_store_id,
 MNO.org_lvl_id,
 MNO.org_ele_link,
 MNT.cy_month,
 MNT.cy_week,
 MNT.byr,
 MNT.tm_ele_link,
 OU.dsbrd_id,
 OU.phy_doc_id,
 DT.phy_doc_type_ord,
 THRES_TYPE.phy_doc_type_id AS phy_doc_type_id_prmt,
           '<a style="background-color:' || CASE
            WHEN OU.phy_doc_type_id = THRES_TYPE.phy_doc_type_id
            THEN '#0B3E6C;color:white'
            ELSE '#FFFFFF;color:black'
            END ||
          ';padding:10pt;text-decoration:none;" href="#" onclick="javascript:window.location.href=\'\'mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
           || OU.url_mtrc || OU.sub_nav_prmpt || MNT.tm_ele_link || ',' || MNO.org_ele_link ||
    '&selectorMode=2&originMessageID=\'\'+mstrApp.docModel.mid;">' || DT.phy_doc_type_desc || '</a>' AS html_doc_url,
 MNO.org_ele_desc,
   MNO.org_brdcrum || ' | ' || MNT.tm_brdcrum AS cmbn_brdcrum
FROM ldl_p_lew_process_mstr.t_agg_obj_url_1 AS OU
 INNER JOIN ldl_p_lew_process_mstr.v_ref_phdoc_typ_act_1 AS DT ON OU.phy_doc_type_id = DT.phy_doc_type_id
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_org_1 AS MNO ON TRUE
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_tm_1 AS MNT ON TRUE
 INNER JOIN ldl_p_lew_process_mstr.v_ref_phdoc_typ_act_1 AS THRES_TYPE ON TRUE;