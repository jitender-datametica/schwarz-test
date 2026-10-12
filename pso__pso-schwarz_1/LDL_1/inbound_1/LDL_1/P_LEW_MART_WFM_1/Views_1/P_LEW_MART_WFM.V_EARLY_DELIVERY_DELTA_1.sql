CREATE OR REPLACE VIEW P_LEW_MART_WFM.V_EARLY_DELIVERY_DELTA_1
AS
   SELECT
      client_id
   ,country_cd
   ,wh_id
   ,store
   ,item_1
   ,ORDER_record
   ,ORDER_record_pos
   ,uom_base
   ,CAST (casesize_real AS   DECIMAL (15))   AS  case_size_real
   ,CAST (ORDER_ship_qty AS   DECIMAL (15,3))   AS  ORDER_ship_qty
   ,CAST (qty_piece_del AS   DECIMAL (15,3))   AS  mov_ship_qty
   ,ORDER_dat
   ,delivery_dat
   ,mov_booking_dat
   ,NULL AS load_id
FROM(
    SELECT
       client_id
   ,country_cd
   ,item_1
   ,store
   ,mov_booking_dat
   ,wh_id
   ,ORDER_record
   ,ORDER_record_pos
   ,uom_base
   ,delivery_dat
   ,MIN(casesize_real) AS casesize_real
   ,SUM (ORDER_ship_qty) AS ORDER_ship_qty
   ,SUM(qty_piece_del) AS qty_piece_del
   ,MAX (ORDER_dat)  AS  ORDER_dat

FROM(
     SELECT
          itm_mov.client_id AS client_id
   ,CASE WHEN (itm_mov_pos.capt_qty * (COALESCE(itm_bom_pos_hist.component_qty, 1))) <> 0
                      THEN (itm_mov_pos.ship_qty * (COALESCE(itm_bom_pos_hist.component_qty, 1)))
   /(itm_mov_pos.capt_qty * (COALESCE(itm_bom_pos_hist.component_qty, 1)))
ELSE 0
END AS casesize_real
   ,itm_mov_pos.ship_qty
   ,itm_bom_pos_hist.component_qty
   ,itm_mov_pos.capt_qty
   ,loc.global_loc_ctry_cd AS country_cd      /* 20.12.2016, Stephan Krone: Umstellung von COUNTRY_ID auf GLOBAL_LOC_COUNTRY_ID*/
   ,CAST(COALESCE (itm.config_item_cd,itm.src_matnr,itm.src_orig_item_nr) AS INTEGER)  AS item_1 /* Nuh  NULL werte befüllen*/
   ,loc.src_orig_store_nr AS store    /* 20.12.2016, Stephan Krone: ORIG_STORE_NR aus X_CORE_VIEW.v_map_store_wh_core*/
   ,itm_mov_pos.ship_qty * (COALESCE(itm_bom_pos_hist.component_qty, 1)) AS qty_piece_del
   ,itm_mov_pos.ship_qty * (COALESCE(itm_bom_pos_hist.component_qty, 1)) AS qty_piece_del_real
   ,itm_mov_pos.dwh_cal_dt AS mov_booking_dat
   ,st2wh.orig_wh_nr    AS wh_id
   ,ord_rec_pos_split.delivery_dt   AS  delivery_dat
   ,itm_mov_pos.ORDER_record_id AS ORDER_record
   ,itm_mov_pos.ORDER_record_pos_id AS ORDER_record_pos
   ,COALESCE (itm_mov_pos.uom_cd_base,pinfo.uom_cd_base,itm_hist.uom_cd_base) AS uom_base /*Nuh 13.02.2017  liefert alle werte*/
   ,(uom_ord.conv_to_base_numerator / uom_ord.conv_to_base_denominator)
   * ord_rec_pos_split.ORDER_split_qty AS ORDER_SHIP_QTY /* Early Delivery*/
   ,ord_rec.dwh_cal_dt    AS ORDER_dat

            /* Grundmenge */
            FROM
   p_lew_core_ac.v_item_movement_record_1 itm_mov
   INNER JOIN p_lew_core_ac.v_item_movement_record_pos_1 itm_mov_pos
   ON itm_mov.client_id = itm_mov_pos.client_id
   AND itm_mov.item_movement_record_year = itm_mov_pos.item_movement_record_year
   AND itm_mov.item_movement_record_id = itm_mov_pos.item_movement_record_id
   AND itm_mov_pos.storage_loc_cd IN (1000, 3000)
   AND itm_mov.event_type_cd='WE'
   INNER JOIN (
   SELECT
             deltaview.client_id
   ,deltaview.loc_sid
   ,deltaview.dwh_cal_dt
                      FROM p_lew_process_ac.v_wfm_export_core_delta_1 deltaview
   WHERE deltaview.process_name = 'export_wfm_early_delivery'
     AND deltaview.process_specification = 'delta'
     AND deltaview.core_table_name = 't_item_movement_record_pos_1'
     AND deltaview.dwh_cal_dt BETWEEN CURRENT_DATE - 40 AND CURRENT_DATE - 1
GROUP BY
         deltaview.client_id
        ,deltaview.loc_sid
        ,deltaview.dwh_cal_dt
) AS delta_itm_mov
   ON itm_mov_pos.client_id  = delta_itm_mov.client_id
   AND itm_mov_pos.dwh_cal_dt = delta_itm_mov.dwh_cal_dt
   AND itm_mov_pos.loc_sid    = delta_itm_mov.loc_sid
   INNER JOIN p_lew_core_ac.v_location_1 loc
   ON itm_mov_pos.client_id = loc.client_id
   AND itm_mov_pos.loc_sid = loc.loc_sid
   AND loc.wh_store_mark = 'A'
   INNER JOIN p_lew_core_ac.v_ORDER_record_1 ord_rec
   ON itm_mov_pos.client_id = ord_rec.client_id
   AND itm_mov_pos.ORDER_record_id = ord_rec.ORDER_record_id
   INNER JOIN p_lew_process_ac.v_wawi_sys_wfm_sap_map_sfo_1 wfm_map
   ON ord_rec.ORDER_type_cd = wfm_map.ORDER_type_cd
   AND itm_mov_pos.move_type_cd =   wfm_map.mov_type_cd
   AND wfm_map.interface_name = 'StoreDelivery'
   INNER JOIN p_lew_core_ac.v_ORDER_record_pos_split_1 ord_rec_pos_split
   ON itm_mov_pos.client_id = ord_rec_pos_split.client_id
   AND itm_mov_pos.ORDER_record_id = ord_rec_pos_split.ORDER_record_id
   AND itm_mov_pos.ORDER_record_pos_id = ord_rec_pos_split.ORDER_record_pos_id
   AND itm_mov_pos.dwh_cal_dt < ord_rec_pos_split.delivery_dt /*Buchungsdatum kleiner Lieferdatum*/
   LEFT OUTER JOIN
   (
   /* Ermitteln der juengsten Stueckliste_1 pro Artikel_1*/
   SELECT
    client_id
   ,item_sid
   ,item_bom_sid
              FROM p_lew_core_ac.v_item_bom_1
              WHERE deleted_fg = 0
              QUALIFY ROW_NUMBER() OVER(PARTITION BY item_sid ORDER BY active_from_dt_act DESC NULLS LAST) = 1
              ) itm_bom
   ON itm_mov_pos.client_id = itm_bom.client_id
   AND itm_mov_pos.item_sid = itm_bom.item_sid
   LEFT OUTER JOIN p_lew_core_ac.v_item_bom_pos_hist_1 itm_bom_pos_hist
   ON itm_bom.client_id = itm_bom_pos_hist.client_id
   AND itm_bom.item_bom_sid = itm_bom_pos_hist.item_bom_sid
   AND CURRENT_DATE BETWEEN itm_bom_pos_hist.dwh_valid_from AND itm_bom_pos_hist.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_item_1 itm
   ON itm_mov_pos.client_id = itm.client_id
   AND COALESCE(itm_bom_pos_hist.item_sid,itm_mov_pos.item_sid) = itm.item_sid
   INNER JOIN p_lew_core_ac.v_item_hist_1 itm_hist
   ON itm.client_id = itm_hist.client_id
   AND itm.item_sid = itm_hist.item_sid
   AND CURRENT_DATE BETWEEN itm_hist.dwh_valid_from AND itm_hist.dwh_valid_to
   LEFT OUTER JOIN
   (
   SELECT
      client_id
   ,item_sid
   ,uom_cd_base
               FROM p_lew_core_ac.v_pinfo_header_hist_1
               WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
               QUALIFY ROW_NUMBER() OVER(PARTITION BY item_sid ORDER BY deliverable_from_dt DESC NULLS LAST) = 1
               ) pinfo
   ON itm.client_id = pinfo.client_id
   AND itm.item_sid = pinfo.item_sid
   INNER JOIN p_lew_bil_ac.v_store_to_warehouse_1 st2wh
   ON loc.client_id = st2wh.client_id
   AND loc.loc_sid = st2wh.loc_sid_store
                                 AND CURRENT_DATE BETWEEN st2wh.dwh_valid_from AND st2wh.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_ORDER_record_pos_1 ord_rec_pos
   ON itm_mov_pos.client_id = ord_rec_pos.client_id
   AND itm_mov_pos.ORDER_record_id = ord_rec_pos.ORDER_record_id
   AND itm_mov_pos.ORDER_record_pos_id = ord_rec_pos.ORDER_record_pos_id
   INNER JOIN p_lew_core_ac.v_item_unit_of_measurement_hist_1 uom_ord
   ON ord_rec_pos.client_id = uom_ord.client_id
   AND ord_rec_pos.item_sid = uom_ord.item_sid
   AND ord_rec_pos.uom_sid = uom_ord.uom_sid
   AND CURRENT_DATE BETWEEN uom_ord.dwh_valid_from AND uom_ord.dwh_valid_to

) aa

GROUP BY client_id
,country_cd
,item_1
,store
,mov_booking_dat
,wh_id
,ORDER_record
,ORDER_record_pos
,uom_base
,delivery_dat
) bb
;