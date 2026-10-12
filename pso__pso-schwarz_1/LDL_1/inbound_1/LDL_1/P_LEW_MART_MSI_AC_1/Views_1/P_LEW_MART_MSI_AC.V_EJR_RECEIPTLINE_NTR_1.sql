CREATE OR REPLACE VIEW P_LEW_MART_MSI_AC.V_EJR_RECEIPTLINE_NTR_1
/*
#DescStart#
#$Revision: 10032 $, $LastChangedBy: hwieber $
#SubjectAreas#: Access Layer
#DescEnd#
*/
(
    client_id
    , orig_receipt_serial_nr_ejr
    , store_id
    , pos_terminal_id
    , dat_formdate
    , time_receipt_ejr
    , barcode
    , ean_item_desc
    , time_halfhour_id
    , receipt_for_count_id
    , orig_receipt_nr_ejr
    , timezone_cd
    , dat_dayend
    , checker_id
    , transactiontype_id
    , item_id
    , mainitemgroup_id
    , qty_piece_ejr
    , qty_weight_ejr
    , pct_vat_ejr
    , pct_factor_dec_vat_ejr
    , price_retail_ejr
    , price_retail_net_ejr
    , price_retail_adjstd_ejr
    , price_retail_net_adjstd_ejr
    , price_type_ejr
    , mis_weight_fg
    , val_retail_ejr
    , val_retail_net_ejr
    , val_discount_ejr
    , val_discount_net_ejr
    , val_discount_hq_ejr
    , val_discount_hq_net_ejr
    , ejr_cd
    , discount_id
    , val_retail_orig_ejr
    , val_retail_orig_net_ejr
    , val_discount_base_ejr
    , val_discount_base_net_ejr
    , qty_discount_pos_ejr
    , qty_discount_hq_ejr
    , return_reason_cd_ejr
    , timestamp_begin_ejr
    , timestamp_end_ejr
    , item_entry_method_cd_ejr
    , price_entry_method_cd_ejr
    , parent_line_nr_ejr
    , voided_by_line_nr_ejr
    , currency_iso_cd
)
AS
SELECT
client_id,
orig_receipt_serial_nr_ejr,
store_id,
pos_terminal_id,
dat_formdate,
time_receipt_ejr,
barcode,
ean_item_desc,
time_halfhour_id,
receipt_for_count_id,
orig_receipt_nr_ejr,
timezone_cd,
dat_dayend,
checker_id,
transactiontype_id,
item_id,
mainitemgroup_id,
qty_piece_ejr,
qty_weight_ejr,
pct_vat_ejr,
pct_factor_dec_vat_ejr,
price_retail_ejr,
price_retail_net_ejr,
price_retail_adjstd_ejr,
price_retail_net_adjstd_ejr,
price_type_ejr,
mis_weight_fg,
val_retail_ejr,
val_retail_net_ejr,
val_discount_ejr,
val_discount_net_ejr,
val_discount_hq_ejr,
val_discount_hq_net_ejr,
ejr_cd,
discount_id,
val_retail_orig_ejr,
val_retail_orig_net_ejr,
val_discount_base_ejr,
val_discount_base_net_ejr,
qty_discount_pos_ejr,
qty_discount_hq_ejr,
return_reason_cd_ejr,
timestamp_begin_ejr,
timestamp_end_ejr,
item_entry_method_cd_ejr,
price_entry_method_cd_ejr,
parent_line_nr_ejr,
voided_by_line_nr_ejr,
currency_iso_cd
FROM p_lew_mart_msi.v_ejr_receiptline_ntr_1
;


