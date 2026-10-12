CREATE OR REPLACE VIEW CORE.V_AGG_SALES_PROMOTION_PLAN_WEEKLY_2(
	WSHOP_CD COMMENT 'The unique code for the Lidl webshop, where an order can be placed by a customer.The webshop is defined per political country_2 and is run by an Lidl Digital Country_2',
	PROD_SID COMMENT 'The unique identifier (surrogate key) for the product',
	PROMO_ID COMMENT 'An identifier from source system to uniqly identify the promotion',
	PROMO_DUR_WEEK_CNT COMMENT 'How long was the promotion planned to be active (number of weeks)',
	PROMO_START_DT COMMENT 'Start date of the product promotion in stationary business',
	PROMO_SALE_START_DT COMMENT 'Date when sales_2 of promotional goods starts',
	SUPPLIER_ORDER_QTY COMMENT 'Number of products ordered from suppliers. If it is zero, it means that nothing was ordered because there is still stock available from another promotion',
	TGT_PROD_SALE_QTY COMMENT 'Number of products expected to be sold. Product quantities in stock units (no decimal values)',
	ESTIMATED_INIT_PROMO_STOCK COMMENT 'Estimated initial promotional stock',
	CURRENT_PROMO_WEEK_NR COMMENT 'Current week number since the promotion sale start date',
	WEEK_NR COMMENT 'For each promotion week, and depending on the promotion duration, there is a planned percentage of units to be sold',
	PROMO_SALE_CLUSTER_CD COMMENT 'A code for aggregation of sales_2 orders assigned to a promotion based on the customer order date',
	TGT_SALE_PCT COMMENT 'Planned percentage of units sold for each promotion week',
	CUM_TGT_SALE_PCT COMMENT 'Cumulative planned percentage of units sold for each promotion week',
	SALE_PROMO_PHASE_CD COMMENT 'The phase can be either A (Aktion_2) which corresponds to the first three week of a promotion, or N (Nachlauf) if it is refering to the remaining weeks - after-promotion phase',
	PLAN_AMC_QTY COMMENT 'Planned quantity of units solds for each promotion week',
	PLAN_AMC_PERC COMMENT 'Planned percentage of units sold for each promotion week',
	PLAN_AMC_QTY_CUM COMMENT 'Cumulative Planned quantity of units solds for each promotion week',
	PLAN_AMC_CUM_PERC COMMENT 'Cumulative planned percentage of units sold for each promotion week',
	PLAN_AB_QTY COMMENT 'Planned quantity of units solds for each promotion week based on estimated initial promotional stock',
	PLAN_AB_PERC COMMENT 'Planned percentage of units sold for each promotion week based on estimated initial promotional stock',
	PLAN_AB_QTY_CUM COMMENT 'Cumulative Planned quantity of units solds for each promotion week based on estimated initial promotional stock',
	PLAN_AB_CUM_PERC COMMENT 'Cumulative planned percentage of units sold for each promotion week based on estimated initial promotional stock',
    IS_CURRENT_FG COMMENT 'Flag that indicates the current_week of the promotion'
) COMMENT='Calculation of plan values for each promotion for each week of the promotion'
 AS
WITH INIT_PROMO_STOCK AS
(SELECT
    PROD_SID,
    PROMO_ID,
    SUM(ESTIMATED_INIT_PROMO_STOCK) AS ESTIMATED_INIT_PROMO_STOCK
FROM
    CORE.V_AGG_ESTIMATED_INITIAL_PROMOTION_STOCK_2
GROUP BY
    PROD_SID,
    PROMO_ID
    )
SELECT
    PROMO.WSHOP_CD,
    PROMO.PROD_SID,
    PROMO.PROMO_ID,
    PROMO.PROMO_DUR_WEEK_CNT,
    PROMO.PROMO_START_DT,
    PROMO.PROMO_SALE_START_DT,
    PROMO.SUPPLIER_ORDER_QTY,
    PROMO.TGT_PROD_SALE_QTY,
    STOCK.ESTIMATED_INIT_PROMO_STOCK,
    CEIL((DATE(GETDATE()) - PROMO.PROMO_SALE_START_DT)/7) AS CURRENT_PROMO_WEEK_NR,
    TGT.WEEK_NR,
    REL.PROMO_SALE_CLUSTER_CD,
    TGT.TGT_SALE_PCT,
    TGT.CUM_TGT_SALE_PCT,
    TGT.SALE_PROMO_PHASE_CD,
    
    --APPLY THE SAME LOGIC ON AMC AS FOR ANFANGSBESTAND
    
    CASE WHEN SALE_PROMO_PHASE_CD = 'A'
        THEN ROUND(PROMO.TGT_PROD_SALE_QTY * TGT_SALE_PCT,0)
    WHEN PROMO.SUPPLIER_ORDER_QTY > PROMO.TGT_PROD_SALE_QTY 
        THEN ROUND(((PROMO.SUPPLIER_ORDER_QTY - PROMO.TGT_PROD_SALE_QTY)*TGT_SALE_PCT),0)
        ELSE 0
    END AS PLAN_AMC_QTY,    
        
    CASE WHEN PROMO.SUPPLIER_ORDER_QTY > PROMO.TGT_PROD_SALE_QTY
        THEN  ROUND(DIV0(PLAN_AMC_QTY,PROMO.SUPPLIER_ORDER_QTY),2) 
        ELSE ROUND(DIV0(PLAN_AMC_QTY,PROMO.TGT_PROD_SALE_QTY),2)
    END AS PLAN_AMC_PERC,
    
    CASE WHEN SALE_PROMO_PHASE_CD = 'A'
        THEN ROUND(PROMO.TGT_PROD_SALE_QTY * CUM_TGT_SALE_PCT,0)
    WHEN PROMO.SUPPLIER_ORDER_QTY > PROMO.TGT_PROD_SALE_QTY 
        THEN ROUND(((PROMO.SUPPLIER_ORDER_QTY - PROMO.TGT_PROD_SALE_QTY)*CUM_TGT_SALE_PCT) + TGT_PROD_SALE_QTY,0)
        ELSE ROUND(TGT_PROD_SALE_QTY,0)
    END AS PLAN_AMC_QTY_CUM,
    
    CASE WHEN PROMO.SUPPLIER_ORDER_QTY > PROMO.TGT_PROD_SALE_QTY
        THEN ROUND(DIV0(PLAN_AMC_QTY_CUM,PROMO.SUPPLIER_ORDER_QTY),2) 
        ELSE ROUND(DIV0(PLAN_AMC_QTY_CUM,PROMO.TGT_PROD_SALE_QTY),2) 
    END AS PLAN_AMC_CUM_PERC,
    

    CASE WHEN SALE_PROMO_PHASE_CD = 'A'
        THEN ROUND(PROMO.TGT_PROD_SALE_QTY * TGT_SALE_PCT,0)
    WHEN STOCK.ESTIMATED_INIT_PROMO_STOCK > PROMO.TGT_PROD_SALE_QTY 
        THEN ROUND(((STOCK.ESTIMATED_INIT_PROMO_STOCK - PROMO.TGT_PROD_SALE_QTY)*TGT_SALE_PCT),0)
        ELSE 0
    END AS PLAN_AB_QTY,

    CASE WHEN STOCK.ESTIMATED_INIT_PROMO_STOCK > PROMO.TGT_PROD_SALE_QTY
        THEN ROUND(DIV0(PLAN_AB_QTY,STOCK.ESTIMATED_INIT_PROMO_STOCK),2)
        ELSE ROUND(DIV0(PLAN_AB_QTY,PROMO.TGT_PROD_SALE_QTY),2)
        END AS PLAN_AB_PERC,
    
    CASE WHEN SALE_PROMO_PHASE_CD = 'A'
        THEN ROUND(PROMO.TGT_PROD_SALE_QTY * CUM_TGT_SALE_PCT,0)
    WHEN STOCK.ESTIMATED_INIT_PROMO_STOCK > PROMO.TGT_PROD_SALE_QTY
        THEN ROUND(((STOCK.ESTIMATED_INIT_PROMO_STOCK - PROMO.TGT_PROD_SALE_QTY)*CUM_TGT_SALE_PCT) + TGT_PROD_SALE_QTY,0)
        ELSE ROUND(TGT_PROD_SALE_QTY,0)
    END AS PLAN_AB_QTY_CUM,
    
    CASE WHEN STOCK.ESTIMATED_INIT_PROMO_STOCK > PROMO.TGT_PROD_SALE_QTY
        THEN ROUND(DIV0(PLAN_AB_QTY_CUM,STOCK.ESTIMATED_INIT_PROMO_STOCK),2)
        ELSE ROUND(DIV0(PLAN_AB_QTY_CUM,PROMO.TGT_PROD_SALE_QTY),2)
        END AS PLAN_AB_CUM_PERC,
        
    CASE WHEN CURRENT_PROMO_WEEK_NR = TGT.WEEK_NR THEN TRUE
         WHEN CURRENT_PROMO_WEEK_NR > TGT.WEEK_NR AND TGT.WEEK_NR = MAX(TGT.WEEK_NR) OVER (PARTITION BY PROMO.PROMO_ID) THEN TRUE
    ELSE FALSE
    END AS IS_CURRENT_FG

FROM
    CORE.V_AGG_SALES_PROMOTION_2 PROMO
JOIN
    CORE.T_FACT_SALES_PROMOTION_WEEK_TARGET_2 TGT
    ON      PROMO.WSHOP_CD = TGT.WSHOP_CD
        AND PROMO.PROMO_DUR_WEEK_CNT = TGT.PROMO_DUR_WEEK_CNT
        AND PROMO.PROMO_START_DT BETWEEN DATE(TGT.DWH_VALID_FROM_TMSP) AND DATE(TGT.DWH_VALID_TO_TMSP)
JOIN
    INIT_PROMO_STOCK STOCK
    ON  PROMO.PROMO_ID = STOCK.PROMO_ID
LEFT JOIN  
    CORE.T_REL_PROMOTION_SALES_CLUSTER_WEEK_2 REL
    ON  TGT.WEEK_NR = REL.WEEK_NR
WHERE   
        TGT.TGT_SALE_PCT != 0
    AND CURRENT_PROMO_WEEK_NR > 0
;