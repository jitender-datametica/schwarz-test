
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_MOV_ITEM_RECEIVE_WH_NEU 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /* eLWIS-Daten */ 
   SELECT lir.client_id,   
   loc_wh.src_wh_id AS wh_id, 
   lir.item_sid AS item_id,   
   lir.dwh_cal_dt AS formdate_dat,  
   CAST(NULL AS VARCHAR(5)) AS customer_nr,  
   CAST(lir.location_item_receipt_id AS DECIMAL(15,0)) AS rcv_receipt_id,  
   CAST(lir.location_item_receipt_pos_id AS SMALLINT) AS rcv_receipt_pos_nr,  
   dmy_rcv_ids.receivetype_id AS receivetype_id,   
   CAST(NULL AS SMALLINT) AS currency_nr, 
   CAST(NULL AS DATE) AS dayend_dat,   
   lir.dwh_cal_dt AS rcv_entry_dat, 
   CAST(NULL AS DATE) AS rcv_adjustment_dat, 
   CAST(NULL AS DATE) AS rcv_min_durability_dat,   
   CAST(NULL AS DATE) AS rcv_pos_valid_start_dat,  
   CAST(NULL AS DATE) AS  rcv_pos_valid_end_dat,   
   lir.sup_sid AS supplier_id,   
   CAST(NULL AS INTEGER) AS supplier_pay_id, 
   CAST(NULL AS DECIMAL(15,0)) AS mapping_pos_nr,  
   CAST(NULL AS VARCHAR(60)) AS rcv_orig_receipt_id,  
   CAST(NULL AS SMALLINT) AS receipt_pos_part_delivery_fg,  
   CAST(NULL AS SMALLINT) AS receipt_pos_matchable_fg,   
   1 AS receipt_pos_marginrel_fg,   
   99 AS status_tg,  
   CAST(NULL AS INTEGER) AS vat_id, 
   CAST(NULL AS DECIMAL(18,4)) AS rcv_vat_pct,  
   CAST(NULL AS INTEGER) AS rcv_tax_id,   
   CAST(NULL AS INTEGER) AS stock_location_id,  
   lir.receive_cASe_qty AS rcv_cASe_qty,  
   CAST(NULL AS DECIMAL(18,4)) AS rcv_piece_qty,   
   lir.receive_piece_qty AS rcv_total_qty,   
   CAST(NULL AS DECIMAL(18,4)) AS rcv_price_buying_val,  
   CAST(NULL AS DECIMAL(18,4)) AS price_buying_euro_val, 
   CAST(NULL AS DECIMAL(18,4)) AS rcv_price_retail_val,  
   CAST(NULL AS DECIMAL(19,5)) AS rcv_price_retail_net_val, 
   CASE  
   WHEN dmy_rcv_ids.receivetype_id = 1 THEN lir.pur_development_net_val 
   WHEN dmy_rcv_ids.receivetype_id = 4 THEN lir.carrier_costs_val - lir.refunds_val 
   WHEN dmy_rcv_ids.receivetype_id = 5 THEN lir.tax_val + lir.environmental_levies_val + lir.customs_val 
END / erkh.exchange_rate AS rcv_buying_val,  
   CAST(NULL AS DECIMAL(18,4)) AS rcv_buying_suppl_val,  
   CAST(NULL AS DECIMAL(18,4)) AS buying_euro_val, 
   CASE  
   WHEN dmy_rcv_ids.receivetype_id = 1 THEN lir.sales_gross_val   
   ELSE CAST(NULL AS DECIMAL(18,4)) 
END / erkh.exchange_rate AS rcv_retail_val,  
   CASE  
   WHEN dmy_rcv_ids.receivetype_id = 1 THEN lir.sales_net_val  
   ELSE CAST(NULL AS DECIMAL(18,4)) 
END / erkh.exchange_rate AS rcv_retail_net_val, 
   CAST(NULL AS DECIMAL(18,4)) AS rcv_deposit_val, 
   CAST(NULL AS DECIMAL(9,4)) AS cASe_size_dec, 
   CAST(NULL AS INTEGER) AS package_qty,  
   CAST(NULL AS DECIMAL(18,4)) AS rcv_buying_fa_val,  
   CAST (NULL AS DECIMAL(18,4)) AS rcv_retail_fa_net_val,   
   erkh.curr_cd_FROM AS currency_iso_cd   
  FROM ( 
      SELECT client_id, 
   location_item_receipt_year,   
   location_item_receipt_id,  
   location_item_receipt_pos_id, 
   curr_cd_receipt,  
   MAX(loc_sid_wh) AS loc_sid_wh,   
   MAX(item_sid) AS item_sid, 
   MAX(dwh_cal_dt) AS dwh_cal_dt,   
   MAX(sup_sid) AS sup_sid,   
   SUM(receive_cASe_qty) AS receive_cASe_qty,   
   SUM(receive_piece_qty) AS receive_piece_qty, 
   SUM(pur_development_net_val) AS pur_development_net_val, 
   SUM(carrier_costs_val) AS carrier_costs_val, 
   SUM(refunds_val) AS refunds_val, 
   SUM(tax_val) AS tax_val,   
   SUM(environmental_levies_val) AS environmental_levies_val,  
   SUM(customs_val) AS customs_val, 
   SUM(sales_gross_val) AS sales_gross_val,  
   SUM(sales_net_val) AS sales_net_val 
      FROM p_lew_core_ac.v_location_item_receipt   
      /* Nur Daten der letzten 40 Monate anzeigen */  
      WHERE dwh_cal_dt > ADD_MONTHS(CURRENT_DATE, -40)   
      GROUP BY client_id   
          , location_item_receipt_year 
          , location_item_receipt_id   
          , location_item_receipt_pos_id  
          /* , bw_cntr */  
          , curr_cd_receipt   
  ) AS lir  
   INNER JOIN p_lew_core_ac.v_location AS loc_wh   
   ON lir.client_id = loc_wh.client_id 
   AND lir.loc_sid_wh = loc_wh.loc_sid 
   AND UPPER(loc_wh.wh_store_mark) = 'B' --> WHs   
   
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS erkh 
   ON lir.client_id = erkh.client_id   
   AND CURRENT_DATE BETWEEN erkh.active_FROM_dt AND erkh.active_to_dt   
   AND CURRENT_DATE BETWEEN erkh.dwh_valid_FROM AND erkh.dwh_valid_to   
   AND erkh.curr_cd_FROM = erkh.curr_cd_to   
   INNER JOIN p_lew_core_ac.v_exchange_rate_type AS ert  
   ON erkh.client_id = ert.client_id   
   AND erkh.x_rate_type_sid = ert.x_rate_type_sid  
   AND ert.src_kurst = '@BEWE'   
   CROSS JOIN (   
   SELECT * FROM (SELECT CAST(1 AS INTEGER) AS receivetype_id) AS eins  
   UNION ALL   
   SELECT * FROM (SELECT CAST(4 AS INTEGER) AS receivetype_id) AS vier  
   UNION ALL   
   SELECT * FROM (SELECT CAST(5 AS INTEGER) AS receivetype_id) AS fuenf 
) AS dmy_rcv_ids  
   INNER JOIN p_lew_bil_ac.v_item AS item 
   ON lir.client_id = item.client_id   
   AND lir.item_sid = item.item_sid 
   AND item.dwh_actual_fg = 1 
   LEFT OUTER JOIN p_lew_bil_ac.v_itemgroup_international AS itin 
   ON item.client_id = itin.client_id  
   AND item.item_grp_int_sid_ASis = itin.item_grp_int_sid   
UNION ALL   
/* WAWI-Daten */  
SELECT rcv.client_id,   
   loc_wh.src_wh_id AS wh_id, 
   rcv.item_sid,  
   rcv.dat_formdate, 
   rcv.customer_nr,  
   rcv.receipt_id_rcv,  
   rcv.receipt_pos_nr_rcv, 
   rcv.receipttype_id AS receivetype_id,  
   rcv.currency_id AS currency_nr,  
   rcv.dat_dayend,   
   rcv.dat_entry_rcv,   
   rcv.dat_adjustment_rcv, 
   rcv.dat_min_durability_rcv,   
   rcv.dat_valid_FROM AS dat_rcv_pos_valid_start,  
   rcv.dat_valid_until AS dat_rcv_pos_valid_end,   
   rcv.sup_sid,   
   rcv.sup_sid_pay,  
   rcv.mapping_pos_nr,  
   rcv.orig_receipt_id_rcv,   
   rcv.receipt_pos_partdel_fg AS receipt_pos_part_delivery_fg, 
   rcv.receipt_pos_matchable_rel_fg AS receipt_pos_matchable_fg,  
   rcv.receipt_pos_margin_rel_fg AS receipt_pos_marginrel_fg,  
   rcv.status_tg, 
   rcv.vat_id, 
   rcv.pct_vat_rcv,  
   rcv.item_category_id AS tax_id_rcv, 
   rcv.stock_location_nr AS stock_location_id,  
   rcv.qty_cASe_rcv, 
   rcv.qty_piece_rcv,   
   rcv.qty_total_rcv,   
   rcv.price_buying_rcv / erkh.exchange_rate AS price_buying_rcv, 
   rcv.price_buying_euro_rcv AS price_buying_euro, 
   rcv.price_retail_rcv / erkh.exchange_rate AS price_retail_rcv, 
   rcv.price_retail_net_rcv /erkh.exchange_rate AS price_retail_net_rcv,   
   rcv.val_buying_rcv / erkh.exchange_rate AS val_buying_rcv,  
   rcv.val_buying_sup_rcv AS val_buying_suppl_rcv, 
   rcv.val_buying_euro AS val_buying_euro,   
   rcv.val_retail_rcv / erkh.exchange_rate AS val_retail_rcv,  
   rcv.val_net_retail_rcv / erkh.exchange_rate AS val_net_retail_rcv,   
   rcv.val_deposit_rcv / erkh.exchange_rate AS val_deposit_rcv,   
   rcv.cASe_size_dec,   
   rcv.package_qty,  
   CASE  
          WHEN fa.client_id IS NOT NULL THEN rcv.val_buying_rcv / erkh.exchange_rate   
   ELSE NULL   
END AS val_buying_fa_rcv,  
   CASE WHEN fa.client_id IS NOT NULL THEN rcv.val_net_retail_rcv / erkh.exchange_rate 
   ELSE NULL   
END AS val_net_retail_fa_rcv, 
   erkh.curr_cd_FROM AS currency_iso_cd   
  FROM p_lew_core_ac.v_wawi_mov_item_wh_receiving AS rcv 
   INNER JOIN p_lew_core_ac.v_location AS loc_wh   
   ON rcv.client_id = loc_wh.client_id 
   AND rcv.wh_loc_sid = loc_wh.loc_sid 
   AND UPPER(loc_wh.wh_store_mark) = 'B' --> WHs   
   
   INNER JOIN p_lew_core_ac.v_exchange_rate_known_hist AS erkh 
   ON rcv.client_id = erkh.client_id   
   AND CURRENT_DATE BETWEEN erkh.active_FROM_dt AND erkh.active_to_dt   
   AND CURRENT_DATE BETWEEN erkh.dwh_valid_FROM AND erkh.dwh_valid_to   
   AND erkh.curr_cd_FROM = erkh.curr_cd_to   
   INNER JOIN p_lew_core_ac.v_exchange_rate_type AS ert  
   ON erkh.client_id = ert.client_id   
   AND erkh.x_rate_type_sid = ert.x_rate_type_sid  
   AND ert.src_kurst = '@BEWE'   
   LEFT OUTER JOIN p_lew_core_ac.v_wawi_itm_item_foodaction_ASws_act AS fa 
   ON  rcv.client_id = fa.client_id 
   AND rcv.item_sid = fa.item_sid   
   AND rcv.dat_entry_rcv = fa.dat_valid   
/* Nur Daten der letzten 40 Monate anzeigen */  
WHERE rcv.dat_entry_rcv > ADD_MONTHS(CURRENT_DATE, -40)  
;
