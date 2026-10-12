CREATE OR REPLACE VIEW ldl_dig_production_lec_share.v_dim_product_variant_2 (prod_variant_sid, prod_variant_nr,
prod_variant_name, prod_variant_descr, prod_sid, prod_nr, prod_name, volume_uom_sid, volume_meas, weight_uom_sid,
weight_meas, girth_uom_sid, girth_east_meas, girth_west_meas, length_uom_sid, length_meas, mean_length_meas,
shortest_length_meas, longest_length_meas, width_uom_sid, width_meas, height_uom_sid, height_meas, prod_orig_country_cd
, dwh_created_tmsp, dwh_updated_tmsp, dwh_src_file_name, src_file_tmsp, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
dwh_valid_fg, shop_cat_lvl4_sid, prod_food_class_cd, brand_class_cd, shop_cat_lvl4_name, shop_cat_lvl3_sid,
shop_cat_lvl3_name, shop_cat_lvl2_sid, shop_cat_lvl2_name, shop_cat_lvl1_sid, shop_cat_lvl1_name, shop_cat_sid,
shop_cat_name, prod_global_status_cd, ian_nr, palette_capacity_cnt, container_capacity_cnt, prod_size_type_cd,
package_capacity_cnt, main_supplier_sid, brand_sid, is_bulky_item_fg, main_ean_nr, prod_assortment_class_cd,
src_table_name, prod_brick_cd, is_bundle_header_fg, prod_variant_hist_nr, prod_variant_ian_nr, net_weight_meas,
gross_weight_meas, prod_variant_import_nr, volume_uom_cd, weight_uom_cd, girth_uom_cd, length_uom_cd, width_uom_cd,
height_uom_cd, brand_nr, shop_cat_lvl4_cd, shop_cat_lvl3_cd, shop_cat_lvl2_cd, shop_cat_lvl1_cd,
prod_variant_src_insert_dt, prod_variant_src_update_dt, prod_variant_packing_type_cd, prod_variant_dang_good_class_cd)
AS SELECT *
FROM ldl_dig_production_core.t_dim_product_variant_2;