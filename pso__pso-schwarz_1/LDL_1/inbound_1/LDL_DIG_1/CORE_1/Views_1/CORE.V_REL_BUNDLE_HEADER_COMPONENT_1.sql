CREATE OR REPLACE VIEW CORE.V_REL_BUNDLE_HEADER_COMPONENT_1(
	BUNDLE_HEADER_PROD_SID COMMENT 'Unique identifier (surrogate key) of the Bundle Header Product',
	BUNDLE_HEADER_PROD_NR COMMENT 'The original number of the Bundle Header Product',
    BUNDLE_HEADER_PROD_VARIANT_SID COMMENT 'Unique Identifier for the product variant of the bundle header to which this bundle item_1 belongs',
	BUNDLE_COMPONENT_PROD_VARIANT_SID COMMENT 'Unique identifier (surrogate key) of the Product Variant that is sold as component in the bundle',
	BUNDLE_COMPONENT_PROD_VARIANT_NR COMMENT 'The original number of the Product Variant that is sold as component in the bundle',
    BUNDLE_COMPONENT_QTY COMMENT 'For each component the amount of pieces that are part of the bundle'
) COMMENT='A view that contains unique combinations of Products sold as bundle headers and Product Variants sold as components of those bundles'
AS
WITH
bundle_header AS 
(
	SELECT
		CONCAT_WS( '_', cust_order_sid, cust_order_pos_nr ) AS  BUNDLE_HEADER_KEY
		,PROD_SID
		,PROD_NR
        ,PROD_VARIANT_SID 
        ,PROD_QTY										    AS BUNDLE_HEADER_PROD_QTY
    FROM CORE.T_FACT_CUSTOMER_ORDER_LINE_1
	WHERE IS_BUNDLE_HEADER_FG = 1
)  
,bundle_component AS 
(
	SELECT
		CONCAT_WS( '_', cust_order_sid, bundle_header_pos_nr )      AS BUNDLE_HEADER_KEY
		,PROD_VARIANT_SID
        ,PROD_VARIANT_NR
        ,PROD_QTY										            AS BUNDLE_COMPONENT_PROD_QTY
	FROM CORE.T_FACT_CUSTOMER_ORDER_LINE_1
	WHERE 1=1
		AND BUNDLE_HEADER_POS_NR != 0
)
SELECT 
    bh.PROD_SID					    AS BUNDLE_HEADER_PROD_SID
    ,bh.PROD_NR						AS BUNDLE_HEADER_PROD_NR
    ,bh.PROD_VARIANT_SID            AS BUNDLE_HEADER_PROD_VARIANT_SID
    ,bc.PROD_VARIANT_SID			AS BUNDLE_COMPONENT_PROD_VARIANT_SID
    ,bc.PROD_VARIANT_NR				AS BUNDLE_COMPONENT_PROD_VARIANT_NR
    ,ROUND( AVG( DIV0( bc.BUNDLE_COMPONENT_PROD_QTY, bh.BUNDLE_HEADER_PROD_QTY ) ), 0 )	AS BUNDLE_COMPONENT_QTY
FROM bundle_header bh
	LEFT JOIN bundle_component bc ON bh.BUNDLE_HEADER_KEY = bc.BUNDLE_HEADER_KEY
GROUP BY
    BUNDLE_HEADER_PROD_SID
    ,BUNDLE_HEADER_PROD_NR
    ,BUNDLE_HEADER_PROD_VARIANT_SID
    ,BUNDLE_COMPONENT_PROD_VARIANT_SID
    ,BUNDLE_COMPONENT_PROD_VARIANT_NR
;