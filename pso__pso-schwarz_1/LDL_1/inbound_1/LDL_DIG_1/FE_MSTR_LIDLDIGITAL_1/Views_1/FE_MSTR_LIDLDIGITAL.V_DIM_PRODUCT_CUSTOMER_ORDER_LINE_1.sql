CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_PRODUCT_CUSTOMER_ORDER_LINE_1
/*
    Aggregates information from T_FACT_CUSTOMER_ORDER_LINE_1 by PROD_SID.
    Can be extended with additional aggregations (e.g. MIN(CUST_ORDER_DT) AS MIN_CUST_ORDER_DT).
*/
AS SELECT
     PROD_SID AS PROD_SID
    ,MAX(CUST_ORDER_DT) MAX_CUST_ORDER_DT
FROM
    lec_share.v_fact_customer_order_line_1
GROUP BY
    PROD_SID
;
