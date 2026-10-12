CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_store_day_itm_pick_deliv (client_id, loc_sid_store, orig_item_nr,
wh_loc_sid, wh_id, dat_formdate, cy_month, cy_week, loc_sid_store_move_to, aspect_id, picking_main_area_nr_pp,
picking_main_area_desc_pp, qty_del_case, order_cnt) AS SELECT src.client_id,
 src.loc_sid_store,
 src.orig_item_nr,
 src.wh_loc_sid,
 src.wh_id,
 src.dat_formdate,
 src.cy_month,
 src.cy_week,
 ACT.loc_sid_store_move_to,
 ACT.aspect_id,
 src.picking_main_area_nr_pp,
 src.picking_main_area_desc_pp,
 SUM(src.qty_del_case) AS qty_del_case,
 SUM(src.order_cnt) AS order_cnt
FROM (SELECT PCK.client_id,
   PCK.loc_sid_store,
   PCK.orig_item_nr,
   PCK.wh_loc_sid,
   LOC.src_wh_id AS wh_id,
   PCK.dat_formdate,
   PCK.cy_month,
   PCK.cy_week,
    10 * (SLOT.stc_location_nr_wamas / 10) AS picking_main_area_nr_pp,
   pp.picking_main_area_desc_pp,
   PCK.qty_del_case,
   PCK.order_cnt
  FROM ldl_p_lew_mart_lead.t_store_day_itm_pick_deliv AS PCK
   INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON PCK.client_id = LOC.client_id AND PCK.wh_loc_sid = LOC.loc_sid AND
     LOC.wh_store_mark = 'B'
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_stc_slot_area AS SLOT ON PCK.client_id = SLOT.client_id AND PCK.wh_loc_sid = SLOT
       .wh_loc_sid AND PCK.stc_slot_id BETWEEN SLOT.stc_slot_id_from AND SLOT.stc_slot_id_until AND SLOT.dat_rec_end =
     DATE '9999-12-31'
   LEFT JOIN (SELECT picking_main_area_nr_pp,
     picking_main_area_desc_pp
    FROM ldl_p_lew_bil_ac.v_itm_pp_picking_main_area AS PP
    GROUP BY picking_main_area_nr_pp,
     picking_main_area_desc_pp) AS pp ON 10 * (SLOT.stc_location_nr_wamas / 10) = pp.picking_main_area_nr_pp
  WHERE SLOT.stc_slot_send_cd = 1
  QUALIFY (RANK() OVER (PARTITION BY CAST(PCK.client_id AS STRING), CAST(PCK.wh_loc_sid AS STRING), CAST(PCK.loc_sid_store AS STRING)
        , PCK.orig_item_nr, CAST(PCK.stc_slot_id AS STRING) ORDER BY SLOT.dat_rec_start IS NULL, SLOT.dat_rec_start)) =
    1) AS src
 LEFT JOIN ldl_p_lew_bil_ac.v_org_store_merge AS ACT ON src.client_id = ACT.client_id AND src.loc_sid_store = ACT.loc_sid_store
     AND ACT.aspect_id = 1
GROUP BY src.client_id,
 src.loc_sid_store,
 src.orig_item_nr,
 src.wh_loc_sid,
 src.wh_id,
 src.dat_formdate,
 src.cy_month,
 src.cy_week,
 ACT.loc_sid_store_move_to,
 ACT.aspect_id,
 src.picking_main_area_nr_pp,
 src.picking_main_area_desc_pp;