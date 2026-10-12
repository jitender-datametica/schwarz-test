CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_delivery_route (delivery_route_cd, delivery_route_descr) AS
SELECT delivery_route_cd,
 delivery_route_descr
FROM ldl_dig_lec_share.v_dim_delivery_route
UNION ALL
SELECT '-1',
 '';