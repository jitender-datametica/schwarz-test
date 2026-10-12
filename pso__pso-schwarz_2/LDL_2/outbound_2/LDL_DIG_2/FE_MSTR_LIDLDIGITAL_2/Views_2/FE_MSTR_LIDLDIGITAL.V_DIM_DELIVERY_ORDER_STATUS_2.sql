CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_delivery_order_status_2 (delivery_order_status_cd,
delivery_order_status_descr) AS SELECT delivery_order_status_cd,
 delivery_order_status_descr
FROM ldl_dig_lec_share.v_dim_delivery_order_status_2
UNION ALL
SELECT '-1',
 '';