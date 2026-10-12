CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ORACLE_FK_ADL_ACCEPTANCE_RATE_2 (
	COUNTRY_2
	,ITEM_NR
	,SUPPLIER_NR
	,SUPPLIER_WH
	,GENERATION_DATE
	,ITEM_PACKAGECAPACITY
	,FO_ITEM_PACKAGECAPACITY
	,FO_DELIVERY_DATE
	,ORDERS_ARRIVAL_DATE
	,FO_ORDER_UNIT_ID
	,ORDERS_TOTAL
	,ORDER_NR
	,IS_ZERO
	,SHC_UNIT_NAME
	,PAC_PACKAGE_COUNT
	,ACTIVE
	,STATUS_2
	,ORDER_QTY_ADL
	,ORDER_QTY_DIS
	,CHECK_QTY
	,NUMBER_OF_ITEMS
	) AS
	/* Version: 1.5
	** Author:	Dominik Pfarr
	** Date: 	2024-05-31	
    ** Changes:	change join order and condition;remove item_capacity from final join; reset join; filter on active =1, adding status_2; adding is_zero; change join on fo_item_packagecapacity; reflect zero orders properly; adding order_nr;switch to item_status_all & art_pack_conv in kolli level;adjusting valid_From/to timestamp while joining to fact table again; adhere to new field names and filter on non-ui panel data
	*/
	WITH orders AS (
			SELECT COALESCE(fsfo.country_2, fso.country_2) AS country_2
				,COALESCE(fsfo.item_nr, fso.item_nr) AS item_nr
				,COALESCE(fsfo.supplier_nr, fso.supplier_nr) AS supplier_nr
				,COALESCE(fsfo.wh, fso.wh) AS SUPPLIER_WH
				,COALESCE(fsfo.GENERATION_DATE::DATE, fso.ORDER_SENT_DATE) AS generation_date
				,fsfo.item_packagecapacity AS fo_item_packagecapacity
				,fso.item_packagecapacity
				,fsfo.orders_arrival_date::DATE AS fo_delivery_date
				,fso.orders_arrival_date AS orders_arrival_date
				,fsfo.order_unit_id AS fo_order_unit_id
				,fsfo.ORDER_UNIT_QUANTITY
				,fso.ORDERS_TOTAL AS ORDERS_TOTAL
				,fso.order_nr
				--,fsfo.fo_is_sent
				,CASE 
					WHEN ORDER_UNIT_QUANTITY = 0 OR ORDERS_TOTAL = 0
						THEN 1
					ELSE 0
					END AS is_zero
			FROM CORE.T_ORACLE_V_FK_SUPPLIER_FINAL_ORDER_2 fsfo
			FULL JOIN CORE.T_ORACLE_V_FK_SUPPLIER_ORDER_2 fso
				ON fsfo.country_2 = fso.country_2 
				AND fsfo.ITEM_NR = fso.ITEM_NR 
				AND fsfo.SUPPLIER_NR = fso.SUPPLIER_NR
				AND fsfo.WH = fso.WH 
				AND fsfo.GENERATION_DATE::DATE = fso.ORDER_SENT_DATE
			WHERE fsfo.IS_SENT_FG = 1
				-- filter on data before switching to UI Panel structure
				AND fsfo.CORRECTED_ORDER_UNIT_ID = - 1
				AND fso.ORDER_UNIT_ID = - 1
			)


SELECT o.country_2
	,o.item_nr
	,o.supplier_nr
	,o.supplier_wh
	,o.generation_date
	,o.item_packagecapacity
	,o.fo_item_packagecapacity
	,o.fo_delivery_date
	,o.orders_arrival_date
	,o.fo_order_unit_id
	,o.ORDERS_TOTAL
	,o.order_nr
	,o.is_zero
	,dsh.SHC_UNIT_NAME
	,dapc.PAC_PACKAGE_COUNT
	,dsi.ACTIVE
	,dis.dis_status AS STATUS_2
	,ORDER_UNIT_QUANTITY AS ORDER_QTY_ADL
	,CASE 
		WHEN o.fo_order_unit_id = 0
			THEN NVL(o.ORDERS_TOTAL / o.ITEM_PACKAGECAPACITY, 0)
		ELSE NVL(o.ORDERS_TOTAL / o.ITEM_PACKAGECAPACITY / dapc.PAC_PACKAGE_COUNT, 0)
		END AS ORDER_QTY_DIS
	,CASE 
		WHEN ORDER_UNIT_QUANTITY = 0 AND ORDERS_TOTAL IS NULL
			THEN 1
		WHEN ORDER_QTY_ADL = ORDER_QTY_DIS AND o.fo_delivery_date = o.orders_arrival_date
			THEN 1
		ELSE 0
		END AS CHECK_QTY
	,1 AS number_of_items
FROM orders o
LEFT JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_ITEM_STATUS_ALL_2 dis
	ON o.country_2 = dis.country_2 
	AND o.supplier_wh = dis.dis_wh 
	AND o.item_nr = dis.dis_item_nr 
	AND o.fo_item_packagecapacity = dis.dis_packagecapacity
LEFT JOIN CORE.T_ORACLE_V_DIM_SUPPLIER_ITEM_HIST_2 dsi
	ON o.country_2 = dsi.country_2 
	AND o.ITEM_NR = dsi.ITEM_NR 
	AND o.SUPPLIER_WH = dsi.SUPPLIER_WH 
	AND o.supplier_nr = dsi.SUPPLIER_NR 
	AND o.fo_item_packagecapacity = dsi.item_packagecapacity
		/*for DWH_VALID_FROM_TMSP: changes before 12 noon [mod_date = time of ADL extraction job] should count for this day 
	for DWH_VALID_TO_TMSP:
	changes after 12 noon [mod_date] count for the day after 
	[adding 12 hrs and substracting 24 hrs to end the previous record 1 day before the new record is valid to avoid double coounting]
	*/
		AND o.generation_date BETWEEN DATEADD(HOUR, 12, dsi.DWH_VALID_FROM_TMSP)::DATE AND DATEADD(HOUR, - 12, dsi.DWH_VALID_TO_TMSP)::DATE
LEFT JOIN CORE.T_ORACLE_V_DIM_ART_PACK_CONV_2 dapc
	ON dapc.country_2 = o.country_2 
	AND dapc.PAC_ITEM_NR = o.ITEM_NR 
	AND dapc.pac_item_packagecapacity = o.fo_item_packagecapacity 
	AND dapc.PAC_WH = o.SUPPLIER_WH 
	AND dapc.PAC_ARTICLE_UNIT = o.fo_order_unit_id
LEFT JOIN CORE.T_ORACLE_V_DIC_SHC_2 dsh
	ON dsh.SHC_UNIT_ID = o.fo_order_unit_id
WHERE dsi.active = 1 
AND dsi.deleted = 0
	/*
    and o.country_2 = 'NL'
    and o.SUPPLIER_WH in (1)
    and o.item_nr = 67771
    and o.supplier_nr =215
*/;