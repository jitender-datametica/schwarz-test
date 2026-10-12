CREATE OR REPLACE VIEW ldl_p_lew_process_mstr.v_agg_nvgtn_blk_pg_url (int_id, client_ctry_id, client_id, aspect_id,
wh_id, move_to_store_id, org_lvl_id, org_ele_link, cy_month, cy_week, byr, tm_ele_link, dsbrd_id, phy_doc_type_id,
blk_id, blk_id_prmpt, dsbrd_blk_ord, meas_group_id, dsbrd_meas_grp_ord, dspl_meas_grp_fl, blk_strt_pg_fl, prev_pg_no,
pg_no, next_pg_no, prev_pg_url, pg_url, act_pg_url, next_pg_url) AS SELECT MNO.int_id,
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
 DMPN.dsbrd_id,
 DMPN.phy_doc_type_id,
 DMPN.blk_id,
 DBR.blk_id AS blk_id_prmpt,
 DMPN.dsbrd_blk_ord,
 DMPN.meas_grp_id AS meas_group_id,
 DMPN.dsbrd_meas_grp_ord,
 DMPN.dspl_meas_grp_fl,
 DMPN.blk_strt_pg_fl,
 DMPN.prev_pg_no,
 DMPN.pg_no,
 DMPN.next_pg_no,
       'mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID=' || DMPN.prev_pg_guid || ',' || MNT.tm_ele_link || ',' ||
   MNO.org_ele_link || '&selectorMode=2&originMessageID=' -- {&DOCUMENTMESSAGEID} generated at document level
 AS
 prev_pg_url,
           '<a style="background-color:' || CASE
            WHEN DMPN.blk_id = DBR.blk_id
            THEN '#0B3E6C;color:white'
            ELSE '#FFFFFF;color:#0B3E6C'
            END ||
          ';padding:15pt;text-decoration:none;" href="#" onclick="javascript:window.location.href=\'\'mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
           || DMPN.pg_guid || ',' || MNT.tm_ele_link || ',' || MNO.org_ele_link ||
    '&selectorMode=2&originMessageID=\'\'+(function(){var a=mstrApp.getLastMsgRecoveryInfo();return JSON.parse(a).url.match(/(messageID=).{32}/g)[0].substring(10,42)})(); return false;">'
     || TXT.text_desc || '</a>' AS pg_url,
       'mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID=' || DMPN.pg_guid || ',' || MNT.tm_ele_link || ',' || MNO.org_ele_link
    || '&selectorMode=2&originMessageID=' -- {&DOCUMENTMESSAGEID} generated at document level
 AS act_pg_url,
       'mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID=' || DMPN.next_pg_guid || ',' || MNT.tm_ele_link || ',' ||
   MNO.org_ele_link || '&selectorMode=2&originMessageID=' -- {&DOCUMENTMESSAGEID} generated at document level
 AS
 next_pg_url
FROM ldl_p_lew_process_mstr.t_agg_dsbrd_meas_pg_nvgtn AS DMPN
 INNER JOIN ldl_p_lew_process_mstr.v_ref_blk_act AS BL ON DMPN.blk_id = BL.blk_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_text_act AS TXT ON BL.blk_titl_text_id = TXT.text_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_phdoc_act AS PD ON DMPN.phy_doc_type_id = PD.phy_doc_type_id
 INNER JOIN ldl_p_lew_process_mstr.v_ref_dsbrd_blk_rel_act AS DBR ON DMPN.dsbrd_id = DBR.dsbrd_id
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_org AS MNO ON TRUE
 INNER JOIN ldl_p_lew_process_mstr.t_agg_nvgtn_tm AS MNT ON TRUE;