CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_MOV_ITEM_DIR_DELIVERY
/*
#DescStart#
#$Revision: 7894 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , store_id
    , item_id
    , dat_dayend
    , dir_del_id
    , wh_id
    , supplier_id
    , vat_id
    , order_area_cd
    , orig_receipt_nr_dir_del
    , rcv_pos_id
    , dat_formdate
    , dat_booking
    , dat_rcv_mdd
    , status_dayend
    , status_dir_del
    , act_price_item_cd
    , dd_matched_fg
    , dispo_unit_desc
    , dispo_unit_id
    , mdd_user
    , mdd_return_fg
    , group_nr
    , comment_dir_del
    , price_act_wh
    , price_act_wh_net
    , price_cd
    , price_wh_dir_del
    , price_wh_net_dir_del
    , price_str_dir_del
    , price_str_net_dir_del
    , qty_case_dir_del
    , case_size_dec
    , currency_iso_cd
    , wh_id_del
)
AS
SELECT
client_id,
store_id,
item_id,
dat_dayend,
dir_del_id,
wh_id,
supplier_id,
vat_id,
order_area_cd,
orig_receipt_nr_dir_del,
rcv_pos_id,
dat_formdate,
dat_booking,
dat_rcv_mdd,
status_dayend,
status_dir_del,
act_price_item_cd,
dd_matched_fg,
dispo_unit_desc,
dispo_unit_id,
mdd_user,
mdd_return_fg,
group_nr,
comment_dir_del,
price_act_wh,
price_act_wh_net,
price_cd,
price_wh_dir_del,
price_wh_net_dir_del,
price_str_dir_del,
price_str_net_dir_del,
qty_case_dir_del,
case_size_dec,
currency_iso_cd,
wh_id_del
FROM p_lew_mart_msi.v_mov_item_dir_delivery
;





