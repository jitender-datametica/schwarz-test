CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_rel_product_variant_regional_1 (wshop_cd, prod_variant_sid,
prod_variant_nr, reg_prod_variant_name, reg_prod_variant_descr, prod_sid, prod_nr, reg_prod_name, prod_tgt_delivery_time
, tax_class_cd, material_pos_type_cd, delivery_src_type_cd, prod_reg_catalog_update_dt, prod_reg_catalog_insert_dt,
shop_cat_sid, shop_cat_name, shop_cat_lvl4_sid, shop_cat_lvl4_name, shop_cat_lvl3_sid, shop_cat_lvl3_name,
shop_cat_lvl2_sid, shop_cat_lvl2_name, shop_cat_lvl1_sid, shop_cat_lvl1_name, prod_online_status_cd,
prod_listing_status_cd, first_online_dt, pack_size_handle_group_cd, ship_size_handle_group_cd, prod_size_handle_group_cd
) AS SELECT wshop_cd,
 IFNULL(prod_variant_sid, -1) AS prod_variant_sid,
 prod_variant_nr,
 reg_prod_variant_name,
 reg_prod_variant_descr,
 IFNULL(prod_sid, -1) AS prod_sid,
 prod_nr,
 reg_prod_name,
 prod_tgt_delivery_time,
  CASE
  WHEN tax_class_cd = ''
  THEN '-1'
  ELSE IFNULL(tax_class_cd, '-1')
  END AS tax_class_cd,
  CASE
  WHEN material_pos_type_cd = ''
  THEN '-1'
  ELSE IFNULL(material_pos_type_cd, '-1')
  END AS material_pos_type_cd,
  CASE
  WHEN delivery_src_type_cd = ''
  THEN '-1'
  ELSE IFNULL(delivery_src_type_cd, '-1')
  END AS delivery_src_type_cd,
 prod_reg_catalog_update_dt,
 prod_reg_catalog_insert_dt,
 IFNULL(shop_cat_sid, -1) AS shop_cat_sid,
 shop_cat_name,
 IFNULL(shop_cat_lvl4_sid, -1) AS shop_cat_lvl4_sid,
 shop_cat_lvl4_name,
 IFNULL(shop_cat_lvl3_sid, -1) AS shop_cat_lvl3_sid,
 shop_cat_lvl3_name,
 IFNULL(shop_cat_lvl2_sid, -1) AS shop_cat_lvl2_sid,
 shop_cat_lvl2_name,
 IFNULL(shop_cat_lvl1_sid, -1) AS shop_cat_lvl1_sid,
 shop_cat_lvl1_name,
  CASE
  WHEN TRIM(prod_online_status_cd) = ''
  THEN '-1'
  ELSE IFNULL(prod_online_status_cd, '-1')
  END AS prod_online_status_cd,
  CASE
  WHEN TRIM(prod_listing_status_cd) = ''
  THEN '-1'
  ELSE IFNULL(prod_listing_status_cd, '-1')
  END AS prod_listing_status_cd,
 first_online_dt,
 IFNULL(pack_size_handle_group_cd, '-1') AS pack_size_handle_group_cd,
  CASE
  WHEN pack_size_handle_group_cd = 'MF'
  THEN 'P_KT'
  WHEN pack_size_handle_group_cd = '2MH'
  THEN 'P_2MH'
  WHEN pack_size_handle_group_cd = 'NMF'
  THEN 'P_GT'
  ELSE 'P_-1'
  END AS ship_size_handle_group_cd,
 IFNULL(prod_size_handle_group_cd, '-1') AS prod_size_handle_group_cd
FROM ldl_dig_lec_share.v_rel_product_variant_regional_1
WHERE dwh_valid_fg;