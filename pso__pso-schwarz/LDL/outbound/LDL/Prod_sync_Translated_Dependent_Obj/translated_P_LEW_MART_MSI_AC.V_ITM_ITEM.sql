CREATE OR REPLACE VIEW ldl_p_lew_mart_msi_ac.v_itm_item (brand, buying_list_orderset_nr, case_size, client_id,
country_cd, dat_valid_from, item_id, orig_item_nr, orig_item_nr_int, add_docs_fg, additions, age_fg, beverage_tax,
buyer_id, buyer_name, buying_list_type_id, buying_list_type_desc, case_dd, case_depth, case_euro, case_height,
case_layer, case_plu_fg, case_volume, case_weight, case_width, commodity_cd, consumption_tax_main_id,
consumption_tax_sub_id, cont_deposit_item_nr, contract_country_cd, dangerous_goods_fg, dat_adv, dat_delisting,
dat_listing, dat_min_shelflifetest_fg, delisting_fg, delivery_temp, direct_delete_mde_fg, discount_fg, dualsystem_fg,
dur_shelflife_day_cust, dur_shelflife_day_store, dur_shelflife_day_wh, food_fg, forwarding_item_nr, int_subitemgroup_id
, item_actiongroup_id, item_familygroup_id, item_parts, item_parts_cd, item_plu_nr, item_short_desc_1, item_short_desc_2
, item_short_desc_3, item_sub_actiongroup_id, item_text_1, item_text_2, item_text_3, item_version,
lidl_buying_country_cd, listing_fg, logistic_unit_cd, max_receive_temp, mdessp_fg, min_case_dd, min_case_euro,
min_case_layer, min_case_orderunit, min_receive_temp, minus_fg, net_case_weight, net_piece_weight, order_area_cd,
package_qty, packagetype_desc, packing, pct_consumption_tax, pct_discount, period_id_shelflife_cust,
period_id_shelflife_store, period_id_shelflife_wh, piece_depth, piece_height, piece_volume, piece_weight, piece_width,
poster_fg, price_sign_fg, price_strip_fg, qty_consumption_tax_add, res_selltime, reusable_fg, scale_fg, season_fg,
smallest_orderunit, smallest_unit, status_id_hq, stock_capacity, subitemgroup_id, tax_refund_fg, taxation, type_cd,
type_receive_temp_fg, unitsize, val_consumption_tax, val_deposit, vat_id, wallow_nr, weight, weight_fg, wg_fg, write_off
, buyer_name_int, case_size_dec, dur_shelflife_timeunits_cust, dur_shelflife_timeunits_store, dur_shelflife_timeunits_wh
, factor_period_cust, factor_period_store, factor_period_wh, factor_shelflife_cust, factor_shelflife_store,
factor_shelflife_wh, qty_min_piece_ordering) AS SELECT *
FROM ldl_p_lew_mart_msi.v_itm_item;