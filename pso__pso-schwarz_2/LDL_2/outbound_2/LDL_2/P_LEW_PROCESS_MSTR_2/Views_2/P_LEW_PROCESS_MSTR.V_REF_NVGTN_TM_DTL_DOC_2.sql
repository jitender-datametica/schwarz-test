CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_ref_nvgtn_tm_dtl_doc_2 (int_id, client_ctry_id, client_id, aspect_id,
wh_id, move_to_store_id, org_lvl_id, org_ele_link, cy_month, cy_week, byr, tm_ele_link, dsbrd_id, phy_doc_id,
meas_grp_id, dsbrd_meas_grp_ord, meas_grp_id_prmt, phy_doc_type_id, html_doc_kpi_url) AS
/* p_lew_process_mstr.v_ref_mstr_atrib_guid_act_2 */ SELECT MNO.int_id,
 MNO.client_ctry_id,
 MNO.client_id,
 MNO.aspect_id,
 MNO.wh_id,
 MNO.move_to_store_id,
 MNO.org_lvl_id,
 MNO.org_ele_link,
 MNT.cy_month,
 MNT.cy_week,
 MNT.byr,
 MNT.tm_ele_link,
 DMG.dsbrd_id,
 DMG.phy_doc_id,
 MG.meas_grp_id,
 DMG.dsbrd_meas_grp_ord,
 MGP.meas_grp_id AS meas_grp_id_prmt,
 PD.phy_doc_type_id,
  CASE
  WHEN MNM.mstr_phy_doc_guid IS NULL
  THEN '<font color=grey>' || MG.meas_grp_desc || '</font>'
  ELSE '<a style="background-color:' || CASE
                          WHEN MG.meas_grp_id = MGP.meas_grp_id
                          THEN '#0B3E6C;color:white'
                          ELSE '#FFFFFF;color:#0B3E6C'
                          END ||
                        ';padding:10pt;text-decoration:none;" href="#" onclick="javascript:window.location.href=\'\'mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
                         || COALESCE(MNM.mstr_phy_doc_guid, '') || '&promptAnswerMode=2' || '&objectsPromptAnswers=' ||
                    COALESCE(MNM.url_mtrc, '') || '&elementsPromptAnswers=' || MNT.tm_ele_link || ',' || MNO.org_ele_link
                 || ',' || lrg1.guid_id || ':' || COALESCE(CAST(MNM.dsbrd_id /* Warning, Format 'z(19)9' removed. */ AS STRING)
             , '') || ',' || 'F5B6A0804598CC88CDC4E3A43321AC8C;F5B6A0804598CC88CDC4E3A43321AC8C:' || COALESCE(CAST(MNM.phy_doc_type_id /* Warning, Format 'z(6)9' removed. */ AS STRING)
          , '') || ',' || '0BF104D7438427784346989D181DF50A;0BF104D7438427784346989D181DF50A:' || COALESCE(CAST(MG.meas_grp_id /* Warning, Format 'z(6)9' removed. */ AS STRING)
       , '') ||
     '&selectorMode=2&originMessageID=\'\'+(function(){var a=mstrApp.getLastMsgRecoveryInfo();return JSON.parse(a).url.match(/(messageID=).{32}/g)[0].substring(10,42)})(); return false;">'
      || MG.meas_grp_desc || '</a>'
  END AS html_doc_kpi_url
FROM ldl_p_lew_process_mstr.v_ref_phdoc_dsbrd_meas_grp_act_2 AS DMG
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_grp_act_2 AS MG ON DMG.meas_grp_id = MG.meas_grp_id
 LEFT JOIN ldl_p_lew_process_mstr.v_ref_nvgtn_meas_doc_2 AS MNM ON DMG.meas_grp_id = MNM.meas_grp_id AND DMG.dsbrd_id =
    MNM.dsbrd_id AND DMG.phy_doc_id = MNM.phy_doc_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_phdoc_act_2 AS PD_2 ON DMG.phy_doc_id = PD.phy_doc_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_meas_grp_act_2 AS MGP ON TRUE
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_org_2 AS MNO ON TRUE
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_tm_2 AS MNT ON TRUE
 INNER JOIN (SELECT guid_id
  FROM ldl_p_lew_process_mstr.v_ref_mstr_atrib_guid_act_2
  WHERE atrib_id = 9) AS lrg1 ON TRUE;