CREATE OR REPLACE VIEW ldl_dig_core.v_goods_order_and_return_1 (business_event_type_cd
OPTIONS(description='\"O\" for orders,\"R\" for returns'), cust_order_sid
OPTIONS(description='The unique identifier (surrogate key) for customer order'), document_nr
OPTIONS(description='The original order number or return order number from the source system'), prod_variant_sid
OPTIONS(description='Unique identifier (surrogate key) of the ordered/returned product'), prod_variant_nr
OPTIONS(description='The original number of the ordered/returned product'), wshop_cd
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'),
event_date
OPTIONS(description='For Orders this is order_perform_dt (when delivery started). For Returns this is order_return_dt'),
cust_order_dt OPTIONS(description='The date when order was made'), curr_cd
OPTIONS(description='Currency code in which order has been payed'), tax_class_cd
OPTIONS(description='The code identifying the tax class'), delivery_src_type_cd
OPTIONS(description='The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly'),
prod_qty OPTIONS(description='Quantity of a particular product ordered'), ivp_price_net_eur_val
OPTIONS(description='Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs )'),
order_prod_price_gross_local_val OPTIONS(description='Original (listed) gross price of a product in local currency'),
prod_price_gross_local_val
OPTIONS(description='For orders, this is the original (listed) gross price of a product in local currency. For returns, this is the credit note.'))
OPTIONS(DESCRIPTION = `ALL EVENTS (ORDERS AND RETURNS) WHICH ARE NEEDED FOR GOODS LOSSES REPORTS, AGGREGATE TO CUST_ORDER_SID + PROD_VARIANT_SID LEVEL`)
AS SELECT 'O' AS business_event_type_cd,
 cust_order_sid,
 cust_order_nr AS document_nr,
 prod_variant_sid,
 prod_variant_nr,
 wshop_cd,
 cust_order_perform_dt AS event_date,
 cust_order_dt,
 curr_cd,
 tax_class_cd,
 delivery_src_type_cd,
 SUM(prod_qty) AS prod_qty,
 SUM(ivp_unit_price_net_eur_val * prod_qty) AS ivp_price_net_eur_val,
 SUM(prod_price_gross_local_val) AS order_prod_price_gross_local_val,
 SUM(prod_price_gross_local_val) AS prod_price_gross_local_val
FROM ldl_dig_core.t_fact_customer_order_line_1 AS OL
WHERE is_part_of_bundle_header_cnt_fg
 AND (cust_order_perform_dt >= DATE '2022-03-01' OR cust_order_perform_dt IS NULL AND cust_order_dt >= DATE '2022-03-01'
     )
 AND NOT is_order_cancel_fg
GROUP BY cust_order_sid,
 document_nr,
 prod_variant_sid,
 prod_variant_nr,
 wshop_cd,
 event_date,
 cust_order_dt,
 curr_cd,
 tax_class_cd,
 delivery_src_type_cd
UNION ALL
SELECT 'R' AS business_event_type_cd,
 ORL.cust_order_sid,
 ORL.cust_order_return_nr AS document_nr,
 ORL.prod_variant_sid,
 ORL.prod_variant_nr,
 ORL.wshop_cd,
 ORL.cust_order_return_dt AS event_date,
 ORL.cust_order_dt,
 ORL.curr_cd,
 OL.tax_class_cd,
 OL.delivery_src_type_cd,
 SUM(- 1 * ORL.prod_qty) AS prod_qty,
 SUM(- 1 * ORL.cogs_price_net_eur_val) AS ivp_price_net_eur_val,
 SUM(- 1 * OL.prod_price_gross_local_val) AS order_prod_price_gross_local_val,
 SUM(- 1 * ORL.prod_price_gross_local_val) AS prod_price_gross_local_val
FROM ldl_dig_core.t_fact_customer_return_line_1 AS ORL
 INNER JOIN ldl_dig_core.t_fact_customer_order_line_1 AS OL ON ORL.cust_order_sid = OL.cust_order_sid AND ORL.cust_order_pos_nr
    = OL.cust_order_pos_nr
WHERE ORL.prod_price_gross_local_val > 0
 AND ORL.cust_order_return_dt >= DATE '2022-03-01'
GROUP BY ORL.cust_order_sid,
 document_nr,
 ORL.prod_variant_sid,
 ORL.prod_variant_nr,
 ORL.wshop_cd,
 event_date,
 ORL.cust_order_dt,
 ORL.curr_cd,
 OL.tax_class_cd,
 OL.delivery_src_type_cd;