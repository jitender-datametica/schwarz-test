CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_ejr_item_receipt_rel_2 (client_id, store_id, pos_terminal_id, time_receipt_ejr
, dat_formdate, orig_receipt_nr_ejr, checker_id, item_id, barcode, barcode_short, link_type, cnt_item_void,
val_retail_ejr) AS SELECT client_id,
 st_loc_sid AS store_id,
 pos_terminal_id,
 time_receipt_ejr,
 dat_formdate,
 orig_receipt_nr_ejr,
 checker_id,
 item_sid AS item_id,
 barcode,
 barcode_short,
 link_type,
 cnt_item_void,
 val_retail_ejr
FROM ldl_p_lew_mart_msi.t_msi_ejr_item_receipt_rel_2;