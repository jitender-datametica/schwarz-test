CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_lead.v_agg_store_day_pick_deliv_1
OPTIONS(max_staleness = INTERVAL 90 MINUTE,allow_non_incremental_definition = true) AS
-- Auflösung WH
 SELECT src.client_id,
 src.loc_sid_store_move_to,
 src.wh_loc_sid,
 src.wh_id,
 src.aspect_id,
 src.crossdocking_fg,
 src.dat_formdate,
 src.cy_month,
 src.cy_week,
 src.picking_main_area_nr_pp,
 src.picking_main_area_desc_pp,
 src.picking_area_nr_pp,
 src.picking_area_desc_pp,
 CUR.curr_tot_id,
 CUR.currency_iso_cd,
 SUM(src.qty_ord_case) AS qty_ord_case,
 SUM(src.qty_del_case) AS qty_del_case,
 SUM(src.foreign_store_case) AS foreign_store_case,
 SUM(src.order_cnt) AS order_cnt
FROM (SELECT PCK.client_id,
   PCK.loc_sid_store_move_to,
   PCK.wh_loc_sid,
   IF(PCK.wh_id <> ACT.wh_id, PCK.wh_id, ACT.wh_id) AS wh_id,
   PCK.aspect_id,
   IF(PCK.wh_id <> ACT.wh_id, 1, 0) AS crossdocking_fg,
   PCK.dat_formdate,
   PCK.cy_month,
   PCK.cy_week,
    10 * TRUNC(CAST(SLOT.stc_location_nr_wamas / 10 AS BIGNUMERIC)) AS picking_main_area_nr_pp,
   pp.picking_main_area_desc_pp,
   IFNULL(area.picking_area_nr_pp, 0) AS picking_area_nr_pp,
   IFNULL(area.picking_area_desc_pp, 'DummY_1') AS picking_area_desc_pp,
   PCK.qty_ord_case,
   PCK.qty_del_case,
     CASE
     WHEN IF(PCK.wh_id <> ACT.wh_id, 1, 0) = 1
     THEN IFNULL(PCK.qty_del_case, 0)
     ELSE 0
     END + CASE
     WHEN IF(PCK.wh_id <> ACT.wh_id, 1, 0) = 1
     THEN IFNULL(PCK.qty_ord_case, 0)
     ELSE 0
     END AS foreign_store_case,
   PCK.order_cnt
  FROM ldl_p_lew_mart_lead.t_agg_store_day_pick_deliv_1 AS PCK
   LEFT JOIN ldl_p_lew_bil_ac.v_org_all_store_merge_1 AS ACT ON PCK.client_id = ACT.client_id AND PCK.loc_sid_store_move_to
       = ACT.move_to_store_id AND PCK.aspect_id = ACT.aspect_id
   LEFT JOIN ldl_p_lew_core_ac.v_wawi_stc_slot_area_1 AS SLOT ON PCK.client_id = SLOT.client_id AND PCK.wh_loc_sid = SLOT
       .wh_loc_sid AND PCK.stc_slot_id BETWEEN SLOT.stc_slot_id_from AND SLOT.stc_slot_id_until AND SLOT.dat_rec_end =
     DATE '9999-12-31'
   LEFT JOIN (SELECT picking_main_area_nr_pp,
     picking_main_area_desc_pp
    FROM ldl_p_lew_bil_ac.v_itm_pp_picking_main_area_1 AS PP
    GROUP BY picking_main_area_nr_pp,
     picking_main_area_desc_pp) AS pp ON 10 * TRUNC(CAST(SLOT.stc_location_nr_wamas / 10 AS BIGNUMERIC)) = pp.picking_main_area_nr_pp
    
   LEFT JOIN (SELECT PA.client_id,
     PA.client_id AS language_id,
     PA.pick_area_descr AS picking_area_desc_pp,
     PA.pick_area_id AS picking_area_nr_pp,
     WH.src_wh_id AS wh_id_pp
    FROM ldl_p_lew_core_ac.v_ref_pick_area_descr_1 AS PA
     INNER JOIN ldl_p_lew_bil_ac.v_warehouse_1 AS WH ON PA.client_id = WH.client_id AND PA.loc_sid = WH.loc_sid_wh AND WH
       .dwh_actual_fg = 1 -- außer Stiftungssprache

    WHERE PA.lang_sid <> 2) AS area ON PCK.client_id = area.client_id AND PCK.wh_id = area.wh_id_pp AND SLOT.stc_location_nr_wamas
     -- WHERE  slot.STC_SLOT_SEND_CD   = 1 /*indicate picking areas that have been sent to WAMAS
 = area.picking_area_nr_pp
     
  QUALIFY (RANK() OVER (PARTITION BY PCK.client_id, PCK.wh_loc_sid, PCK.wh_id, PCK.loc_sid_store_move_to, PCK.stc_slot_id
        ORDER BY SLOT.dat_rec_start NULLS LAST)) = 1) AS src
 INNER JOIN ldl_p_lew_mart_lead.v_ref_currency_1 AS CUR ON src.client_id = CUR.client_id
GROUP BY src.client_id,
 src.loc_sid_store_move_to,
 src.wh_loc_sid,
 src.wh_id,
 src.aspect_id,
 src.crossdocking_fg,
 src.dat_formdate,
 src.cy_month,
 src.cy_week,
 src.picking_main_area_nr_pp,
 src.picking_main_area_desc_pp,
 src.picking_area_nr_pp,
 src.picking_area_desc_pp,
 CUR.curr_tot_id,
 CUR.currency_iso_cd;