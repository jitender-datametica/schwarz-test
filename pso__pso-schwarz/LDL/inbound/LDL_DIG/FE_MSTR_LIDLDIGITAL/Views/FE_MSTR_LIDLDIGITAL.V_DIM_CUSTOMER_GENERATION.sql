CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_DIM_CUSTOMER_GENERATION(
	CUST_GENERATION_CD
	,CUST_GENERATION_DESCR
	,GENERATION_START_CY
	,GENERATION_END_CY
) AS SELECT
    cust_generation_cd 
    ,cust_generation_descr
    ,generation_start_cy
    ,generation_end_cy
FROM 
lec_share.v_dim_customer_generation
UNION
    SELECT
         '-1' -- CUST_GENERATION_CD
        ,''   -- CUST_GENERATION_DESCR
        ,'-1' -- GENERATIION_START_CY
        ,'-1' -- GENERATION_END_CY
;