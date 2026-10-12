CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_GROUP_ARTICLE_ORDER_RETURN_LINE
(
    wshop_cd 
    , cust_order_dt
    , cust_order_tm
    , cust_order_nr
    , cust_order_pos_nr
    , group_header_prod_sid
    , group_header_prod_nr
    , prod_variant_sid
    , prod_variant_nr
    , prod_nr
    , prod_qty
    , curr_cd
    , gc_lc_cd
    , prod_price_net_val
    , prod_price_net_eur_val
    , prod_price_net_local_val
    , prod_price_gross_val
    , prod_price_gross_eur_val
    , prod_price_gross_local_val
    , prod_price_vat_val
    , prod_price_vat_eur_val
    , prod_price_vat_local_val
    , ivp_price_net_val
    , ivp_price_net_eur_val
    , ivp_price_net_local_val
    , cogs_price_net_val
    , cogs_price_net_eur_val
    , cogs_price_net_local_val
    , tax_class_cd
    , is_order_cancel_fg
    , cust_order_type_cd
    , sales_segment_type_cd
	, group_component_base_qty
    , cust_order_return_dt
    , cust_order_return_nr
    , cust_order_return_pos_nr
    , cust_order_return_tm
    , prod_return_reason_cd
    , order_return_reason_cd
    , return_prod_qty    
    , return_prod_price_net_val
    , return_prod_price_net_eur_val
    , return_prod_price_net_local_val    
    , return_prod_price_gross_val
    , return_prod_price_gross_eur_val
    , return_prod_price_gross_local_val    
    , return_prod_price_vat_val
    , return_prod_price_vat_eur_val
    , return_prod_price_vat_local_val           
    , return_ivp_price_net_val
    , return_ivp_price_net_eur_val
    , return_ivp_price_net_local_val  
) 
AS
WITH
    cte_keys AS (   -- Select only group article sales & returns
        SELECT
            cust_order_sid
            , cust_order_pos_nr
            , IFF( bundle_header_pos_nr > 0, TRUE, FALSE )                                                                                                                          AS is_bundle_component_fg

    -- Flattening the table & group article hierarchy, by adding group header information on component lines
        
            , FIRST_VALUE( prod_sid ) OVER ( PARTITION BY cust_order_nr, IFF( is_bundle_header_fg = 1, cust_order_pos_nr, bundle_header_pos_nr ) ORDER BY cust_order_pos_nr ASC )   AS group_header_prod_sid
            , FIRST_VALUE( prod_nr ) OVER ( PARTITION BY cust_order_nr, IFF( is_bundle_header_fg = 1, cust_order_pos_nr, bundle_header_pos_nr ) ORDER BY cust_order_pos_nr ASC )    AS group_header_prod_nr
			, FIRST_VALUE( prod_qty ) OVER ( PARTITION BY cust_order_nr, IFF( is_bundle_header_fg = 1, cust_order_pos_nr, bundle_header_pos_nr ) ORDER BY cust_order_pos_nr ASC ) 	AS group_header_qty
        FROM
            lec_share.v_fact_customer_order_line
        WHERE
            (is_bundle_header_fg = 1 OR bundle_header_pos_nr > 0)    
    )

SELECT

/* ORDERS DATA */ 

    v1.wshop_cd                                 AS wshop_cd 
    , v1.cust_order_dt                          AS cust_order_dt
    , v1.cust_order_tm                          AS cust_order_tm
    , v1.cust_order_nr                          AS cust_order_nr
    , v0.cust_order_pos_nr                      AS cust_order_pos_nr
    , v0.group_header_prod_sid                  AS group_header_prod_sid
    , v0.group_header_prod_nr                   AS group_header_prod_nr
    , v1.prod_variant_sid                       AS prod_variant_sid
    , v1.prod_variant_nr                        AS prod_variant_nr
    , v1.prod_nr                                AS prod_nr
    , v1.prod_qty                               AS prod_qty
    , v1.curr_cd                                AS curr_cd
    , v1.gc_lc_cd                               AS gc_lc_cd
    , v1.prod_price_net_val                     AS prod_price_net_val
    , v1.prod_price_net_eur_val                 AS prod_price_net_eur_val
    , v1.prod_price_net_local_val               AS prod_price_net_local_val
    , v1.prod_price_gross_val                   AS prod_price_gross_val
    , v1.prod_price_gross_eur_val               AS prod_price_gross_eur_val
    , v1.prod_price_gross_local_val             AS prod_price_gross_local_val
    , v1.prod_price_vat_val                     AS prod_price_vat_val
    , v1.prod_price_vat_eur_val                 AS prod_price_vat_eur_val
    , v1.prod_price_vat_local_val               AS prod_price_vat_local_val
    , v1.ivp_price_net_val                      AS ivp_price_net_val
    , v1.ivp_price_net_eur_val                  AS ivp_price_net_eur_val
    , v1.ivp_price_net_local_val                AS ivp_price_net_local_val
    , v1.cogs_price_net_val                     AS cogs_price_net_val
    , v1.cogs_price_net_eur_val                 AS cogs_price_net_eur_val
    , v1.cogs_price_net_local_val               AS cogs_price_net_local_val
    , v1.tax_class_cd                           AS tax_class_cd
    , v1.is_order_cancel_fg                     AS is_order_cancel_fg
    , v1.cust_order_type_cd                     AS cust_order_type_cd
    , v1.sales_segment_type_cd                  AS sales_segment_type_cd
	, DIV0( v1.prod_qty, v0.group_header_qty ) 	AS group_component_base_qty
    
/* RETURNS DATA */

    , v2.cust_order_return_dt                   AS cust_order_return_dt
    , v2.cust_order_return_nr                   AS cust_order_return_nr
    , v2.cust_order_return_pos_nr               AS cust_order_return_pos_nr
    , v2.cust_order_return_tm                   AS cust_order_return_tm
    , v2.prod_return_reason_cd                  AS prod_return_reason_cd
    , v2.order_return_reason_cd                 AS order_return_reason_cd
    , v2.return_prod_qty                        AS return_prod_qty    
    , v2.return_prod_price_net_val              AS return_prod_price_net_val
    , v2.return_prod_price_net_eur_val          AS return_prod_price_net_eur_val
    , v2.return_prod_price_net_local_val        AS return_prod_price_net_local_val    
    , v2.return_prod_price_gross_val            AS return_prod_price_gross_val
    , v2.return_prod_price_gross_eur_val        AS return_prod_price_gross_eur_val
    , v2.return_prod_price_gross_local_val      AS return_prod_price_gross_local_val    
    , v2.return_prod_price_vat_val              AS return_prod_price_vat_val
    , v2.return_prod_price_vat_eur_val          AS return_prod_price_vat_eur_val
    , v2.return_prod_price_vat_local_val        AS return_prod_price_vat_local_val           
    , v2.return_ivp_price_net_val               AS return_ivp_price_net_val
    , v2.return_ivp_price_net_eur_val           AS return_ivp_price_net_eur_val
    , v2.return_ivp_price_net_local_val         AS return_ivp_price_net_local_val       
    
FROM
    cte_keys                                                    AS v0

LEFT JOIN
    fe_mstr_lidldigital.v_fact_customer_order_line              AS v1       ON v0.cust_order_sid = v1.cust_order_sid
                                                                            AND v0.cust_order_pos_nr = v1.cust_order_pos_nr
LEFT JOIN
    (SELECT
        cust_order_sid
        ,cust_order_pos_nr
        ,gc_lc_cd
        ,MIN(cust_order_return_dt)                   AS cust_order_return_dt
        ,MIN(cust_order_return_nr)                   AS cust_order_return_nr
        ,MIN(cust_order_return_pos_nr)               AS cust_order_return_pos_nr
        ,MIN(cust_order_return_tm)                   AS cust_order_return_tm
        ,MIN(prod_return_reason_cd)                  AS prod_return_reason_cd
        ,MIN(order_return_reason_cd)                 AS order_return_reason_cd
        ,SUM(return_prod_qty)                        AS return_prod_qty    
        ,SUM(return_prod_price_net_val)              AS return_prod_price_net_val
        ,SUM(return_prod_price_net_eur_val)          AS return_prod_price_net_eur_val
        ,SUM(prod_price_net_local_val)               AS return_prod_price_net_local_val 
        ,SUM(return_prod_price_gross_val)            AS return_prod_price_gross_val
        ,SUM(return_prod_price_gross_eur_val)        AS return_prod_price_gross_eur_val
        ,SUM(prod_price_gross_local_val)             AS return_prod_price_gross_local_val
        ,SUM(return_prod_price_vat_val)              AS return_prod_price_vat_val
        ,SUM(return_prod_price_vat_eur_val)          AS return_prod_price_vat_eur_val
        ,SUM(prod_price_vat_local_val)               AS return_prod_price_vat_local_val 
        ,SUM(ivp_price_net_val)                      AS return_ivp_price_net_val
        ,SUM(ivp_price_net_eur_val)                  AS return_ivp_price_net_eur_val
        ,SUM(ivp_price_net_local_val)                AS return_ivp_price_net_local_val  
    FROM
        fe_mstr_lidldigital.v_fact_customer_order_line_return
    GROUP BY
        cust_order_sid
        ,cust_order_pos_nr
        ,gc_lc_cd                                   )            AS v2       ON v0.cust_order_sid = v2.cust_order_sid
                                                                            AND v0.cust_order_pos_nr = v2.cust_order_pos_nr
                                                                            AND v1.gc_lc_cd = v2.gc_lc_cd
WHERE
    v0.is_bundle_component_fg = 1
;