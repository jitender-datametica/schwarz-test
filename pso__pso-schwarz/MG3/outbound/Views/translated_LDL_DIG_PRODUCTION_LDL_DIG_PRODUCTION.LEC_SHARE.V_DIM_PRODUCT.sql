CREATE OR REPLACE VIEW ldl_dig_production_lec_share.v_dim_product (prod_sid, dwh_valid_from_tmsp, dwh_valid_to_tmsp,
dwh_valid_fg, prod_nr, prod_name, prod_descr, ian_nr, prod_brick_cd, dwh_created_tmsp, dwh_updated_tmsp,
dwh_src_file_name, src_file_tmsp, shop_cat_lvl4_sid, prod_packing_type_cd, prod_food_class_cd, brand_class_cd,
shop_cat_lvl4_name, shop_cat_lvl3_sid, shop_cat_lvl3_name, shop_cat_lvl2_sid, shop_cat_lvl2_name, shop_cat_lvl1_sid,
shop_cat_lvl1_name, shop_cat_sid, shop_cat_name, import_nr, brand_sid, prod_group_cd, prod_storage_cond_cd,
prod_dang_good_class_cd, prod_material_type_cd, prod_promo_class_cd, season_nr, prod_assortment_class_cd,
prod_purch_org_type_cd, src_table_name, is_bundle_header_fg, prod_hist_nr, brand_nr, shop_cat_lvl4_cd, shop_cat_lvl3_cd
, shop_cat_lvl2_cd, shop_cat_lvl1_cd, prod_subgroup_cd, prod_family_cd, prod_src_insert_dt, prod_manager_cd,
prod_org_lvl_name, prod_group_ldt_cd, is_wine_spirits_fg, subcategory_of_need_cd, subcategory_of_need_name,
category_of_need_cd, category_of_need_name, world_of_need_cd, world_of_need_name, prod_category_ppe_name) AS SELECT *
FROM ldl_dig_production_core.t_dim_product;