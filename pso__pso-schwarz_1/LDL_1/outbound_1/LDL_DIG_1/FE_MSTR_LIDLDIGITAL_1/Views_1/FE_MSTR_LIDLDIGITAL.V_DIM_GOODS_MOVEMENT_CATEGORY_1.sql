CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_goods_movement_category_1 (goods_mov_cat_cd,
goods_mov_cat_group_cd, goods_mov_cat_descr) AS SELECT goods_mov_cat_cd,
  CASE
  WHEN goods_mov_cat_group_cd = ''
  THEN '-1'
  ELSE IFNULL(goods_mov_cat_group_cd, '-1')
  END AS goods_mov_cat_group_cd,
 goods_mov_cat_descr
FROM ldl_dig_lec_share.v_dim_goods_movement_category_1
UNION ALL
SELECT '-1',
 '-1',
 '';