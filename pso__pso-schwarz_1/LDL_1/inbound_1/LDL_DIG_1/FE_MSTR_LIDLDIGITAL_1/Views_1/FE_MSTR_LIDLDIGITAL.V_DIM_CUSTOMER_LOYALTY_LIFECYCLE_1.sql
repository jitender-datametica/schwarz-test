CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_CUSTOMER_LOYALTY_LIFECYCLE_1(
	CUST_LOYALTY_LIFECYCLE_CD
	, CUST_LOYALTY_LIFECYCLE_DESCR
) AS SELECT
    CASE WHEN cust_loyalty_lifecycle_cd = '' THEN '-1' ELSE IFNULL(cust_loyalty_lifecycle_cd, '-1') END  AS CUST_LOYALTY_LIFECYCLE_CD
    ,cust_loyalty_lifecycle_descr                                                              AS CUST_LOYALTY_LIFECYCLE_DESCR
FROM
    lec_share.v_dim_customer_loyalty_lifecycle_1
UNION
    SELECT
        '-1' -- CUST_LOYALTY_LIFECYCLE_CD
        ,''   -- CUST_LOYALTY_LIFECYCLE_DESCR
;