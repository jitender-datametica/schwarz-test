/* #----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2021       Michael Morris                Initial Version
#                                                      TeraData: 20210318_2789_itm_store_cons
#                                                      https://jira.schwarz/browse/INTMIG-779
#                                                      SF: https://jira.schwarz/browse/INTMIG-1399
#  1.1  10.05.2022       Michael Morsis                Item_1 SIDs now retrieved from v_item_map_key_1
#                                                      due to missing Item_1 SIDs in v_wawi_itm_item_wh.
#                                                      v_wawi_itm_item_wh_1 only used to obtain all the 
#                                                      current warehouse SIDs.
#                                                      Azure User Story: 323718
#---------------------------------------------------------------------------- */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_itm_item_store_consolidation_1 (client_id, wh_id, aspect_id, store_id,
item_id, itm_consgrp_id, cons_item_id, cons_orig_item_nr, cons_dat_valid_from_item, cons_fg, itm_consgrp_desc, item_desc
) OPTIONS(DESCRIPTION = `ITEM_1/STORE CONSOLIDATIO VIEW`) AS /* old source: P_LEW_CORE_AC.v_wawi_itm_item_wh_1 */
/* Old source: P_LEW_CORE_AC.v_wawi_itm_item_wh_1 */ /* Auflösung WH */ SELECT i.client_id,
 whm.tr_wh_id AS wh_id,
 whm.aspect_id,
 whm.store_id,
 i.item_sid AS item_id,
 i.itm_consgrp_id,
 i.cons_item_id,
  CASE
  WHEN i.itm_consgrp_id = - 1
  THEN A.orig_item_nr
  ELSE CAST(- 1 AS BIGNUMERIC)
  END AS cons_orig_item_nr,
  CASE
  WHEN i.itm_consgrp_id = - 1
  THEN A.dat_valid_from
  ELSE DATE '1900-01-01'
  END AS cons_dat_valid_from_item,
  CASE
  WHEN i.itm_consgrp_id = - 1
  THEN 0
  ELSE 1
  END AS cons_fg,
 CGP.itm_consgrp_desc,
 OID.item_desc
FROM (SELECT i1.client_id,
    i1.wh_loc_sid,
    i1.item_sid,
    C1.itm_consgrp_id,
    CAST(- 1 AS BIGNUMERIC) AS cons_item_id
   FROM (SELECT DISTINCT IKM.client_id,
      w.wh_loc_sid,
      IKM.item_sid_map AS item_sid
     FROM ldl_p_lew_core_ac.v_item_map_key_1 AS IKM
      INNER JOIN (SELECT DISTINCT client_id,
        wh_loc_sid
       FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_1
       WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end) AS w ON IKM.client_id = w.client_id
     WHERE IKM.active_fg = 1) AS i1
    INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_1 AS C1 ON i1.client_id = C1.client_id AND i1.item_sid = C1
       .item_sid AND i1.wh_loc_sid = C1.wh_loc_sid
   WHERE CURRENT_DATE BETWEEN C1.dat_rec_start AND C1.dat_rec_end
   UNION ALL
   SELECT client_id,
    wh_loc_sid,
    item_sid,
    CAST(- 1 AS BIGNUMERIC) AS itm_consgrp_id,
    item_sid AS cons_item_sid
   FROM (SELECT DISTINCT IKM.client_id,
      w.wh_loc_sid,
      IKM.item_sid_map AS item_sid
     FROM ldl_p_lew_core_ac.v_item_map_key_1 AS IKM
      INNER JOIN (SELECT DISTINCT client_id,
        wh_loc_sid
       FROM ldl_p_lew_core_ac.v_wawi_itm_item_wh_1
       WHERE CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end) AS w ON IKM.client_id = w.client_id
     WHERE IKM.active_fg = 1) AS i2
   WHERE NOT EXISTS (SELECT 1
     FROM ldl_p_lew_core_ac.v_wawi_itm_item_consolidation_1 AS C2
     WHERE i2.client_id = client_id
      AND i2.item_sid = item_sid
      AND i2.wh_loc_sid = wh_loc_sid
      AND CURRENT_DATE BETWEEN dat_rec_start AND dat_rec_end)) AS i
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON i.client_id = WH.client_id AND i.wh_loc_sid = WH.loc_sid_wh AND WH.dwh_actual_fg
    = 1
 INNER JOIN (SELECT DISTINCT K.client_id,
   K.wh_id AS k_wh_id,
   K.store_id,
   TR.aspect_id,
   TR.wh_id AS tr_wh_id
  FROM ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS K
   INNER JOIN ldl_p_lew_mart_lead_ac.v_org_store_merge_1 AS TR ON K.client_id = TR.client_id AND K.store_id = TR.store_id
    AND TR.aspect_id IN (1, 2)
  WHERE K.test_store_fg = 0
   AND K.aspect_id = 1
   AND K.wh_id > 0
   AND TR.wh_id IS NOT NULL) AS whm ON i.client_id = whm.client_id AND WH.src_wh_id = whm.k_wh_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_act_1 AS A ON i.client_id = A.client_id AND i.item_sid = A.item_sid
 LEFT JOIN ldl_p_lew_core_ac.v_wawi_itm_consolidationgroup_1 AS CGP ON i.client_id = CGP.client_id AND i.wh_loc_sid = CGP
     .wh_loc_sid AND i.itm_consgrp_id = CGP.itm_consgrp_id AND CURRENT_DATE BETWEEN CGP.dat_rec_start AND CGP.dat_rec_end
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_orig_item_desc_act_1 AS OID ON i.client_id = OID.client_id AND A.orig_item_nr =
     OID.orig_item_nr AND A.dat_valid_from = OID.dat_valid_from AND i.client_id = OID.language_id;