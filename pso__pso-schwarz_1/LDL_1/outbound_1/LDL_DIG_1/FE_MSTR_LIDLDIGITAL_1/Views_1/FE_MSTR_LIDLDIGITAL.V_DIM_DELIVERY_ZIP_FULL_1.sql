CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_dim_delivery_zip_full_1 (addr_sid, addr_lat, addr_lon, addr_nr,
zip_cd) AS SELECT DISTINCT DIM.addr_sid,
 DIM.addr_lat,
 DIM.addr_lon,
 DIM.addr_nr,
 DIM.zip_cd
FROM ldl_dig_lec_share.v_dim_address_1 AS DIM
 INNER JOIN ldl_dig_lec_share.v_fact_customer_order_line_1 AS FACT ON DIM.addr_sid = FACT.delivery_addr_sid
WHERE DIM.dwh_valid_fg;