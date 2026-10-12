CREATE OR REPLACE VIEW ldl_p_lew_mart_wfm.v_early_delivery_delta AS
/* 20.12.2016, Stephan Krone: Umstellung von COUNTRY_ID auf GLOBAL_LOC_COUNTRY_ID */ /* Nuh  NULL werte befüllen */
/* 20.12.2016, Stephan Krone: ORIG_STORE_NR aus X_CORE_VIEW.v_map_store_wh_core */
/* Nuh 13.02.2017  liefert alle werte */ /* Early Delivery */ /* Grundmenge */
/* Ermitteln der juengsten Stueckliste pro Artikel */ SELECT client_id,
 country_cd,
 wh_id,
 store,
 item,
 order_record,
 order_record_pos,
 uom_base,
 CAST(casesize_real AS NUMERIC) AS case_size_real,
 ROUND(CAST(order_ship_qty AS NUMERIC), 3) AS order_ship_qty,
 ROUND(CAST(qty_piece_del AS NUMERIC), 3) AS mov_ship_qty,
 order_dat,
 delivery_dat,
 mov_booking_dat,
 NULL AS load_id
FROM (SELECT ITM_MOV.client_id,
   LOC.global_loc_ctry_cd AS country_cd,
   ROUND(CAST(COALESCE(ITM.config_item_cd, ITM.src_matnr, ITM.src_orig_item_nr) AS BIGNUMERIC), 0) AS item,
   LOC.src_orig_store_nr AS store,
   ITM_MOV_POS.dwh_cal_dt AS mov_booking_dat,
   ST2WH.orig_wh_nr AS wh_id,
   ITM_MOV_POS.order_record_id AS order_record,
   ITM_MOV_POS.order_record_pos_id AS order_record_pos,
   COALESCE(ITM_MOV_POS.uom_cd_base, pinfo.uom_cd_base, ITM_HIST.uom_cd_base) AS uom_base,
   ORD_REC_POS_SPLIT.delivery_dt AS delivery_dat,
   MIN(CASE
     WHEN ITM_MOV_POS.capt_qty * COALESCE(ITM_BOM_POS_HIST.component_qty, 1) <> 0
     THEN ITM_MOV_POS.ship_qty * COALESCE(ITM_BOM_POS_HIST.component_qty, 1) / (ITM_MOV_POS.capt_qty * COALESCE(ITM_BOM_POS_HIST
         .component_qty, 1))
     ELSE 0
     END) AS casesize_real,
   SUM(UOM_ORD.conv_to_base_numerator / UOM_ORD.conv_to_base_denominator * ORD_REC_POS_SPLIT.order_split_qty) AS
   order_ship_qty,
   SUM(ITM_MOV_POS.ship_qty * COALESCE(ITM_BOM_POS_HIST.component_qty, 1)) AS qty_piece_del,
   MAX(ORD_REC.dwh_cal_dt) AS order_dat
  FROM ldl_p_lew_core_ac.v_item_movement_record AS ITM_MOV
   INNER JOIN ldl_p_lew_core_ac.v_item_movement_record_pos AS ITM_MOV_POS ON ITM_MOV.client_id = ITM_MOV_POS.client_id
       AND ITM_MOV.item_movement_record_year = ITM_MOV_POS.item_movement_record_year AND ITM_MOV.item_movement_record_id
        = ITM_MOV_POS.item_movement_record_id AND CAST(ITM_MOV_POS.storage_loc_cd AS INTEGER) IN (1000, 3000) AND
     ITM_MOV.event_type_cd = 'WE'
   INNER JOIN (SELECT client_id,
     loc_sid,
     dwh_cal_dt
    FROM ldl_p_lew_process_ac.v_wfm_export_core_delta AS DELTAVIEW
    WHERE process_name = 'export_wfm_early_delivery'
     AND process_specification = 'delta'
     AND core_table_name = 't_item_movement_record_pos'
     AND dwh_cal_dt BETWEEN DATE_SUB(CURRENT_DATE, INTERVAL 40 DAY) AND (DATE_SUB(CURRENT_DATE, INTERVAL 1 DAY))
    GROUP BY client_id,
     loc_sid,
     dwh_cal_dt) AS delta_itm_mov ON ITM_MOV_POS.client_id = delta_itm_mov.client_id AND ITM_MOV_POS.dwh_cal_dt =
      delta_itm_mov.dwh_cal_dt AND ITM_MOV_POS.loc_sid = delta_itm_mov.loc_sid
   INNER JOIN ldl_p_lew_core_ac.v_location AS LOC ON ITM_MOV_POS.client_id = LOC.client_id AND ITM_MOV_POS.loc_sid = LOC
      .loc_sid AND LOC.wh_store_mark = 'A'
   INNER JOIN ldl_p_lew_core_ac.v_order_record AS ORD_REC ON ITM_MOV_POS.client_id = ORD_REC.client_id AND ITM_MOV_POS.order_record_id
      = ORD_REC.order_record_id
   INNER JOIN ldl_p_lew_process_ac.v_wawi_sys_wfm_sap_map_sfo AS WFM_MAP ON ORD_REC.order_type_cd = WFM_MAP.order_type_cd
       AND ITM_MOV_POS.move_type_cd = WFM_MAP.mov_type_cd AND WFM_MAP.interface_name = 'StoreDelivery'
   INNER JOIN ldl_p_lew_core_ac.v_order_record_pos_split AS ORD_REC_POS_SPLIT ON ITM_MOV_POS.client_id =
       ORD_REC_POS_SPLIT.client_id AND ITM_MOV_POS.order_record_id = ORD_REC_POS_SPLIT.order_record_id AND ITM_MOV_POS.order_record_pos_id
       = ORD_REC_POS_SPLIT.order_record_pos_id AND ITM_MOV_POS.dwh_cal_dt < ORD_REC_POS_SPLIT.delivery_dt
     /* Buchungsdatum kleiner Lieferdatum */
   LEFT JOIN (SELECT client_id,
     item_sid,
     item_bom_sid
    FROM ldl_p_lew_core_ac.v_item_bom
    WHERE deleted_fg = 0
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING) ORDER BY active_from_dt_act IS NULL,
          active_from_dt_act)) = 1) AS itm_bom ON ITM_MOV_POS.client_id = itm_bom.client_id AND ITM_MOV_POS.item_sid =
     itm_bom.item_sid
   LEFT JOIN ldl_p_lew_core_ac.v_item_bom_pos_hist AS ITM_BOM_POS_HIST ON itm_bom.client_id = ITM_BOM_POS_HIST.client_id
       AND itm_bom.item_bom_sid = ITM_BOM_POS_HIST.item_bom_sid AND CURRENT_DATE BETWEEN ITM_BOM_POS_HIST.dwh_valid_from
     AND ITM_BOM_POS_HIST.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_item AS ITM ON ITM_MOV_POS.client_id = ITM.client_id AND COALESCE(ITM_BOM_POS_HIST.item_sid
      , ITM_MOV_POS.item_sid) = ITM.item_sid
   INNER JOIN ldl_p_lew_core_ac.v_item_hist AS ITM_HIST ON ITM.client_id = ITM_HIST.client_id AND ITM.item_sid =
      ITM_HIST.item_sid AND CURRENT_DATE BETWEEN ITM_HIST.dwh_valid_from AND ITM_HIST.dwh_valid_to
   LEFT JOIN (SELECT client_id,
     item_sid,
     uom_cd_base
    FROM ldl_p_lew_core_ac.v_pinfo_header_hist
    WHERE CURRENT_DATE BETWEEN dwh_valid_from AND dwh_valid_to
    QUALIFY (ROW_NUMBER() OVER (PARTITION BY CAST(item_sid AS STRING) ORDER BY deliverable_from_dt IS NULL,
          deliverable_from_dt)) = 1) AS pinfo ON ITM.client_id = pinfo.client_id AND ITM.item_sid = pinfo.item_sid
   INNER JOIN ldl_p_lew_bil_ac.v_store_to_warehouse AS ST2WH ON LOC.client_id = ST2WH.client_id AND LOC.loc_sid = ST2WH
      .loc_sid_store AND CURRENT_DATE BETWEEN ST2WH.dwh_valid_from AND ST2WH.dwh_valid_to
   INNER JOIN ldl_p_lew_core_ac.v_order_record_pos AS ORD_REC_POS ON ITM_MOV_POS.client_id = ORD_REC_POS.client_id AND
      ITM_MOV_POS.order_record_id = ORD_REC_POS.order_record_id AND ITM_MOV_POS.order_record_pos_id = ORD_REC_POS.order_record_pos_id
     
   INNER JOIN ldl_p_lew_core_ac.v_item_unit_of_measurement_hist AS UOM_ORD ON ORD_REC_POS.client_id = UOM_ORD.client_id
      AND ORD_REC_POS.item_sid = UOM_ORD.item_sid AND ORD_REC_POS.uom_sid = UOM_ORD.uom_sid AND CURRENT_DATE BETWEEN
     UOM_ORD.dwh_valid_from AND UOM_ORD.dwh_valid_to
  GROUP BY ITM_MOV.client_id,
   country_cd,
   item,
   store,
   mov_booking_dat,
   wh_id,
   order_record,
   order_record_pos,
   uom_base,
   delivery_dat) AS bb;