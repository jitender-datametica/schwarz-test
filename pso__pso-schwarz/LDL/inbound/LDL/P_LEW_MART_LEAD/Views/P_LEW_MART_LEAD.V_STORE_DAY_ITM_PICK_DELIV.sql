CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_STORE_DAY_ITM_PICK_DELIV
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
     src.client_id,
   src.loc_sid_store,
   src.orig_item_nr,
   src.wh_loc_sid,
   src.wh_id,
   src.dat_formdate,
   src.cy_month,
   src.cy_week,
   act.loc_sid_store_move_to AS loc_sid_store_move_to,
   act.aspect_id,
   src.picking_main_area_nr_pp,
   src.picking_main_area_desc_pp,
   SUM(src.qty_del_case) qty_del_case,
   SUM(src.order_cnt) order_cnt

  FROM
  (
  SELECT
    pck.client_id,
   pck.loc_sid_store,
   pck.orig_item_nr,
   pck.wh_loc_sid,
   loc.src_wh_id AS wh_id,
   pck.dat_formdate,
   pck.cy_month,
   pck.cy_week,
   (10*(slot.stc_location_nr_wamas/10))         AS picking_main_area_nr_pp,
   pp.picking_main_area_desc_pp                 AS picking_main_area_desc_pp,
   pck.qty_del_case,
   pck.order_cnt

  FROM p_lew_mart_lead.t_store_day_itm_pick_deliv pck
   INNER JOIN p_lew_core_ac.v_location loc
   ON pck.client_id   =loc.client_id
   AND pck.wh_loc_sid =loc.loc_sid
   AND wh_store_mark='B'
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_stc_slot_area slot
   ON  slot.client_id              = pck.client_id
   AND slot.wh_loc_sid             = pck.wh_loc_sid
   AND pck.stc_slot_id          BETWEEN slot.stc_slot_id_from AND slot.stc_slot_id_until
   AND slot.dat_rec_end ='9999-12-31'
   LEFT OUTER JOIN
   ( SELECT
         picking_main_area_nr_pp,
   picking_main_area_desc_pp
          FROM p_lew_bil_ac.v_itm_pp_picking_main_area pp
   GROUP BY 1,2
)pp
   ON  (10*(slot.stc_location_nr_wamas/10))= pp.picking_main_area_nr_pp

   WHERE  slot.stc_slot_send_cd   = 1

   QUALIFY RANK()
   OVER(PARTITION BY pck.client_id,pck.wh_loc_sid,pck.loc_sid_store,pck.orig_item_nr,pck.stc_slot_id
   ORDER BY slot.dat_rec_start DESC NULLS LAST)=1

   ) src
   LEFT OUTER JOIN p_lew_bil_ac.v_org_store_merge act
   ON act.client_id      = src.client_id
   AND act.loc_sid_store    = src.loc_sid_store
   AND act.aspect_id  = 1

   GROUP BY 1,2,3,4,5,6,7,8,9,10,11,12
;