CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_stock_removal_2 (stock_removal_cd, stock_removal_descr) AS SELECT
 stock_removal_cd,
 stock_removal_descr
FROM ldl_dig_lec_share.v_dim_stock_removal_2
UNION ALL
SELECT '-1',
 '';