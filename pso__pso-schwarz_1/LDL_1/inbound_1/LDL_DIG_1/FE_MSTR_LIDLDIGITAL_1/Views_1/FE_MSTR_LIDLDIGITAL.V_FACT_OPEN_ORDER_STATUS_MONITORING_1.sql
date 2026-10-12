CREATE OR REPLACE VIEW FE_MSTR_LIDLDIGITAL.V_FACT_OPEN_ORDER_STATUS_MONITORING_1(
	    CUST_ORDER_SID                                               
        ,    SALE_ORDER_SID
	,	CUST_ORDER_NR                                                
        ,    SALE_ORDER_NR
	,	CUST_ORDER_POS_NR                                           
        ,    SALE_ORDER_POS_NR
	    ,	DELIVERY_ORDER_SID
	    ,	DELIVERY_ORDER_NR
	    ,	PROD_VARIANT_SID
	    ,	WH_LEAVE_ACTUAL_TMSP
	    ,	WH_LEAVE_TGT_TMSP
	    ,	WSHOP_CD
        ,   DIST_CHANNEL_CD
	    ,	WH_SID
	    ,	HAULER_SID
	    ,	PACK_ORDER_NR
	    ,	DELIVERY_PROD_QTY
	    ,	IS_BLOCKED_DELIVERY_FG
	    ,	DELIVERY_BLOCKED_REASON_CD
	    ,	PROD_QTY
	    ,	DELIVERY_SRC_TYPE_CD
	,	CUST_ORDER_PROCESS_STATUS_CD                              
        ,    SALE_ORDER_PROCESS_STATUS_CD
	,	CUST_ORDER_POS_DELIVERY_STATUS_CD                       
        ,    SALE_ORDER_POS_DELIVERY_STATUS_CD
	,	CUST_ORDER_POS_OVERALL_DELIVERY_STATUS_CD               
        ,    SALE_ORDER_POS_OVERALL_DELIVERY_STATUS_CD
	    ,	DELIVERY_ORDER_STATUS_CD
	,	CUST_ORDER_DT                                         
        ,    SALE_ORDER_DT
	    ,	PACK_SID
	    ,	PROD_TGT_DELIVERY_TIME
	    ,	DELIVERY_TYPE_CD
	    ,	DELIVERY_TGT_DT
		,	CUST_ORDER_TYPE_CD
) AS
SELECT
    	NULL AS CUST_ORDER_SID                                               --Only for Unmapping of cust order attributes, delete afterwards
        ,    SALE_ORDER_SID
	,	NULL AS CUST_ORDER_NR                                                --Only for Unmapping of cust order attributes, delete afterwards
        ,    SALE_ORDER_NR
	,	NULL AS CUST_ORDER_POS_NR                                            --Only for Unmapping of cust order attributes, delete afterwards
        ,    SALE_ORDER_POS_NR
	    ,	DELIVERY_ORDER_SID
	    ,	DELIVERY_ORDER_NR
	    ,	PROD_VARIANT_SID
	    ,	WH_LEAVE_ACTUAL_TMSP
	    ,	WH_LEAVE_TGT_TMSP
	    ,	IFNULL(WSHOP_CD,'-1')
        ,   DIST_CHANNEL_CD
	    ,	WH_SID
	    ,	HAULER_SID
	    ,	PACK_ORDER_NR
	    ,	DELIVERY_PROD_QTY
	    ,	IS_BLOCKED_DELIVERY_FG
	    ,	DELIVERY_BLOCKED_REASON_CD
	    ,	PROD_QTY
	    ,	DELIVERY_SRC_TYPE_CD
	,	NULL AS CUST_ORDER_PROCESS_STATUS_CD                                --Only for Unmapping of cust order attributes, delete afterwards
        ,    SALE_ORDER_PROCESS_STATUS_CD
	,	NULL AS CUST_ORDER_POS_DELIVERY_STATUS_CD                           --Only for Unmapping of cust order attributes, delete afterwards
        ,    SALE_ORDER_POS_DELIVERY_STATUS_CD
	,	NULL AS CUST_ORDER_POS_OVERALL_DELIVERY_STATUS_CD                   --Only for Unmapping of cust order attributes, delete afterwards
        ,    SALE_ORDER_POS_OVERALL_DELIVERY_STATUS_CD
	    ,	DELIVERY_ORDER_STATUS_CD
	,	NULL AS CUST_ORDER_DT                                               --Only for Unmapping of cust order attributes, delete afterwards
        ,    SALE_ORDER_DT
	    ,	PACK_SID
	    ,	PROD_TGT_DELIVERY_TIME
	    ,	DELIVERY_TYPE_CD
	    ,	DELIVERY_TGT_DT
		,	CUST_ORDER_TYPE_CD
FROM lec_share.v_fact_sales_order_line_status_progress_1
;