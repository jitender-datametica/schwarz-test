

CREATE TABLE IF NOT EXISTS ldl_p_lew_mart_msi.v_mov_item_alloc_delivery AS
-- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2

-- in neuer STruktur nicht mehr vorhanden
 -- in neuer STruktur nicht mehr vorhanden

-- in neuer STruktur nicht mehr vorhanden

-- in neuer STruktur nicht mehr vorhanden, in alter Struktur ueberwiegend mit Wert 0
 -- Auflösung WH
 SELECT MOV.client_id
 ,
 MOV.item_sid AS item_id,
 MOV.dwh_cal_dt AS dat_formdate,
 MOV.receipt_id AS receipt_id_del,
 MOV.loc_sid_store AS store_id,
 SKEY.wh_id,
 MOV.vat_id,
 MOV.order_area_cd,
 MOV.dayend_dt AS dat_dayend,
 MOV.delivery_type_id AS deliverytype_id,
 MOV.dispo_unit_id,
 2 AS booking_fg,
 MOV.blocking_id AS blocking_cd,
 NULL AS dsac_nr,
 MOV.group_nr,
 MOV.print_nr,
 MOV.satas_nr,
 MOV.pricegroup_act_price_val AS pricegroup_act_price,
 MOV.stc_location_id,
 MOV.stc_slot_area_nr AS stc_slot_area,
 MOV.stc_slot_nr AS stc_slot_id,
 MOV.pallet_rate AS pallet_part,
 0 AS pallet_part_euro,
 0 AS pallet_part_tiko,
 MOV.comment_txt AS comment_del,
 MOV.prot_receipt_status_id AS status_prot_receipt,
 '0' AS status_dayend,
 MOV.dur_del_cnt AS dur_del,
  MOV.wh_del_net_price / CRY.rate_currency_exchange AS price_wh_del,
  MOV.wh_del_gross_price / CRY.rate_currency_exchange AS price_wh_net_del,
  MOV.store_del_net_price / CRY.rate_currency_exchange AS price_str_del,
  MOV.store_del_gross_price / CRY.rate_currency_exchange AS price_str_net_del,
 MOV.price_fg,
  MOV.wh_retail_net_price / CRY.rate_currency_exchange AS price_retail_wh,
  MOV.wh_retail_gross_price / CRY.rate_currency_exchange AS price_retail_wh_net,
 MOV.act_case_qty AS qty_case_act,
 MOV.del_case_qty AS qty_case_del,
 MOV.ordered_case_qty AS qty_case_order,
 MOV.del_piece_qty AS qty_piece_del,
 MOV.act_del_piece_qty AS qty_piece_act_del,
 CRY.currency_iso_cd,
 WH.src_wh_id AS wh_id_del
FROM ldl_p_lew_core_ac.v_item_delivery AS MOV
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse AS WH ON MOV.client_id = WH.client_id AND MOV.loc_sid_wh = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON MOV.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_mart_msi.v_org_store_skey AS SKEY ON MOV.client_id = SKEY.client_id AND MOV.loc_sid_store = SKEY.store_id
   
WHERE MOV.delivery_type_id = 1;


/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_item_delivery", "p_lew_bil_ac.v_warehouse", "p_lew_core_ac.v_wawi_ref_client_currency_rate", "p_lew_mart_msi.v_org_store_skey" ****/