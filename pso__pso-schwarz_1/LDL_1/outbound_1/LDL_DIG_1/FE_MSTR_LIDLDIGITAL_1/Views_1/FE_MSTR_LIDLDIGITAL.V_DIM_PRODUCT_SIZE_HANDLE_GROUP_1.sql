CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_size_handle_group_1 (prod_size_handle_group_cd,
prod_size_handle_group_descr, prod_size_handle_group_display_order_nr) AS SELECT prod_size_handle_group_cd,
 prod_size_handle_group_descr,
 CAST(CASE
   WHEN prod_size_handle_group_cd = 'P_KT'
   THEN '1  '
   WHEN prod_size_handle_group_cd = 'P_GT'
   THEN '2  '
   WHEN prod_size_handle_group_cd = 'P_2MH'
   THEN '3  '
   WHEN prod_size_handle_group_cd = 'P_Sonst'
   THEN '4  '
   ELSE '999'
   END AS INTEGER) AS prod_size_handle_group_display_order_nr
FROM ldl_dig_lec_share.v_dim_product_size_handle_group_1
UNION ALL
SELECT '-1',
 '',
 1000;