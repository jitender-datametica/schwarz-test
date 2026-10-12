
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_MOV_ITEM_ALLOC_DELIVERY_1

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
/*
#DescStart#
#$Revision: 13400 $, $LastChangedBy: umeister $
#SubjectAreas#: Anliefermenge
#DescEnd#
*/
SELECT
mov.client_id,
mov.item_sid AS item_id,
mov.dwh_cal_dt AS dat_formdate,
mov.receipt_id AS receipt_id_del,
mov.loc_sid_store AS store_id,
skey.wh_id,
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
mov.group_nr,
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
mov.wh_del_net_price / cry.rate_currency_exchange             AS price_wh_del,
mov.wh_del_gross_price  / cry.rate_currency_exchange          AS price_wh_net_del,
mov.store_del_net_price / cry.rate_currency_exchange          AS price_str_del,
mov.store_del_gross_price / cry.rate_currency_exchange        AS price_str_net_del,
mov.price_fg,
mov.wh_retail_net_price / cry.rate_currency_exchange          AS price_retail_wh,
mov.wh_retail_gross_price / cry.rate_currency_exchange        AS price_retail_wh_net,
mov.act_case_qty AS qty_case_act,
mov.del_case_qty AS qty_case_del,
mov.ordered_case_qty AS qty_case_order,
mov.del_piece_qty AS qty_piece_del,
mov.act_del_piece_qty AS qty_piece_act_del,
cry.currency_iso_cd,
wh.src_wh_id AS wh_id_del
FROM p_lew_core_ac.v_item_delivery_1 AS mov
-- Auflösung WH
INNER JOIN p_lew_bil_ac.v_warehouse_1 AS wh
ON wh.client_id = mov.client_id
AND wh.loc_sid_wh =  mov.loc_sid_wh
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
ON mov.client_id = cry.client_id
AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
INNER JOIN p_lew_mart_msi.v_org_store_skey_1 AS skey
ON mov.client_id = skey.client_id
AND mov.loc_sid_store  =  skey.store_id
WHERE mov.delivery_type_id = 1
;
/**** WARNING: MISSING DEPENDENT OBJECTS "p_lew_core_ac.v_item_delivery_1", "p_lew_bil_ac.v_warehouse_1", "p_lew_core_ac.v_wawi_ref_client_currency_rate_1", "p_lew_mart_msi.v_org_store_skey_1" ****/
