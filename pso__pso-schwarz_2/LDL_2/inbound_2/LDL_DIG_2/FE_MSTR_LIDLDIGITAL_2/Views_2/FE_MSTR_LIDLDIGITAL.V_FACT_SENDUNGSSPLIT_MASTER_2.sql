CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_SENDUNGSSPLIT_MASTER_2
COMMENT='
2024-10-23_LCI-217: 
- FACT_COL CTE: removed prod_qty,cy_week_offset, inner join with cal_day, where condition on CY_WEEK_OFFSET BETWEEN -57 AND 0
- FACT_ICOL CTE: removed prod_qty,cy_week_offset, inner join with cal_day, where condition on CY_WEEK_OFFSET BETWEEN -57 AND 0
- COL_HELPER_FIELDS CTE: removed inner join with cal_day, where condition on CY_WEEK_OFFSET BETWEEN -57 AND 0
- ICOL_HELPER_FIELDS CTE: removed inner join with cal_day, where condition on CY_WEEK_OFFSET BETWEEN -57 AND 0
- Final Select: added REL_OP.PACK_ORDER_NR, REL_OP.PACK_POS_NR, REL_OP.PROD_VARIANT_SID, FACT_SPS.PACK_MATERIAL_NR, IS_SINGLE_POSITION_WH, PROD_VARIANT_PACKING_TYPE_MPO_FG
- Final Select: removed MAX() because we are now in lowest granularity, increased granularity because of users need (Doris Gampper) to make EPO/MPO distinction and to display data on variant level
- Deleted FACT_ICOL.CY_WEEK_OFFSET BETWEEN -57 AND 0 /FACT_COL.CY_WEEK_OFFSET BETWEEN -57 AND 0 from final WHERE because the filter is implemented in MSTR cube
2025-01-20 ABA
-deleted not needed joins to ctes (t_fact_customer_order_line_2 and t_fact_intercompany_order_line_2)
-deleted is_single_position_fg & is_cancel_fg: both are not used in frontend
'
AS

SELECT 
    
    COALESCE(FACT_SPS.WSHOP_CD,'-1')                                                                                             AS WSHOP_CD
   ,FACT_SPS.DIST_CHANNEL_CD                                                                                                    AS DIST_CHANNEL_CD
   ,FACT_SPS.WH_SID                                                                                                            AS WH_SID
   ,FACT_SPS.PACK_ORDER_NR                                                                                                            AS PACK_ORDER_NR
   ,REL_OP.PACK_POS_NR                                                                                                                AS PACK_POS_NR
   ,REL_OP.PROD_VARIANT_SID                                                                                                           AS PROD_VARIANT_SID
   ,FACT_SPS.PACK_MATERIAL_NR                                                                                                    AS PACK_MATERIAL_NR
   ,FACT_SPS.PACK_TRACKING_NR                                                                                                    AS PACK_TRACKING_NR
   ,FACT_SPS.DELIVERY_ORDER_NR                                                                                                  AS DELIVERY_ORDER_NR
   ,FACT_SPS.CUST_ORDER_DT                                                                                                       AS CUST_ORDER_DT
   ,REL_OP.CUST_ORDER_SID                                                                                                      AS CUST_ORDER_SID
   ,FACT_SPS.CUST_ORDER_NR                                                                                                      AS CUST_ORDER_NR 
   ,FACT_SPS.CUST_ORDER_TYPE_CD                                                                                                   AS CUST_ORDER_TYPE_CD
   ,FACT_SPS.IC_ORDER_DT                                                                                                        AS IC_ORDER_DT
   ,REL_OP.IC_ORDER_SID                                                                                                      AS IC_ORDER_SID
   ,FACT_SPS.IC_ORDER_NR                                                                                                       AS IC_ORDER_NR
   ,REL_OP.DELIV_PROD_QTY                                                                                                        AS DELIV_PROD_QTY
   ,CONVERT_TIMEZONE('Europe/Berlin', FACT_SPS.WH_LEAVE_TGT_TMSP)::TIMESTAMP_NTZ                                                 AS WH_LEAVE_TGT_TMSP
   ,DATE(FACT_SPS.WH_LEAVE_TGT_TMSP)                                                                                             AS WH_LEAVE_TGT_DATE            
   ,CASE WHEN 
        SUM(REL_OP.DELIV_PROD_QTY) OVER (PARTITION BY FACT_SPS.DELIVERY_ORDER_NR,DATE(FACT_SPS.WH_LEAVE_ACTUAL_TMSP),FACT_SPS.WH_SID)=1
        THEN 1
        ELSE 0 END                                                                                                               AS IS_SINGLE_POSITION_WH       --logic based on Doris Gampper. This resolves the EPO/MPO classification issue when an order is containing articles from different whs
   ,CASE 
        WHEN SUM(REL_OP.DELIV_PROD_QTY) OVER (PARTITION BY FACT_SPS.DELIVERY_ORDER_NR,DATE(FACT_SPS.WH_LEAVE_ACTUAL_TMSP),FACT_SPS.WH_SID)=1
          THEN 'EPO'
        WHEN COUNT_IF(prod_variant_packing_type_cd<>2002) OVER (PARTITION BY FACT_SPS.DELIVERY_ORDER_NR,DATE(FACT_SPS.WH_LEAVE_ACTUAL_TMSP),FACT_SPS.WH_SID)>0
            AND SUM(REL_OP.DELIV_PROD_QTY) OVER (PARTITION BY FACT_SPS.DELIVERY_ORDER_NR,DATE(FACT_SPS.WH_LEAVE_ACTUAL_TMSP),FACT_SPS.WH_SID)>1
          THEN 'MPO Karton'
          ELSE 'MPO Tüte' END                                                                                                                AS PROD_VARIANT_PACKING_TYPE_MPO_FG        --logic based on Doris Gampper. Per each MPO ERP Lieferung assign "MPO Karton" whenever 1 position is unequal bag (2002). Whenever all Positions are bag assign "MPO Tüte" else EPO
   ,IFF(FACT_SPS.WH_LEAVE_ACTUAL_TMSP > '2017-09-22 00:00:00', 'Ja', 'Nein')                                                     AS IS_WH_LEAVE_BOOKED                        
   ,IFF(DIM_P.IS_WINE_SPIRITS_FG = 'TRUE', 'Wein', DIM_WH.WH_STORAGE_TYPE_CD)                                                    AS WH_STORAGE_TYPE_DESC_ALT
   ,CONCAT (FACT_SPS.PACK_ORDER_NR, WH_STORAGE_TYPE_DESC_ALT, FACT_SPS.WH_SID)::VARCHAR(25)                                      AS PACK_ORDER_NR_WH_STORAGE_TYPE_DESC_ALT_WH_SID
   ,CONCAT (COALESCE(FACT_SPS.CUST_ORDER_NR,FACT_SPS.IC_ORDER_NR), WH_STORAGE_TYPE_DESC_ALT)                               AS CUST_ORDER_NR_WH_STORAGE_TYPE_DESC_ALT
   ,CONCAT (COALESCE(FACT_SPS.CUST_ORDER_NR,FACT_SPS.IC_ORDER_NR), WH_STORAGE_TYPE_DESC_ALT, FACT_SPS.WH_SID)::VARCHAR(25)  AS CUST_ORDER_NR_WH_STORAGE_TYPE_DESC_ALT_WH_SID
FROM
    lec_share.v_rel_order_packaging_2 AS REL_OP

LEFT JOIN
        lec_share.v_fact_sales_package_shipment_2 AS FACT_SPS
        ON
        REL_OP.PACK_SID = FACT_SPS.PACK_SID
        
LEFT JOIN FE_MSTR_LIDLDIGITAL.V_DIM_WAREHOUSE_2 AS DIM_WH
        ON 
        FACT_SPS.WH_SID = DIM_WH.WH_SID
        
INNER JOIN 
    FE_MSTR_LIDLDIGITAL.V_DIM_PRODUCT_VARIANT_2 AS DIM_PV
    ON 
       REL_OP.PROD_VARIANT_SID = DIM_PV.PROD_VARIANT_SID
LEFT JOIN
    FE_MSTR_LIDLDIGITAL.V_DIM_PRODUCT_2 AS DIM_P
    ON
       DIM_P.PROD_SID = DIM_PV.PROD_SID

WHERE 
        
    REL_OP.CUST_ORDER_SID IS NOT NULL OR REL_OP.IC_ORDER_SID IS NOT NULL --prefilter rel_op table to only customer related entries, excluding transshipments etc.
    ;