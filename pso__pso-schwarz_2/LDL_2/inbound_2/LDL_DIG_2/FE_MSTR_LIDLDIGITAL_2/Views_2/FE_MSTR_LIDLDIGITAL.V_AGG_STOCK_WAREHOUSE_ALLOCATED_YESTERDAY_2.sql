--View that contains previous day values of stock(pc) and stock(ekp) for BM Main Dossier. The information of previous day is not available in the main BM View v_agg_stock_warehouse_daily_allocated_2 which represents only today's and last day of previous month values. For Nagios Monitoring purposes we need previous day values.

CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_AGG_STOCK_WAREHOUSE_ALLOCATED_YESTERDAY_2(
	TOTAL_STOCK_CNT_ALLOCATED
	,TOTAL_STOCK_VAL_ALLOCATED
) AS
SELECT
    SUM(AGG_SWD.TOTAL_STOCK_CNT * FACT_SWAD.DISTRIBUTION_PCT) AS TOTAL_STOCK_CNT_ALLOCATED
    ,SUM(AGG_SWD.TOTAL_STOCK_CNT * FACT_SWAD.DISTRIBUTION_PCT * FACT_PPS.PRICE_VAL) AS TOTAL_STOCK_VAL_ALLOCATED
FROM
    lec_share.v_fact_stock_warehouse_daily_2 AS AGG_SWD
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_CAL_DAY_2 AS CALDAY
	ON 	
        AGG_SWD.CAL_DT = CALDAY.CAL_DT
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_PRODUCT_VARIANT_2 AS DIM_PV
    ON
        DIM_PV.PROD_VARIANT_SID = AGG_SWD.PROD_VARIANT_SID
INNER JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_PRODUCT_2 AS DIM_P
    ON
        DIM_PV.PROD_SID = DIM_P.PROD_SID
INNER JOIN
    lec_share.v_fact_stock_warehouse_allocation_daily_2 AS FACT_SWAD
    ON 
        FACT_SWAD.WH_SID = AGG_SWD.WH_SID
        AND FACT_SWAD.PROD_SID = DIM_PV.PROD_SID
        AND FACT_SWAD.CAL_DT = AGG_SWD.CAL_DT
LEFT JOIN
    lec_share.v_fact_product_price_supplier_2 FACT_PPS
    ON
        FACT_PPS.SUPPLIER_SID = DIM_PV.MAIN_SUPPLIER_SID
        AND FACT_PPS.PROD_VARIANT_SID = DIM_PV.PROD_VARIANT_SID
        AND AGG_SWD.CAL_DT BETWEEN FACT_PPS.ACTIVE_FROM_TMSP AND FACT_PPS.ACTIVE_TO_TMSP
        AND FACT_PPS.WSHOP_CD = 'DE' -- DE buys all articles, see NBI-5097 (we could also use INT with the same result)
        AND FACT_PPS.PRICE_TYPE_CD = 'EKP'
        AND FACT_PPS.CURR_CD = 'EUR'
WHERE                                                        /*Filtering on PROD_MATERIAL_TYPE_CD and PROD_ORG_LVL_NAME to provide a comparable value for the today's stock on Management Summary Page in the Dossier*/
    CALDAY.CAL_DT_OFFSET = -1                                /*Filtering on Previous Day*/
    AND DIM_P.PROD_MATERIAL_TYPE_CD IN ('ZHAW','ZHSB')                
    AND DIM_P.PROD_ORG_LVL_NAME NOT IN ('Spirituosen','Weinwelt')
;