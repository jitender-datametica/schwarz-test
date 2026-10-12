
CREATE OR REPLACE VIEW ldl_dig_fe_mstr_lidldigital.v_promo_live_ticker_1 (wshop_cd
OPTIONS(description='The unique code for the Lidl webshop, where an order can be placed by a customer. The webshop is defined per political country.'),
prod_variant_sid OPTIONS(description='The unique identifier (surrogate key) for the product variant'),
prod_variant_descr OPTIONS(description='The global product variant information in a free text form'), brand_class_cd
OPTIONS(description='The code for the indicating if product is classified as a Lidl own brand_1 or not'),
delivery_src_type_cd
OPTIONS(description='The code for source location_1 of product from where it is delivered i.e. from supplier_1 or warehouse directly'),
prod_org_lvl_name
OPTIONS(description='The Organisation level of a product corresponds to the Lidl Digital structure which owns - or is responsible for - these articles (product variants) in the organization.'),
prod_manager_cd
OPTIONS(description='A code indentifiyng the product manager. Util we have actual code value we will be using the name of the manager as a code'),
cust_order_dt OPTIONS(description='The aggregated date when order was made ( when customer created the order )'),
max_order_create_tmsp OPTIONS(description='The max_tmsp when the order was created in source'), prod_qty
OPTIONS(description='Aggregated quantity of a particular product ordered'), prod_price_net_eur_val
OPTIONS(description='Aggregated original (listed) net price of a product in local currency'), cogs_price_net_eur_val
OPTIONS(description='Aggregated Cost-of-Goods-sold, short: CoGs. Needed for calc of margin (= revenue - cogs )'))
OPTIONS(DESCRIPTION = `A VIEW THAT CONTAINS KPIS RELATED TO THE CUSTOMER ORDER DATA FROM THE LAST 14 DAYS`) AS WITH
 BUNDLE_IVP AS (SELECT COL.bundle_header_prod_variant_sid AS prod_variant_sid,
   SUM(PPC.price_val * COL.bundle_component_qty) AS ivp_unit_price_net_eur_val
  FROM ldl_dig_lec_share.v_rel_bundle_header_component_core_view_1 AS COL
   LEFT JOIN ldl_dig_lec_share.v_fact_product_pricing_condition_1 AS PPC ON DATE(CURRENT_DATE) BETWEEN DATE(PPC.active_from_tmsp
        ) AND (DATE(PPC.active_to_tmsp)) AND PPC.wshop_cd = 'DE' AND COL.bundle_component_prod_variant_sid = PPC.prod_variant_sid
       AND PPC.price_type_cd = 'IVP'
  GROUP BY prod_variant_sid), ORDERS_KPI AS (SELECT COL.wshop_cd,
    COL.prod_variant_sid,
    COL.cust_order_dt,
    MAX(COL.cust_order_create_tmsp) AS max_order_create_tmsp,
    SUM(COL.prod_qty) AS prod_qty,
    SUM(COL.prod_price_net_local_val / CER.exchange_rate) AS prod_price_net_eur_val,
    SUM(COL.cogs_price_net_local_val / CER.exchange_rate) AS cogs_price_net_eur_val
   FROM ldl_dig_lec_share.v_fact_customer_order_line_1 AS COL
    LEFT JOIN ldl_dig_lec_share.v_fact_currency_exchange_rate_1 AS CER ON COL.cust_order_dt BETWEEN CER.active_from_dt AND
        CER.active_to_dt AND COL.curr_cd = CER.from_curr_cd AND CER.to_curr_cd = 'EUR' AND CER.curr_exchange_rate_type_cd
       = 'F'
   WHERE COL.is_part_of_bundle_header_cnt_fg
    AND COL.cust_order_dt > CAST(CURRENT_TIMESTAMP() + INTERVAL 1 DAY * - 365 AS DATE)
    AND COL.wshop_cd = 'DE'
   GROUP BY COL.wshop_cd,
    COL.prod_variant_sid,
    COL.cust_order_dt
   UNION DISTINCT
   SELECT COLL.wshop_cd,
    COLL.prod_variant_sid,
    COLL.cust_order_dt,
    CAST(MAX(PARSE_DATETIME('%F %H:%M:%S', CONCAT(COLL.cust_order_create_dt, ' ', COLL.cust_order_create_tm)))AS TIMESTAMP) AS
    max_order_create_tmsp,
    SUM(COLL.prod_qty) AS prod_qty,
    SUM(COLL.prod_price_net_eur_val) AS prod_price_net_eur_val,
    SUM(CASE
      WHEN COLL.is_bundle_header_fg
      THEN ivp.ivp_unit_price_net_eur_val * COLL.prod_qty
      ELSE PPC0.price_val * COLL.prod_qty
      END) AS cogs_price_net_eur_val
   FROM ldl_dig_fe_mstr_lidldigital.t_fact_customer_order_line_live_1 AS COLL
    LEFT JOIN BUNDLE_IVP AS ivp ON COLL.prod_variant_sid = ivp.prod_variant_sid
    LEFT JOIN ldl_dig_lec_share.v_fact_product_pricing_condition_1 AS PPC0 ON COLL.cust_order_dt BETWEEN DATE(PPC0.active_from_tmsp
         ) AND (DATE(PPC0.active_to_tmsp)) AND COLL.wshop_cd = PPC0.wshop_cd AND COLL.prod_variant_sid = PPC0.prod_variant_sid
        AND PPC0.price_type_cd = 'IVP'
   WHERE COLL.is_part_of_bundle_header_cnt_fg
    AND COLL.cust_order_dt = DATE(CURRENT_DATE) -- only today

    AND COLL.wshop_cd = 'DE'
   GROUP BY COLL.wshop_cd,
    COLL.prod_variant_sid,
    COLL.cust_order_dt) (-- last year excluding today

  -- used to get delivery_src_type_cd master_data because in live_ticker table is not present
 SELECT col.wshop_cd,
   col.prod_variant_sid,
   PV.prod_variant_descr,
   PV.brand_class_cd,
   PVR.delivery_src_type_cd,
   PROD.prod_org_lvl_name,
   PROD.prod_manager_cd,
   col.cust_order_dt,
   col.max_order_create_tmsp,
   col.prod_qty,
   col.prod_price_net_eur_val,
   col.cogs_price_net_eur_val
  FROM ORDERS_KPI AS col
   LEFT JOIN ldl_dig_lec_share.v_dim_product_variant_1 AS PV ON col.prod_variant_sid = PV.prod_variant_sid AND PV.dwh_valid_fg
    
   LEFT JOIN ldl_dig_lec_share.v_rel_product_variant_regional_1 AS PVR ON col.prod_variant_sid = PVR.prod_variant_sid AND
      col.wshop_cd = PVR.wshop_cd AND PVR.dwh_valid_fg
   LEFT JOIN ldl_dig_lec_share.v_dim_product_1 AS PROD ON PV.prod_sid = PROD.prod_sid AND PROD.dwh_valid_fg);


