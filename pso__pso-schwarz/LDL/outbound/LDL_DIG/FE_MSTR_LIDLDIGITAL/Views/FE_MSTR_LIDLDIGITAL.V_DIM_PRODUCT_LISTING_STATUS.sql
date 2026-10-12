CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_product_listing_status (prod_listing_status_cd,
prod_listing_status_descr) AS SELECT prod_listing_status_cd,
 prod_listing_status_descr
FROM ldl_dig_lec_share.v_dim_product_listing_status
UNION ALL
SELECT '-1',
 '';