CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_sales_channel_type_2 (sales_channel_type_cd,
sales_channel_type_descr) AS SELECT sales_channel_type_cd,
 sales_channel_type_descr
FROM ldl_dig_lec_share.v_dim_sales_channel_type_2
UNION ALL
SELECT '-1',
 '';