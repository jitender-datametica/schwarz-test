
CREATE OR REPLACE DYNAMIC TABLE p_lew_mart_msi.v_mov_item_receive_wh

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
SELECT
a.client_id,
a.src_wh_id AS wh_id,
itmp.item_sid_map AS item_id,
a.dwh_cal_dt AS dat_formdate,
a.customer_nr,
CAST(a.location_item_receipt_id AS DECIMAL(15,0)) AS receipt_id_rcv,
CAST(a.location_item_receipt_pos_id AS SMALLINT) AS receipt_pos_nr_rcv,
a.receipt_type_id AS receivetype_id,
a.currency_id AS currency_nr,
a.dat_dayend,
a.entry_dt AS dat_entry_rcv,
a.dat_adjustment_rcv,
a.dat_min_durability_rcv,
a.dat_valid_from AS dat_rcv_pos_valid_start,
a.dat_valid_until AS dat_rcv_pos_valid_end,
supmap.sup_sid_map AS supplier_id,
a.sup_sid_pay AS supplier_id_pay,
a.mapping_pos_nr,
a.orig_receipt_id_rcv,
a.receipt_pos_partdel_fg AS receipt_pos_part_delivery_fg,
a.receipt_pos_matchable_rel_fg AS receipt_pos_matchable_fg,
a.receipt_pos_margin_rel_fg AS receipt_pos_marginrel_fg,
a.status_tg,
a.vat_id,
a.pct_vat_rcv,
a.item_category_id AS tax_id_rcv,
a.stock_location_nr AS stock_location_id,
a.receive_case_qty AS qty_case_rcv,
a.qty_piece_rcv,
a.receive_piece_qty AS qty_total_rcv,
a.price_buying_rcv,
a.price_buying_euro_rcv AS price_buying_euro,
a.price_retail_rcv,
a.price_retail_net_rcv,
a.buying_val AS val_buying_rcv,
a.val_buying_suppl_rcv,
a.val_buying_euro,
a.retail_val AS val_retail_rcv,
a.retail_net_val AS val_net_retail_rcv,
a.val_deposit_rcv,
a.case_size_dec,
a.package_qty,
a.buying_fa_val AS val_buying_fa_rcv,
a.retail_net_fa_val AS val_net_retail_fa_rcv,
a.curr_cd_from AS currency_iso_cd,
a.dwh_load_id AS load_id,
a.dwh_created AS timestamp_mod
FROM p_lew_bil_ac.v_mov_item_receive_wh a
INNER JOIN p_lew_core_ac.v_item_map_key itmp
ON itmp.client_id = a.client_id
  AND itmp.item_sid = a.item_sid
INNER JOIN p_lew_core_ac.v_supplier_map_key supmap
ON a.client_id = supmap.client_id
  AND a.sup_sid = supmap.sup_sid
;
