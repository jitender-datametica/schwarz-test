
/*
USE ROLE            R_LDL_D_PIT_ETL;
USE WAREHOUSE       WH_LDL_D_PIT_ETL_S;
USE DATABASE        LDL_PRODUCTION_CLONE_PIT_R51501;
USE SCHEMA          P_LEW_MART_PIT_2;
*/
/*
---------------------------------------------------------------------
Function    :   f_GetLPPrice(INTEGER)
Input       :     ORIG_COUPON_TYPE_SID INTEGER,
				, COUPON_PROMO_TYPE_SID INTEGER,
				, ORIG_ITEM_PRICE NUMBER,
				, COUPON_REDUCED_SALES_PRICE  NUMBER,
				, COUPON_DISCOUNT_VAL  NUMBER,
				, COUPON_DISCOUNT_PCT  NUMBER,
				, COUPON_DISCOUNT_X_CNT  INTEGER,
				, COUPON_DISCOUNT_Y_CNT  INTEGER
Return      :   LP_ITEM_PRICE VARCHAR
Convert     :   None
TYPE		:	SQL-Function - single scalar
Description :   Calculation of the price of the item_2 with LP-discounts
Examples    :   
------------------------------------------------------------------------
*/

CREATE OR REPLACE FUNCTION ldl_p_lew_mart_pit.f_getlpprice(
    orig_coupon_type_sid INT64,
    coupon_promo_type_sid INT64,
    orig_item_price NUMERIC,
    coupon_reduced_sales_price NUMERIC,
    coupon_discount_val NUMERIC,
    coupon_discount_pct NUMERIC,
    coupon_discount_x_cnt INT64,
    coupon_discount_y_cnt INT64
)
RETURNS NUMERIC
AS (
    --	we use the following logic to find the new price: 
    --		1) if a new price is specified, we take it
    IF(
        coupon_reduced_sales_price IS NOT NULL,
        coupon_reduced_sales_price,
        --		2) if an absolute discount is specified, we find the original price and apply the discount
        IF(
            coupon_discount_val IS NOT NULL,
            ROUND(orig_item_price - coupon_discount_val, 2),
            --		3) in all other cases, we find the price based on the basis and the discount applied
            IF(
                coupon_discount_pct IS NOT NULL,
                FLOOR(orig_item_price * (1 - coupon_discount_pct / 100) * 100) / 100,
                --		4) if promotions "StoreXforY" are used, we calculate the new price using the proportion
                IF(
                    coupon_discount_x_cnt IS NOT NULL AND coupon_discount_y_cnt IS NOT NULL,
                    FLOOR(
                        IF(coupon_discount_y_cnt = 0, 0, orig_item_price * coupon_discount_x_cnt / coupon_discount_y_cnt) * 100) / 100,
                    -- 		5) 	If the calculation cannot be done, we return the original cost				
                    orig_item_price
                )
            )
        )
    )
); -- End of f_GetLPPrice


/* 
---------------------------------------------------------------------
999. Testing / DQ
---------------------------------------------------------------------
*/

/*
select P_LEW_MART_PIT.f_GetLPPrice(23
				, 7
				, 0.29
				, NULL
				, NULL
				, NULL
				, 16
				, 18); --> 0.25




SELECT '>>> ${EXEC_PIT_TIMESTAMP} | EOF [f_GetLPPrice]' AS ""
;
*/

/* --- EOF - END OF FILE --- */