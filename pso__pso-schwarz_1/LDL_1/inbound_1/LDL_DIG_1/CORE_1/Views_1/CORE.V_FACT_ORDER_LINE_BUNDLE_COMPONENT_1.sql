CREATE OR REPLACE VIEW CORE.v_fact_order_line_bundle_component_1
    (
     CUST_ORDER_SID                  COMMENT 'The unique identifier (surrogate key) for customer order'
     ,CUST_ORDER_POS_NR              COMMENT 'The particular position number of an item_1 in an order'
     ,BUNDLE_HEADER_PROD_VARIANT_SID COMMENT 'Unique Identifier for the product variant of the bundle header to which this bundle item_1 belongs'
     ,BUNDLE_HEADER_PROD_VARIANT_NR  COMMENT 'The product variant number of the bundle-header to which this bundle item_1 belongs'
     ,PROD_VARIANT_SID               COMMENT 'Unique identifier (surrogate key) of the ordered/returned product'
     ,PROD_VARIANT_NR                COMMENT 'The product variant number'
     ,IS_BUNDLE_COMPONENT_FG         COMMENT 'Set as true for bundle position and false for bundle header item_1 '
     ,PROD_PRICE_GROSS_LOCAL_VAL     COMMENT 'Original (listed) gross price of a product in local currency' 
     ,PROD_PRICE_GROSS_BUNDLE_PCT    COMMENT 'Percentage Weight of the item_1 on the original (listed) gross price of the bundle in local currency'
     ) 
    COMMENT = 'One row for each bundle-order position, with the associate bundle-header product and the percentage weight of each item_1 on the bundle'
AS 
    SELECT
        cust_order_sid
        ,cust_order_pos_nr
        ,FIRST_VALUE(col.prod_variant_sid)  OVER ( PARTITION BY col.cust_order_sid, IFF( col.is_bundle_header_fg = 1, col.cust_order_pos_nr, col.bundle_header_pos_nr ) ORDER BY col.cust_order_pos_nr ASC )             AS bundle_header_prod_variant_sid --get the bundle_header for components   
        ,FIRST_VALUE(col.prod_variant_nr)  OVER ( PARTITION BY col.cust_order_sid, IFF( col.is_bundle_header_fg = 1, col.cust_order_pos_nr, col.bundle_header_pos_nr ) ORDER BY col.cust_order_pos_nr ASC )              AS bundle_header_prod_variant_nr
        ,col.prod_variant_sid
        ,col.prod_variant_nr
        ,IFF( bundle_header_pos_nr > 0, TRUE, FALSE )    AS is_bundle_component_fg  --flag to identify components
        ,col.prod_price_gross_local_val
        ,DIV0(prod_price_gross_local_val, SUM(prod_price_gross_local_val) OVER (PARTITION BY cust_order_sid, bundle_header_pos_nr, is_bundle_component_fg)) AS prod_price_gross_bundle_pct  --in case it is a component, it calculates the percentage weight of the item_1 on the total bundle
    FROM 
        CORE.t_fact_customer_order_line_1 AS col    
    WHERE 
        (col.is_bundle_header_fg = '1' OR bundle_header_pos_nr != '0') --filter to get only bundles positions within orders
;