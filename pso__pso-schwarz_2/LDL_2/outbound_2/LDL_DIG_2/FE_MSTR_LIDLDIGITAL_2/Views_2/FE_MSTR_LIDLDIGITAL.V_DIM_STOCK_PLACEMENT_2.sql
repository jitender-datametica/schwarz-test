CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_stock_placement_2 (stock_placement_cd, stock_placement_descr) AS
SELECT stock_placement_cd,
 stock_placement_descr
FROM ldl_dig_lec_share.v_dim_stock_placement_2
UNION ALL
SELECT '-1',
 '';