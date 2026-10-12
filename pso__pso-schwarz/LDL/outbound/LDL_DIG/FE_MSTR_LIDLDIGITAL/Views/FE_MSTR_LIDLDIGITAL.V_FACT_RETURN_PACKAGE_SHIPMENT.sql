CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_fact_return_package_shipment (wshop_cd, bus_year, month_of_bus_year
, cust_order_return_dt, cust_order_sid, cust_order_pos_nr, cust_order_return_sid, cust_order_return_pos_nr,
prod_variant_sid, prod_variant_nr, bundle_component_prod_variant_sid, bundle_header_prod_variant_sid,
pack_size_handle_group_cd, return_pack_sid, return_ship_cost_net_eur_val) AS SELECT wshop_cd,
 bus_year,
 month_of_bus_year,
 cust_order_return_dt,
 IFNULL(cust_order_sid, -1) AS cust_order_sid,
 cust_order_pos_nr,
 cust_order_return_sid,
 cust_order_return_pos_nr,
 COALESCE(bundle_header_prod_variant_sid, prod_variant_sid, -1) AS prod_variant_sid,
 IFNULL(prod_variant_nr, '-1') AS prod_variant_nr,
 IFNULL(prod_variant_sid, -1) AS bundle_component_prod_variant_sid,
 IFNULL(bundle_header_prod_variant_sid, -1) AS bundle_header_prod_variant_sid,
 pack_size_handle_group_cd,
 IFNULL(return_pack_sid, -1) AS return_pack_sid,
 return_ship_cost_net_eur_val
FROM ldl_dig_lec_share.v_fact_return_package_shipment_core_view
WHERE cust_order_return_dt >= DATE '2022-03-01'
 AND cust_order_return_dt <= LAST_DAY(IF(CURRENT_DATE = LAST_DAY(CURRENT_DATE), LAST_DAY(DATE_ADD(CURRENT_DATE, INTERVAL
      - 1 MONTH)), DATE_ADD(CURRENT_DATE, INTERVAL - 1 MONTH)), MONTH);