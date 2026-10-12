CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_REF_NVGTN_TM_DTL_DOC
(
   int_id
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
   mno.int_id,
   mno.client_ctry_id,
   mno.client_id,
   mno.aspect_id,
   mno.wh_id,
   mno.move_to_store_id,
   mno.org_lvl_id,
   mno.org_ele_link,
   mnt.cy_month,
   mnt.cy_week,
   mnt.byr,
   mnt.tm_ele_link,
   dmg.dsbrd_id,
   dmg.phy_doc_id,
   mg.meas_grp_id,
   dmg.dsbrd_meas_grp_ord,
   mgp.meas_grp_id AS meas_grp_id_prmt,
   pd.phy_doc_type_id,
   CASE
       WHEN mnm.mstr_phy_doc_guid IS NULL THEN '<font color=grey>' || mg.meas_grp_desc || '</font>'
       ELSE '<a style="background-color:'
       || CASE
          WHEN mg.meas_grp_id = meas_grp_id_prmt THEN '#0B3E6C;color:white'
          ELSE '#FFFFFF;color:#0B3E6C'
          END
       || ';padding:10pt;text-decoration:none;" href="#" onclick="javascript:window.location.href=''mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
       || COALESCE(mnm.mstr_phy_doc_guid,'')
       || '&promptAnswerMode=2'
       || '&objectsPromptAnswers='
       || COALESCE(mnm.url_mtrc,'')
       || '&elementsPromptAnswers='
       || mnt.tm_ele_link || ','
       || mno.org_ele_link || ','
       || lrg1.guid_id || ':'
       || COALESCE(CAST((mnm.dsbrd_id /*Warning, Format 'z(19)9' removed.*/) AS VARCHAR(20)),'')
       || ','
       || 'F5B6A0804598CC88CDC4E3A43321AC8C;F5B6A0804598CC88CDC4E3A43321AC8C:'
       || COALESCE(CAST((mnm.phy_doc_type_id /*Warning, Format 'z(6)9' removed.*/) AS VARCHAR(7)),'')
       || ','
       || '0BF104D7438427784346989D181DF50A;0BF104D7438427784346989D181DF50A:'
       || COALESCE(CAST((mg.meas_grp_id /*Warning, Format 'z(6)9' removed.*/) AS VARCHAR(7)),'')
       || '&selectorMode=2&originMessageID=''+(function(){var a=mstrApp.getLastMsgRecoveryInfo();return JSON.parse(a).url.match(/(messageID=).{32}/g)[0].substring(10,42)})(); return false;">'
       || mg.meas_grp_desc
       || '</a>'
   END AS html_doc_kpi_url
   FROM p_lew_process_mstr.v_ref_phdoc_dsbrd_meas_grp_act AS dmg
   INNER JOIN p_lew_process_mstr.v_ref_meas_grp_act AS mg
   ON dmg.meas_grp_id = mg.meas_grp_id
   LEFT OUTER JOIN p_lew_process_mstr.v_ref_nvgtn_meas_doc AS mnm
   ON mnm.meas_grp_id = dmg.meas_grp_id
   AND mnm.dsbrd_id = dmg.dsbrd_id
   AND mnm.phy_doc_id = dmg.phy_doc_id
   INNER JOIN p_lew_process_mstr.v_ref_phdoc_act AS pd
   ON dmg.phy_doc_id = pd.phy_doc_id
   CROSS JOIN p_lew_process_mstr.v_ref_meas_grp_act AS mgp
   CROSS JOIN p_lew_process_mstr.t_agg_nvgtn_org AS mno
   CROSS JOIN p_lew_process_mstr.t_agg_nvgtn_tm AS mnt
   CROSS JOIN  /* p_lew_process_mstr.v_ref_mstr_atrib_guid_act */
   (SELECT
   guid_id
   FROM p_lew_process_mstr.v_ref_mstr_atrib_guid_act
   WHERE   atrib_id = 9
   ) AS lrg1
;