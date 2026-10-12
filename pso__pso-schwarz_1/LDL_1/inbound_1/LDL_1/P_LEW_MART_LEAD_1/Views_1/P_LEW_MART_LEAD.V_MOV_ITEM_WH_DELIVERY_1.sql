CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_MOV_ITEM_WH_DELIVERY_1
AS
/*
#DescStart#
#$Revision: 13413 $, $LastChangedBy: umeister $
#SubjectAreas#: Anliefermenge
#DescEnd#
*/
SELECT
mov.client_id,
mov.item_sid AS item_id,
mov.dat_formdate,
mov.receipt_id_del,
wh.src_wh_id AS wh_id,
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
mov. pallet_part,
mov.pallet_part_euro,
mov.pallet_part_tiko,
mov.comment_del,
mov.status_prot_receipt,
mov.status_dayend,
mov.dur_del,
mov.price_wh_del / cry.rate_currency_exchange                                                        AS price_wh_del,
mov.price_wh_net_del / cry.rate_currency_exchange                                                    AS price_wh_net_del,
mov.price_str_del / cry.rate_currency_exchange                                                      AS price_str_del,
mov.price_str_net_del / cry.rate_currency_exchange                                                   AS price_str_net_del,
mov.price_fg,
mov.price_retail_wh / cry.rate_currency_exchange                                                     AS price_retail_wh,
mov.wh_retail_gross_price / cry.rate_currency_exchange                                               AS price_retail_wh_net,
mov.qty_case_act,
mov.qty_case_del,
mov.qty_case_order,
mov.qty_piece_del,
mov.qty_piece_act_del,
itm.case_size,
cry.currency_iso_cd,
item_wh.case_size_dec AS wh_case_size_dec,
item_wh.case_factor_dd AS wh_case_factor_dd,
item_wh.case_factor_euro AS wh_case_factor_euro,
item_slot.inv_case_fg,
item_slot.inv_dd_fg,
item_slot.inv_euro_fg
FROM (SELECT
mov.client_id,
mov.item_sid,
mov.dwh_cal_dt AS dat_formdate,
Cast(mov.receipt_id AS DECIMAL(15,0)) AS receipt_id_del,
mov.vat_id,
mov.order_area_cd,
mov.dayend_dt AS dat_dayend,
mov.delivery_type_id AS deliverytype_id,
mov.dispo_unit_id,
2 AS booking_fg -- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2
,
mov.blocking_id AS blocking_cd,
NULL AS dsac_nr -- in neuer STruktur nicht mehr vorhanden
,
Cast(mov.group_nr AS DECIMAL(15)) AS group_nr,
mov.print_nr,
mov.satas_nr,
mov.pricegroup_act_price_val AS pricegroup_act_price,
mov.stc_location_id,
mov.stc_slot_area_nr AS stc_slot_area,
mov.stc_slot_nr AS stc_slot_id,
mov.pallet_rate AS pallet_part,
0 AS pallet_part_euro -- in neuer STruktur nicht mehr vorhanden
,
0 AS pallet_part_tiko -- in neuer STruktur nicht mehr vorhanden
,
mov.comment_txt AS comment_del,
mov.prot_receipt_status_id AS status_prot_receipt,
CAST(0 AS VARCHAR(5)) AS status_dayend -- in neuer STruktur nicht mehr vorhanden, in alter Struktur ueberwiegend mit Wert 0
,
mov.dur_del_cnt AS dur_del,
mov.wh_del_net_price AS price_wh_del,
mov.wh_del_gross_price AS price_wh_net_del,
mov.store_del_net_price AS price_str_del,
mov.store_del_gross_price AS price_str_net_del,
mov.price_fg,
mov.wh_retail_net_price AS price_retail_wh,
mov.wh_retail_gross_price,
mov.act_case_qty AS qty_case_act,
mov.del_case_qty AS qty_case_del,
mov.ordered_case_qty AS qty_case_order,
mov.del_piece_qty AS qty_piece_del,
mov.act_del_piece_qty AS qty_piece_act_del,
mov.loc_sid_wh AS wh_loc_sid
FROM p_lew_core_ac.v_item_delivery_1 AS mov

WHERE mov.delivery_type_id IN (1,2) /*AND mov.delivery_type_id NOT IN (3,4)*/ /*AND mov.delivery_type_id NOT IN (3,4)*/

UNION ALL
SELECT
mov.client_id,
mov.item_sid,
mov.dwh_cal_dt AS dat_formdate,
mov.fv_del_id,
mov.vat_id,
mov.order_area_cd,
mov.dayend_dt AS dat_dayend,
4,
-1,
2 AS booking_fg -- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2
,
-1,
NULL AS dsac_nr -- in neuer STruktur nicht mehr vorhanden
,
-1,
-1,
NULL AS satas_nr -- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert NULL
,
mov.price_grp_id_store AS pricegroup_store,
mov.layer_order_nr,
-1,
mov.slot_nr,
-1,
-1,
-1,
'',
-1,
CAST(2 AS VARCHAR(5)) AS status_dayend -- in neuer STruktur nicht mehr vorhanden, in alter Struktur immer mit Wert 2
,
mov.dur_del_cnt AS dur_fv_del,
mov.wh_net_price AS price_wh_fv,
mov.wh_gross_price AS price_wh_net_fv,
mov.store_net_price AS price_str_fv,
mov.store_gross_price AS price_str_net_fv,
-1,
mov.old_retail_net_price AS price_retail_fv_del_old,
mov.old_retail_gross_price AS price_retail_net_fv_del_old,
NULL,
mov.case_qty AS qty_case_fv_del,
NULL,
NULL,
NULL,
mov.loc_sid_wh AS wh_loc_sid
FROM p_lew_core_ac.v_item_fruits_vegetables_delivery_1 AS mov
) AS mov
-- WH Auflösung
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
ON wh.client_id = mov.client_id
AND wh.loc_sid_wh =  mov.wh_loc_sid
AND wh.dwh_actual_fg = 1

INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
ON  mov.client_id = cry.client_id
AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end

INNER JOIN (SELECT
client_id,
item_sid AS item_id,
orig_item_nr,
case_size,
reused_nr
FROM p_lew_core_ac.v_wawi_itm_item_skey_act_1
           ) itm
ON  mov.client_id = itm.client_id
AND mov.item_sid  =  itm.item_id

INNER JOIN p_lew_core_ac.v_wawi_itm_item_wh_1 AS item_wh
ON  item_wh.client_id = mov.client_id
AND item_wh.wh_loc_sid  =  mov.wh_loc_sid
AND item_wh.item_sid  =  mov.item_sid
AND mov.dat_formdate BETWEEN item_wh.dat_rec_start AND item_wh.dat_rec_end

INNER JOIN p_lew_core_ac.v_wawi_itm_wh_slot_1 AS item_slot
ON  item_slot.client_id =  mov.client_id
AND item_slot.wh_loc_sid  =  mov.wh_loc_sid
AND item_slot.item_sid  =  mov.item_sid
AND mov.dat_formdate BETWEEN item_slot.dat_rec_start AND item_slot.dat_rec_end
;

/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_store_form_1", "p_lew_bil_ac.v_warehouse_1", "p_lew_core_ac.v_wawi_ref_client_currency_rate_1", "p_lew_core_ac.v_item_map_key_1" ****/

