CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_goods_movement_category_group_1 (goods_mov_cat_group_cd,
goods_mov_cat_group_descr) AS SELECT goods_mov_cat_group_cd,
 goods_mov_cat_group_descr
FROM ldl_dig_lec_share.v_dim_goods_movement_category_group_1
UNION ALL
SELECT '-1',
 '';