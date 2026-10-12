/* #DescStart#
#$Revision: 13400 $, $LastChangedBy: umeister $
#SubjectAreas#: Anliefermenge
#DescEnd# */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_mov_item_wh_delivery_2 AS
-- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2

-- in neuer STruktur nicht mehr vorhanden
 -- in neuer STruktur nicht mehr vorhanden

-- in neuer STruktur nicht mehr vorhanden

-- in neuer STruktur nicht mehr vorhanden, in alter Struktur ueberwiegend mit Wert 0

-- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2

-- in neuer STruktur nicht mehr vorhanden

-- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert NULL

-- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2
 -- WH AuflÃ¶sung
 SELECT mov.client_id,
 mov.item_sid AS item_id,
 mov.dat_formdate,
 mov.receipt_id_del,
 WH.src_wh_id AS wh_id,
 mov.vat_id,
 mov.order_area_cd,
 mov.dat_dayend,
 mov.deliverytype_id,
 mov.dispo_unit_id,
 mov.booking_fg,
 mov.blocking_cd,
 mov.dsac_nr,
 mov.group_nr,
 mov.print_nr,
 mov.satas_nr,
 mov.pricegroup_act_price,
 mov.stc_location_id,
 mov.stc_slot_area,
 mov.stc_slot_id,
 mov.pallet_part,
 mov.pallet_part_euro,
 mov.pallet_part_tiko,
 mov.comment_del,
 mov.status_prot_receipt,
 mov.status_dayend,
 mov.dur_del,
  mov.price_wh_del / CRY.rate_currency_exchange AS price_wh_del,
  mov.price_wh_net_del / CRY.rate_currency_exchange AS price_wh_net_del,
  mov.price_str_del / CRY.rate_currency_exchange AS price_str_del,
  mov.price_str_net_del / CRY.rate_currency_exchange AS price_str_net_del,
 mov.price_fg,
  mov.price_retail_wh / CRY.rate_currency_exchange AS price_retail_wh,
  mov.wh_retail_gross_price / CRY.rate_currency_exchange AS price_retail_wh_net,
 mov.qty_case_act,
 mov.qty_case_del,
 mov.qty_case_order,
 mov.qty_piece_del,
 mov.qty_piece_act_del,
 ITM.case_size,
 CRY.currency_iso_cd,
 ITEM_WH.case_size_dec AS wh_case_size_dec,
 ITEM_WH.case_factor_dd AS wh_case_factor_dd,
 ITEM_WH.case_factor_euro AS wh_case_factor_euro,
 ITEM_SLOT.inv_case_fg,
 ITEM_SLOT.inv_dd_fg,
 ITEM_SLOT.inv_euro_fg
FROM (SELECT client_id,
    item_sid,
    dwh_cal_dt AS dat_formdate,
    ROUND(CAST(receipt_id AS BIGNUMERIC), 0) AS receipt_id_del,
    vat_id,
    order_area_cd,
    dayend_dt AS dat_dayend,
    delivery_type_id AS deliverytype_id,
    dispo_unit_id,
    2 AS booking_fg,
    blocking_id AS blocking_cd,
    NULL AS dsac_nr,
    CAST(group_nr AS NUMERIC) AS group_nr,
    print_nr,
    satas_nr,
    pricegroup_act_price_val AS pricegroup_act_price,
    stc_location_id,
    stc_slot_area_nr AS stc_slot_area,
    stc_slot_nr AS stc_slot_id,
    pallet_rate AS pallet_part,
    0 AS pallet_part_euro,
    0 AS pallet_part_tiko,
    comment_txt AS comment_del,
    prot_receipt_status_id AS status_prot_receipt,
    '0' AS status_dayend,
    dur_del_cnt AS dur_del,
    wh_del_net_price AS price_wh_del,
    wh_del_gross_price AS price_wh_net_del,
    store_del_net_price AS price_str_del,
    store_del_gross_price AS price_str_net_del,
    price_fg,
    wh_retail_net_price AS price_retail_wh,
    wh_retail_gross_price,
    act_case_qty AS qty_case_act,
    del_case_qty AS qty_case_del,
    ordered_case_qty AS qty_case_order,
    del_piece_qty AS qty_piece_del,
    act_del_piece_qty AS qty_piece_act_del,
    loc_sid_wh AS wh_loc_sid
   FROM ldl_p_lew_core_ac.v_item_delivery_2 AS MOV
   WHERE delivery_type_id IN (1, 2) /* AND mov.delivery_type_id NOT IN (3,4) */
    /* AND mov.delivery_type_id NOT IN (3,4) */
   UNION ALL
   SELECT client_id,
    item_sid,
    dwh_cal_dt AS dat_formdate,
    fv_del_id,
    vat_id,
    order_area_cd,
    dayend_dt AS dat_dayend,
    4,
    - 1,
    2 AS booking_fg,
    - 1,
    NULL AS dsac_nr,
    - 1,
    - 1,
    CAST(NULL AS BIGNUMERIC) AS satas_nr,
    price_grp_id_store AS pricegroup_store,
    layer_order_nr,
    - 1,
    slot_nr,
    - 1,
    - 1,
    - 1,
    '',
    - 1,
    '2' AS status_dayend,
    dur_del_cnt AS dur_fv_del,
    wh_net_price AS price_wh_fv,
    wh_gross_price AS price_wh_net_fv,
    store_net_price AS price_str_fv,
    store_gross_price AS price_str_net_fv,
    - 1,
    old_retail_net_price AS price_retail_fv_del_old,
    old_retail_gross_price AS price_retail_net_fv_del_old,
    CAST(NULL AS NUMERIC),
    case_qty AS qty_case_fv_del,
    CAST(NULL AS NUMERIC),
    CAST(NULL AS NUMERIC),
    CAST(NULL AS NUMERIC),
    loc_sid_wh AS wh_loc_sid
   FROM ldl_p_lew_core_ac.v_item_fruits_vegetables_delivery_2 AS MOV) AS mov
 INNER JOIN ldl_p_lew_bil_ac.v_warehouse_2 AS WH ON mov.client_id = WH.client_id AND mov.wh_loc_sid = WH.loc_sid_wh AND WH
   .dwh_actual_fg = 1
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS CRY ON mov.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end
 INNER JOIN ldl_p_lew_mart_msi.v_itm_item_skey_2 AS ITM ON mov.client_id = ITM.client_id AND mov.item_sid = ITM.item_id
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_item_wh_2 AS ITEM_WH ON mov.client_id = ITEM_WH.client_id AND mov.wh_loc_sid =
     ITEM_WH.wh_loc_sid AND mov.item_sid = ITEM_WH.item_sid AND mov.dat_formdate BETWEEN ITEM_WH.dat_rec_start AND
   ITEM_WH.dat_rec_end
 INNER JOIN ldl_p_lew_core_ac.v_wawi_itm_wh_slot_2 AS ITEM_SLOT ON mov.client_id = ITEM_SLOT.client_id AND mov.wh_loc_sid
     = ITEM_SLOT.wh_loc_sid AND mov.item_sid = ITEM_SLOT.item_sid AND mov.dat_formdate BETWEEN ITEM_SLOT.dat_rec_start
   AND ITEM_SLOT.dat_rec_end;


/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_item_delivery_2", "p_lew_bil_ac.v_warehouse_2", "p_lew_core_ac.v_item_fruits_vegetables_delivery_2" ****/