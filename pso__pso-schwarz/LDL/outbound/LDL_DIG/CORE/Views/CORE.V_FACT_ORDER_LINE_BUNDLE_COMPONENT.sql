CREATE OR REPLACE VIEW ldl_dig_core.v_fact_order_line_bundle_component (cust_order_sid
OPTIONS(description='The unique identifier (surrogate key) for customer order'), cust_order_pos_nr
OPTIONS(description='The particular position number of an item in an order'), bundle_header_prod_variant_sid
OPTIONS(description='Unique Identifier for the product variant of the bundle header to which this bundle item belongs'),
bundle_header_prod_variant_nr
OPTIONS(description='The product variant number of the bundle-header to which this bundle item belongs'),
prod_variant_sid OPTIONS(description='Unique identifier (surrogate key) of the ordered/returned product'),
prod_variant_nr OPTIONS(description='The product variant number'), is_bundle_component_fg
OPTIONS(description='Set as true for bundle position and false for bundle header item '), prod_price_gross_local_val
OPTIONS(description='Original (listed) gross price of a product in local currency'), prod_price_gross_bundle_pct
OPTIONS(description='Percentage Weight of the item on the original (listed) gross price of the bundle in local currency'))
OPTIONS(DESCRIPTION = `ONE ROW FOR EACH BUNDLE-ORDER POSITION, WITH THE ASSOCIATE BUNDLE-HEADER PRODUCT AND THE PERCENTAGE WEIGHT OF EACH ITEM ON THE BUNDLE`)
AS SELECT cust_order_sid,
 cust_order_pos_nr,
 FIRST_VALUE(prod_variant_sid) OVER (PARTITION BY CAST(cust_order_sid AS STRING), CAST(IF(is_bundle_header_fg = (1 <> 0), cust_order_pos_nr, bundle_header_pos_nr) AS STRING)
    ORDER BY cust_order_pos_nr IS NULL, cust_order_pos_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 bundle_header_prod_variant_sid,
 FIRST_VALUE(prod_variant_nr) OVER (PARTITION BY CAST(cust_order_sid AS STRING), CAST(IF(is_bundle_header_fg = (1 <> 0), cust_order_pos_nr, bundle_header_pos_nr) AS STRING)
    ORDER BY cust_order_pos_nr IS NULL, cust_order_pos_nr RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS
 bundle_header_prod_variant_nr,
 prod_variant_sid,
 prod_variant_nr,
 IF(bundle_header_pos_nr > 0, TRUE, FALSE) AS is_bundle_component_fg,
 prod_price_gross_local_val,
 IF((SUM(prod_price_gross_local_val) OVER (PARTITION BY CAST(cust_order_sid AS STRING), CAST(bundle_header_pos_nr AS STRING)
       , IF(bundle_header_pos_nr > 0, TRUE, FALSE) RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)) = 0, 0,
  SAFE_DIVIDE(prod_price_gross_local_val, SUM(prod_price_gross_local_val) OVER (PARTITION BY CAST(cust_order_sid AS STRING)
      , CAST(bundle_header_pos_nr AS STRING), IF(bundle_header_pos_nr > 0, TRUE, FALSE) RANGE BETWEEN
    UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING))) AS prod_price_gross_bundle_pct
FROM ldl_dig_core.t_fact_customer_order_line AS COL
WHERE is_bundle_header_fg
 OR bundle_header_pos_nr <> 0;