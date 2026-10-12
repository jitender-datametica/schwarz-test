CREATE OR REPLACE VIEW P_LEW_PROCESS_MSTR.V_AGG_NVGTN_BLK_PG_URL
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
 , phy_doc_type_id
 , blk_id
 , blk_id_prmpt
 , dsbrd_blk_ord
 , meas_group_id
 , dsbrd_meas_grp_ord
 , dspl_meas_grp_fl
 , blk_strt_pg_fl
 , prev_pg_no
 , pg_no
 , next_pg_no
 , prev_pg_url
 , pg_url
 , act_pg_url
 , next_pg_url
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
   dmpn.dsbrd_id,
   dmpn.phy_doc_type_id,
   dmpn.blk_id,
   dbr.blk_id,
   dmpn.dsbrd_blk_ord,
   dmpn.meas_grp_id,
   dmpn.dsbrd_meas_grp_ord,
   dmpn.dspl_meas_grp_fl,
   dmpn.blk_strt_pg_fl,
   dmpn.prev_pg_no,
   dmpn.pg_no,
   dmpn.next_pg_no,
   CAST('mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
    || dmpn.prev_pg_guid
    || ','
    || mnt.tm_ele_link
    || ','
    || mno.org_ele_link
    || '&selectorMode=2&originMessageID=' -- {&DOCUMENTMESSAGEID} generated at document level
       AS VARCHAR(2300) ) AS prev_pg_url,
   CAST('<a style="background-color:'
    || CASE
          WHEN dmpn.blk_id = dbr.blk_id THEN '#0B3E6C;color:white'
          ELSE '#FFFFFF;color:#0B3E6C'
        END
    || ';padding:15pt;text-decoration:none;" href="#" onclick="javascript:window.location.href=''mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
    || dmpn.pg_guid
    || ','
    || mnt.tm_ele_link
    || ','
    || mno.org_ele_link
    || '&selectorMode=2&originMessageID=''+(function(){var a=mstrApp.getLastMsgRecoveryInfo();return JSON.parse(a).url.match(/(messageID=).{32}/g)[0].substring(10,42)})(); return false;">'
    || txt.text_desc
    || '</a>' AS VARCHAR(2300) ) AS pg_url,
   CAST('mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
    || dmpn.pg_guid
    || ','
    || mnt.tm_ele_link
    || ','
    || mno.org_ele_link
    || '&selectorMode=2&originMessageID=' -- {&DOCUMENTMESSAGEID} generated at document level
    AS VARCHAR(2300) ) AS act_pg_url,
   CAST('mstrWeb?&evt=2048001&src=mstrWeb.2048001&documentID='
    || dmpn.next_pg_guid
    || ','
    || mnt.tm_ele_link
    || ','
    || mno.org_ele_link
    || '&selectorMode=2&originMessageID=' -- {&DOCUMENTMESSAGEID} generated at document level
    AS VARCHAR(2300) ) AS next_pg_url
  FROM p_lew_process_mstr.t_agg_dsbrd_meas_pg_nvgtn AS dmpn
   INNER JOIN p_lew_process_mstr.v_ref_blk_act AS bl
   ON dmpn.blk_id  = bl.blk_id
   INNER JOIN p_lew_process_mstr.v_ref_text_act AS txt
   ON bl.blk_titl_text_id  = txt.text_id
   INNER JOIN p_lew_process_mstr.v_ref_phdoc_act AS pd
   ON dmpn.phy_doc_type_id = pd.phy_doc_type_id
   INNER JOIN p_lew_process_mstr.v_ref_dsbrd_blk_rel_act AS dbr
   ON dmpn.dsbrd_id  = dbr.dsbrd_id
   CROSS JOIN p_lew_process_mstr.t_agg_nvgtn_org AS mno
   CROSS JOIN p_lew_process_mstr.t_agg_nvgtn_tm AS mnt
;