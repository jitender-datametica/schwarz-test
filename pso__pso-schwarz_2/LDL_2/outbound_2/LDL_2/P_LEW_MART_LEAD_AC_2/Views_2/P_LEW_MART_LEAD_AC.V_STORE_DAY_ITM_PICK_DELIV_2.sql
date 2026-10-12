/* #DescStart#
 #$Revision: 7858 $, $LastChangedBy: ykarkouda $
 #SubjectAreas#: Access Layer
 #DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_lead_ac.v_store_day_itm_pick_deliv_2 (client_id, loc_sid_store, orig_item_nr,
wh_loc_sid, wh_id, dat_formdate, cy_month, cy_week, loc_sid_store_move_to, aspect_id, picking_main_area_nr_pp,
picking_main_area_desc_pp, qty_del_case, order_cnt) AS SELECT *
FROM ldl_p_lew_mart_lead.v_store_day_itm_pick_deliv_2;