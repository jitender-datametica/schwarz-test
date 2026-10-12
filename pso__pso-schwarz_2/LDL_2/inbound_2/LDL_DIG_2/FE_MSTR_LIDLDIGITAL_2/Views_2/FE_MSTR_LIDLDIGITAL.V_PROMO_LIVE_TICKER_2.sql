CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_PROMO_LIVE_TICKER_2(
    wshop_cd                        COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'
    , prod_variant_sid              COMMENT 'The unique identifier (surrogate key) for the product variant'
    , prod_variant_descr            COMMENT 'The global product variant information in a free text form'
    , brand_class_cd                COMMENT 'The code for the indicating if product is classified as a Lidl own brand_2 or not'
    , delivery_src_type_cd          COMMENT 'The code for source location_2 of product from where it is delivered i.e. from supplier_2 or warehouse directly'
    , prod_org_lvl_name             COMMENT 'The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization.'
    , prod_manager_cd               COMMENT 'A code indentifiyng the product manager. Util we have actual code value we will be using the name of the manager as a code'
    , cust_order_dt                 COMMENT 'The aggregated date when order was made ( when customer created the order )'
    , max_order_create_tmsp         COMMENT 'The max_tmsp when the order was created in source'
    , prod_qty                      COMMENT 'Aggregated quantity of a particular product ordered'
    , prod_price_net_eur_val        COMMENT 'Aggregated original (listed) net price of a product in local currency'
    , cogs_price_net_eur_val        COMMENT 'Aggregated Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs )'
) COMMENT='A view that contains KPIs related to the customer order data from the last 14 days'
AS
WITH bundle_ivp AS
(
SELECT
    col.bundle_header_prod_variant_sid         AS prod_variant_sid
    ,SUM(ppc.price_val * bundle_component_qty) AS ivp_unit_price_net_eur_val
FROM
    lec_share.v_rel_bundle_header_component_core_view_2 AS col
LEFT JOIN
        lec_share.v_fact_product_pricing_condition_2    AS ppc
    ON DATE(CURRENT_DATE) BETWEEN DATE(ppc.active_from_tmsp) AND DATE(ppc.active_to_tmsp)    
    AND ppc.wshop_cd = 'DE'
    AND col.bundle_component_prod_variant_sid = ppc.prod_variant_sid
    AND ppc.price_type_cd ='IVP'
GROUP BY
    col.bundle_header_prod_variant_sid
)
,orders_kpi AS (
SELECT
    wshop_cd
    ,prod_variant_sid
    ,cust_order_dt
    ,MAX(cust_order_create_tmsp)                           AS max_order_create_tmsp 
    ,SUM(prod_qty)                                         AS prod_qty
    ,SUM(prod_price_net_local_val / cer.exchange_rate)     AS prod_price_net_eur_val
    ,SUM(cogs_price_net_local_val / cer.exchange_rate)     AS cogs_price_net_eur_val 
FROM 
    lec_share.v_fact_customer_order_line_2  AS col
LEFT JOIN
    lec_share.v_fact_currency_exchange_rate_2 AS cer
    ON col.cust_order_dt BETWEEN cer.active_from_dt AND cer.active_to_dt
    AND col.curr_cd = cer.from_curr_cd
    AND cer.to_curr_cd = 'EUR'
    AND cer.curr_exchange_rate_type_cd = 'F'
    
WHERE 
        is_part_of_bundle_header_cnt_fg = 'TRUE'
   AND  cust_order_dt > DATEADD(DAY, -365, GETDATE()) --last year excluding today
   AND  wshop_cd ='DE'

GROUP BY
    wshop_cd
    ,prod_variant_sid
    ,cust_order_dt
    
UNION
SELECT
    coll.wshop_cd
    ,coll.prod_variant_sid
    ,coll.cust_order_dt
    ,MAX(TO_TIMESTAMP(CONCAT(cust_order_create_dt,' ', cust_order_create_tm))) AS max_order_create_tmsp 
    ,SUM(prod_qty)                                      AS prod_qty
    ,SUM(prod_price_net_eur_val)                                            AS prod_price_net_eur_val
    ,SUM(CASE WHEN is_bundle_header_fg = 'TRUE' 
              THEN ivp.ivp_unit_price_net_eur_val * prod_qty
              ELSE ppc.price_val * prod_qty END)                            AS cogs_price_net_eur_val 
FROM
    fe_mstr_lidldigital.t_fact_customer_order_line_live_2 coll
LEFT JOIN
    bundle_ivp AS ivp
ON  coll.prod_variant_sid = ivp.prod_variant_sid

LEFT JOIN 
    lec_share.v_fact_product_pricing_condition_2    AS ppc
    ON coll.cust_order_dt  BETWEEN DATE(ppc.active_from_tmsp) AND DATE(ppc.active_to_tmsp)
    AND coll.wshop_cd = ppc.wshop_cd
    AND coll.prod_variant_sid = ppc.prod_variant_sid
    AND ppc.price_type_cd ='IVP'

WHERE 
        coll.is_part_of_bundle_header_cnt_fg = 'TRUE'
   AND  coll.cust_order_dt = DATE(CURRENT_DATE) --only today
   AND  coll.wshop_cd = 'DE'
GROUP BY
    coll.wshop_cd
    ,coll.prod_variant_sid
    ,coll.cust_order_dt
)
SELECT
    col.wshop_cd
    , col.prod_variant_sid
    , pv.prod_variant_descr
    , pv.brand_class_cd
    , pvr.delivery_src_type_cd
    , prod.prod_org_lvl_name
    , prod.prod_manager_cd
    , col.cust_order_dt
    , col.max_order_create_tmsp
    , col.prod_qty
    , col.prod_price_net_eur_val
    , col.cogs_price_net_eur_val
FROM
    orders_kpi AS col
LEFT JOIN lec_share.v_dim_product_variant_2 AS pv
    ON col.prod_variant_sid = pv.prod_variant_sid
    AND pv.dwh_valid_fg = TRUE
LEFT JOIN lec_share.v_rel_product_variant_regional_2 AS pvr --used to get delivery_src_type_cd master_data because in live_ticker table is not present
    ON col.prod_variant_sid = pvr.prod_variant_sid
    AND col.wshop_cd = pvr.wshop_cd
    AND pvr.dwh_valid_fg = TRUE
LEFT JOIN lec_share.v_dim_product_2 AS prod
    ON pv.prod_sid = prod.prod_sid
    AND prod.dwh_valid_fg = TRUE
    ;