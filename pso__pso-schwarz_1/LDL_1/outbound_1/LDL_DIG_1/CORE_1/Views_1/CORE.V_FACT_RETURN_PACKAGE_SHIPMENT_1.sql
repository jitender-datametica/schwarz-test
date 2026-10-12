CREATE OR REPLACE VIEW ldl_dig_core.v_fact_return_package_shipment_1 (wshop_cd
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country_1'),
bus_year OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'), month_of_bus_year
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12'),
cust_order_return_dt OPTIONS(description='The date when return was made'), cust_order_sid
OPTIONS(description='The unique identifier (surrogate key) for customer order'), cust_order_pos_nr
OPTIONS(description='The particular position number of an item_1 in an order'), forward_dropshipment_order_fg
OPTIONS(description='True if the forward order is a dropshipment order'), cust_order_return_sid
OPTIONS(description='The unique identifier (surrogate key) for return of customer order'), cust_order_return_pos_nr
OPTIONS(description='A number of an particular position ( product ) in an return order'), return_dropshipment_order_fg
OPTIONS(description='True if the package_1 is returned to the supplier_1 (dropshipment) - FALSE if it comes back to one of our warehouses'),
return_wh_sid OPTIONS(description='The unique identifier (surrogate key) for the warehouse handling the return.'),
hauler_name OPTIONS(description='The name by which the transport carrier is known'), prod_variant_sid
OPTIONS(description='Unique identifier (surrogate key) of the ordered/returned product'), prod_variant_nr
OPTIONS(description='The product variant number'), bundle_header_prod_variant_sid
OPTIONS(description='Unique Identifier for the product variant of the bundle header to which this bundle item_1 belongs'),
pack_size_handle_group_cd
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - 1 person , 2 persons etc'),
return_pack_sid OPTIONS(description='The unique identifier(surrogate key) for the package_1 of the return'),
return_pack_tracking_url, return_ship_cost_net_eur_val
OPTIONS(description='the shipping costs for lidl digital for each article included in a package_1 (only return process)'))
AS WITH RANKED_RETURNS AS (SELECT wshop_cd,
   cust_order_sid,
   cust_order_pos_nr,
   cust_order_return_dt,
   cust_order_return_sid,
   cust_order_return_pos_nr,
   dropshipment_order_fg,
   return_wh_sid,
   prod_variant_sid,
   prod_variant_nr,
   ROW_NUMBER() OVER (PARTITION BY CAST(cust_order_sid AS STRING), CAST(cust_order_pos_nr AS STRING) ORDER BY
      cust_order_return_dt IS NULL, cust_order_return_dt) AS rn
  FROM ldl_dig_core.t_fact_customer_return_line_1), RETURN_GROUPED AS (SELECT wshop_cd,
   cust_order_sid,
   cust_order_pos_nr,
   MIN(cust_order_return_dt) AS cust_order_return_dt,
   MIN(cust_order_return_sid) AS cust_order_return_sid,
   MIN(cust_order_return_pos_nr) AS cust_order_return_pos_nr,
   MAX(dropshipment_order_fg) AS dropshipment_order_fg,
   MAX(return_wh_sid) AS return_wh_sid,
   prod_variant_sid,
   prod_variant_nr
  FROM RANKED_RETURNS
  WHERE rn = 1
  GROUP BY wshop_cd,
   cust_order_sid,
   cust_order_pos_nr,
   prod_variant_sid,
   prod_variant_nr) (SELECT crl.wshop_cd,
   CAD.bus_year,
   CAD.month_of_bus_year,
   crl.cust_order_return_dt,
   crl.cust_order_sid,
   crl.cust_order_pos_nr,
   COL.dropshipment_order_fg AS forward_dropshipment_order_fg,
   crl.cust_order_return_sid,
   crl.cust_order_return_pos_nr,
   crl.dropshipment_order_fg AS return_dropshipment_order_fg,
   crl.return_wh_sid,
   HAU.hauler_name,
   crl.prod_variant_sid,
   crl.prod_variant_nr,
   GH.bundle_header_prod_variant_sid,
   CRPS.pack_size_handle_group_cd,
   CRPS.return_pack_sid,
   CRPS.return_pack_tracking_nr,
   SUM(CRPS.return_ship_cost_net_eur_val) AS return_ship_cost_net_eur_val
  FROM ldl_dig_core.t_fact_sales_return_package_shipment_1 AS CRPS
   LEFT JOIN ldl_dig_core.t_fact_customer_order_line_1 AS COL ON CRPS.sale_order_sid = COL.cust_order_sid AND CRPS.sale_order_pos_nr
      = COL.cust_order_pos_nr
   INNER JOIN RETURN_GROUPED AS crl ON COL.cust_order_sid = crl.cust_order_sid AND COL.cust_order_pos_nr = crl.cust_order_pos_nr
     
   LEFT JOIN ldl_dig_core.t_dim_cal_day_1 AS CAD ON crl.cust_order_return_dt = CAD.cal_dt
   LEFT JOIN ldl_dig_core.v_fact_order_line_bundle_component_1 AS GH ON crl.cust_order_sid = GH.cust_order_sid AND crl.cust_order_pos_nr
      = GH.cust_order_pos_nr
   LEFT JOIN ldl_dig_core.t_dim_hauler_1 AS HAU ON HAU.dwh_valid_fg AND CRPS.hauler_sid = HAU.hauler_sid
   LEFT JOIN ldl_dig_core.t_rel_product_variant_regional_1 AS REL ON COL.prod_variant_sid = REL.prod_variant_sid AND COL.wshop_cd
       = REL.wshop_cd AND REL.dwh_valid_fg
  WHERE (CRPS.handover_to_carrier_dt IS NOT NULL OR CRPS.return_hub_dt IS NOT NULL OR CRPS.first_intake_scan_hub_dt
      IS NOT NULL) AND NOT CRPS.is_legacy_fg
   OR CRPS.is_legacy_fg AND CRPS.return_ship_cost_net_eur_val IS NOT NULL
  GROUP BY crl.wshop_cd,
   CAD.bus_year,
   CAD.month_of_bus_year,
   crl.cust_order_return_dt,
   crl.cust_order_sid,
   crl.cust_order_pos_nr,
   forward_dropshipment_order_fg,
   crl.cust_order_return_sid,
   crl.cust_order_return_pos_nr,
   return_dropshipment_order_fg,
   crl.return_wh_sid,
   HAU.hauler_name,
   crl.prod_variant_sid,
   crl.prod_variant_nr,
   GH.bundle_header_prod_variant_sid,
   CRPS.pack_size_handle_group_cd,
   CRPS.return_pack_sid,
   CRPS.return_pack_tracking_nr);