CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_MOV_ITEM_DELIVERY_2
/*
#DescStart#
#$Revision: 7894 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , item_id
    , dat_formdate
    , receipt_id_del
    , store_id
    , wh_id
    , vat_id
    , order_area_cd
    , dat_dayend
    , deliverytype_id
    , dispo_unit_id
    , booking_fg
    , blocking_cd
    , dsac_nr
    , group_nr
    , print_nr
    , satas_nr
    , pricegroup_act_price
    , stc_location_id
    , stc_slot_area
    , stc_slot_id
    , pallet_part
    , pallet_part_euro
    , pallet_part_tiko
    , comment_del
    , status_prot_receipt
    , status_dayend
    , dur_del
    , price_wh_del
    , price_wh_net_del
    , price_str_del
    , price_str_net_del
    , price_fg
    , price_retail_wh
    , price_retail_wh_net
    , qty_case_act
    , qty_case_del
    , qty_case_order
    , qty_piece_del
    , qty_piece_act_del
    , case_size_dec
    , weight
    , currency_iso_cd
    , wh_id_del
)
AS
SELECT
client_id,
item_id,
dat_formdate,
receipt_id_del,
store_id,
wh_id,
vat_id,
order_area_cd,
dat_dayend,
deliverytype_id,
dispo_unit_id,
booking_fg,
blocking_cd,
dsac_nr,
group_nr,
print_nr,
satas_nr,
pricegroup_act_price,
stc_location_id,
stc_slot_area,
stc_slot_id,
pallet_part,
pallet_part_euro,
pallet_part_tiko,
comment_del,
status_prot_receipt,
status_dayend,
dur_del,
price_wh_del,
price_wh_net_del,
price_str_del,
price_str_net_del,
price_fg,
price_retail_wh,
price_retail_wh_net,
qty_case_act,
qty_case_del,
qty_case_order,
qty_piece_del,
qty_piece_act_del,
case_size_dec,
weight,
currency_iso_cd,
wh_id_del
FROM p_lew_mart_msi.v_mov_item_delivery_2
;


