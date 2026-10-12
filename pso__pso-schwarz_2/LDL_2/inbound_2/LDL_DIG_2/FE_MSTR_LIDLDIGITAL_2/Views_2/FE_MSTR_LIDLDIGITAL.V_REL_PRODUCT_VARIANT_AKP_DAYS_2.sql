CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_REL_PRODUCT_VARIANT_AKP_DAYS_2(
	WSHOP_CD
	,PROD_VARIANT_SID
	,CAL_DT
) AS
    SELECT 
            WSHOP_CD
            ,PROD_VARIANT_SID
            ,CAL_DT
    FROM
        lec_share.v_fact_product_pricing_condition_2
        JOIN 
            lec_share.v_dim_cal_day_2
            ON  CAL_DT BETWEEN TO_DATE(ACTIVE_FROM_TMSP) AND TO_DATE(ACTIVE_TO_TMSP)
                AND PRICE_TYPE_CD = 'AKP'
                AND CAL_DT_OFFSET < 0 --for meaningful comparison with V_FACT_CUSTOMER_ORDER_LINE_2 data
				;