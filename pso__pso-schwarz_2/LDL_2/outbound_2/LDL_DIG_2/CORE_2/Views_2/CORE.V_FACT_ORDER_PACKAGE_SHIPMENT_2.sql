CREATE OR REPLACE VIEW ldl_dig_core.v_fact_order_package_shipment_2 (wshop_cd
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country_2'),
bus_year OPTIONS(description='The business year as a number in the form YYYY. Eg. 2019'), month_of_bus_year
OPTIONS(description='The month of the (Lidl) business year (starting in March) as a number using the convention March = 1, April = 2 ... December = 10, January = 11, February = 12'),
cust_order_dt OPTIONS(description='The date when order was made'), cust_order_perform_dt
OPTIONS(description='The timestamp when the delivery to the customer actually started. This timestamp is relevant from a financial perspective as until then you are not allowed to charge him/her. In case of serveral performance timestamps for a single article within a single order the last date is picked.'),
cust_order_sid OPTIONS(description='The unique identifier (surrogate key) for customer order'), cust_order_pos_nr
OPTIONS(description='The particular position number of an item_2 in an order'), prod_variant_sid
OPTIONS(description='Unique identifier (surrogate key) of the ordered/returned product'), prod_variant_nr
OPTIONS(description='The product variant number'), bundle_header_prod_variant_sid
OPTIONS(description='Unique Identifier for the product variant of the bundle header to which this bundle item_2 belongs'),
pack_size_handle_group_cd
OPTIONS(description='A code for packaging size classification grouped in the bigger buckets based on how many effort is required to handle it - 1 person , 2 persons etc'),
pack_sid OPTIONS(description='The unique identifier (surrogate key) for the package.'), deliv_prod_qty
OPTIONS(description='Quantity of a specific product within a specific package_2'), ship_cost_net_eur_val
OPTIONS(description='The shipping costs for Lidl Digital for each article included in a package_2 (Only Forward process)'))
OPTIONS(DESCRIPTION = `ONE ROW FOR EACH COMBINATION ORDER_POSITION-PACKAGE_2 FOR WAREHOUSE-DELIVERIES, WITH INFORMATION ALSO ABOUT THE TIME WHEN THE PACKAGE_2 WAS SENT, THE AMOUNT OF QTY AND THE SHIPPING COSTS PER POSITION`)
AS SELECT COALESCE(COL.wshop_cd, FGM.wshop_cd) AS wshop_cd,
 CAD.bus_year,
 CAD.month_of_bus_year,
 COL.cust_order_dt,
 COL.cust_order_perform_dt,
 COL.cust_order_sid,
 COL.cust_order_pos_nr,
 COL.prod_variant_sid,
 COL.prod_variant_nr,
 GH.bundle_header_prod_variant_sid,
  CASE
  WHEN PST.pack_size_handle_group_cd IS NOT NULL
  THEN PST.pack_size_handle_group_cd
  WHEN CPS.delivery_type_cd = 'Z4'
  THEN '2MH'
  WHEN REL.delivery_src_type_cd = 'STR'
  THEN REL.pack_size_handle_group_cd
  ELSE 'MF'
  END AS pack_size_handle_group_cd,
 ROP.pack_sid,
 SUM(ROP.deliv_prod_qty) AS deliv_prod_qty,
 SUM(ROP.ship_cost_net_eur_val) AS ship_cost_net_eur_val
FROM ldl_dig_core.t_rel_order_packaging_2 AS ROP
 INNER JOIN ldl_dig_core.t_fact_goods_movement_2 AS FGM ON ROP.delivery_order_nr = FGM.delivery_order_nr AND ROP.delivery_order_pos_nr
      = FGM.delivery_order_pos_nr AND FGM.goods_mov_cat_group_cd = 'WA' AND FGM.cust_order_sid IS NOT NULL
 LEFT JOIN ldl_dig_core.t_fact_sales_package_shipment_2 AS CPS ON ROP.pack_sid = CPS.pack_sid
 LEFT JOIN ldl_dig_core.t_dim_pack_size_type_2 AS PST ON CPS.pack_size_type_cd = PST.pack_size_type_cd
 LEFT JOIN ldl_dig_core.t_fact_customer_order_line_2 AS COL ON FGM.cust_order_sid = COL.cust_order_sid AND FGM.cust_order_pos_nr
     = COL.cust_order_pos_nr AND FGM.prod_variant_sid = COL.prod_variant_sid
 INNER JOIN ldl_dig_core.t_dim_cal_day_2 AS CAD ON DATE(FGM.wh_leave_actual_tmsp) = CAD.cal_dt
 LEFT JOIN ldl_dig_core.v_fact_order_line_bundle_component_2 AS GH ON COL.cust_order_sid = GH.cust_order_sid AND COL.cust_order_pos_nr
    = GH.cust_order_pos_nr
 LEFT JOIN ldl_dig_core.t_rel_product_variant_regional_2 AS REL ON COL.prod_variant_sid = REL.prod_variant_sid AND COL.wshop_cd
     = REL.wshop_cd AND REL.dwh_valid_fg
WHERE REL.delivery_src_type_cd <> 'STR'
 AND COALESCE(COL.wshop_cd, FGM.wshop_cd) NOT IN ('INT')
 AND NOT COL.is_order_cancel_fg
GROUP BY wshop_cd,
 CAD.bus_year,
 CAD.month_of_bus_year,
 COL.cust_order_dt,
 COL.cust_order_perform_dt,
 GH.bundle_header_prod_variant_sid,
 COL.cust_order_sid,
 COL.cust_order_pos_nr,
 COL.prod_variant_sid,
 COL.prod_variant_nr,
 ROP.pack_sid,
 pack_size_handle_group_cd;