CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_ORDER_SALES_DAILY_1 (
    wshop_cd
    , cal_dt
    , prod_sale_type_cd
    , cust_order_sid
    , cancel_cust_order_sid
    , after_cancel_cust_order_sid
    , prod_sid
    , prod_assortment_class_cd
    , prod_family_cd
    , prod_food_class_cd
    , brand_class_cd
    , brand_nr
    , prod_org_lvl_name    
    , prod_manager_cd
    , prod_subgroup_cd
    , prod_group_ldt_cd
    , delivery_src_type_cd 
) AS
SELECT DISTINCT
    col.wshop_cd
    , cust_order_dt AS cal_dt
    , prod_sale_type_cd
    , cust_order_sid
    , CASE WHEN is_order_cancel_fg = 1 THEN cust_order_sid ELSE NULL END AS cancel_cust_order_sid
    , CASE WHEN is_order_cancel_fg = 0 THEN cust_order_sid ELSE NULL END AS after_cancel_cust_order_sid
    , col.prod_sid
    , prd.prod_assortment_class_cd
    , prd.prod_family_cd
    , prd.prod_food_class_cd
    , prd.brand_class_cd
    , prd.brand_nr
    , prd.prod_org_lvl_name    
    , prd.prod_manager_cd
    , prd.prod_subgroup_cd
    , prd.prod_group_ldt_cd
    , reg.delivery_src_type_cd 
FROM
    lec_share.v_fact_customer_order_line_1 col
LEFT JOIN 
    lec_share.v_dim_product_1 prd
    ON col.prod_sid = prd.prod_sid
    AND prd.dwh_valid_fg
LEFT JOIN lec_share.v_rel_product_regional_1 reg
    ON prd.prod_sid = reg.prod_sid
    AND reg.wshop_cd = col.wshop_cd
    AND reg.dwh_valid_fg
WHERE
    cust_order_dt >= '2019-01-01'
;