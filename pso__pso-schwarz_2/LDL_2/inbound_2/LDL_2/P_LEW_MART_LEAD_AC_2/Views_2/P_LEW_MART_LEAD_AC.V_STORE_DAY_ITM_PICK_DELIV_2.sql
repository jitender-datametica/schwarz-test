CREATE OR REPLACE VIEW P_LEW_MART_LEAD_AC.V_STORE_DAY_ITM_PICK_DELIV_2
 /*
 #DescStart#
 #$Revision: 7858 $, $LastChangedBy: ykarkouda $
 #SubjectAreas#: Access Layer
 #DescEnd#
 */
(
 client_id
,loc_sid_store
,orig_item_nr
,wh_loc_sid
,wh_id
,dat_formdate
,cy_month
,cy_week
,loc_sid_store_move_to
,aspect_id
,picking_main_area_nr_pp
,picking_main_area_desc_pp
,qty_del_case
,order_cnt
)
AS
   SELECT
    client_id,
   loc_sid_store,
   orig_item_nr,
   wh_loc_sid,
   wh_id,
   dat_formdate,
   cy_month,
   cy_week,
   loc_sid_store_move_to,
   aspect_id,
   picking_main_area_nr_pp,
   picking_main_area_desc_pp,
   qty_del_case,
   order_cnt
   FROM p_lew_mart_lead.v_store_day_itm_pick_deliv_2
;