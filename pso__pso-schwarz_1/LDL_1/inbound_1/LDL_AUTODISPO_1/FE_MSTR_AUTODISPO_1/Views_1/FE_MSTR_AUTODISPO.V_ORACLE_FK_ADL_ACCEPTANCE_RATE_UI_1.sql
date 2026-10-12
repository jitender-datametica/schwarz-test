CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ORACLE_FK_ADL_ACCEPTANCE_RATE_UI_1 (
	COUNTRY_1
	,WH
	,ITEM_NR
	,ITEM_PACKAGECAPACITY
	,SUPPLIER_NR
	,GENERATION_DATE
	,ORDERS_ARRIVAL_DATE
	,ORD_UNIT_ID
	,ORDER_UNIT_QUANTITY
	,CORRECTED_ORDER_UNIT_QUANTITY
	,CORRECTED_ORDER_UNIT_ID
	,ORDER_SENT_DATE
	,CALCULATION_NUMBER
	,ORDERS_TOTAL
	,ORDERS_ARRIVAL_DATE_DIS
	,ORDER_UNIT_ID_DIS
	,ORDER_NR
	,IS_ZERO
	,SHC_UNIT_NAME
	,PAC_PACKAGE_COUNT
	,ACTIVE
	,STATUS_1
	,ORDER_QTY_DIS
	,CHECK_QTY
	,CHECK_DIS
	,NUMBER_OF_ITEMS
	) COMMENT = 'Version: 1.4 - Changing join condition to delivery date; sum up DIS orders' 
	AS
	/* Version: 1.4
	** Author:	Dominik Pfarr
	** Date: 	2024-09-19
    ** Changes:	Initial version for ui panel data; rename ord_unit_id; adjust is_zero; remove filter on DIS; join condition to delivery date - sum up DIS orders 
	*/
	WITH dis AS (
			SELECT country_1
				,wh
				,item_nr
				,item_packagecapacity
				,SUPPLIER_NR
				,orders_arrival_date AS orders_arrival_date_DIS
				,order_unit_id AS order_unit_id_dis
				,listagg(order_nr, ', ') WITHIN
			GROUP (
					ORDER BY ORDER_SENT_DATE ASC
					) order_nr
				,SUM(ORDERS_TOTAL) orders_total
			FROM CORE.T_ORACLE_V_FK_SUPPLIER_ORDER_1 -- DIS
				-- filter on data AFTER switching to UI Panel structure
			WHERE order_unit_id <> - 1
			GROUP BY country_1
				,wh
				,item_nr
				,item_packagecapacity
				,SUPPLIER_NR
				,orders_arrival_date
				,order_unit_id
			)
		,orders AS (
			SELECT fsfo.country_1
				,fsfo.wh
				,fsfo.item_nr
				,fsfo.item_packagecapacity
				,fsfo.supplier_nr
				,fsfo.GENERATION_DATE
				,fsfo.orders_arrival_date
				,fsfo.order_unit_id
				,fsfo.ORDER_UNIT_QUANTITY
				,fsfo.CORRECTED_ORDER_UNIT_QUANTITY
				,fsfo.CORRECTED_ORDER_UNIT_ID
				,fsfo.ORDER_SENT_DATE
				,fsfo.CALCULATION_NUMBER
				,fso.ORDERS_TOTAL
				,fso.orders_arrival_date_DIS
				,fso.order_unit_id_dis
				,fso.order_nr
				,CASE 
					WHEN ORDER_UNIT_QUANTITY = 0
						AND CORRECTED_ORDER_UNIT_QUANTITY = 0
						THEN 1
					ELSE 0
					END AS is_zero
			FROM CORE.T_ORACLE_V_FK_SUPPLIER_FINAL_ORDER_1 fsfo -- ADL
			LEFT JOIN dis fso -- DIS
				ON fsfo.country_1 = fso.country_1
					AND fsfo.WH = fso.WH
					AND fsfo.ITEM_NR = fso.ITEM_NR
					AND fsfo.item_packagecapacity = fso.item_packagecapacity
					AND fsfo.SUPPLIER_NR = fso.SUPPLIER_NR
					--AND fsfo.GENERATION_DATE::DATE = fso.ORDER_SENT_DATE
					AND fsfo.orders_arrival_date = fso.orders_arrival_date_dis
			WHERE fsfo.IS_SENT_FG = 1
				-- filter on data AFTER switching to UI Panel structure
				AND fsfo.CORRECTED_ORDER_UNIT_ID <> - 1
			)


SELECT o.country_1
	,o.wh
	,o.item_nr
	,o.item_packagecapacity
	,o.supplier_nr
	,o.GENERATION_DATE::DATE
	,o.orders_arrival_date
	,o.order_unit_id ord_unit_id
	,o.ORDER_UNIT_QUANTITY
	,o.CORRECTED_ORDER_UNIT_QUANTITY
	,o.CORRECTED_ORDER_UNIT_ID
	,o.ORDER_SENT_DATE
	,o.CALCULATION_NUMBER
	,o.ORDERS_TOTAL
	,o.orders_arrival_date_DIS
	,o.order_unit_id_dis
	,o.order_nr
	,o.is_zero
	,dsh.SHC_UNIT_NAME
	,dapc.PAC_PACKAGE_COUNT
	,dsi.ACTIVE
	,dis.dis_status AS STATUS_1
	,NVL(o.ORDERS_TOTAL / o.ITEM_PACKAGECAPACITY / dapc.PAC_PACKAGE_COUNT, 0) AS ORDER_QTY_DIS
	,CASE 
		WHEN ORDER_UNIT_QUANTITY = CORRECTED_ORDER_UNIT_QUANTITY
			AND o.order_unit_id = o.corrected_order_unit_id
			THEN 1
		ELSE 0
		END AS CHECK_QTY
	,CASE 
		WHEN CORRECTED_ORDER_UNIT_QUANTITY = 0
			AND ORDERS_TOTAL IS NULL
			THEN 0
		WHEN CORRECTED_ORDER_UNIT_QUANTITY = ORDER_QTY_DIS
			AND o.order_unit_id = o.order_unit_id_dis
			THEN 0
		ELSE 1
		END AS CHECK_DIS
	,1 AS number_of_items
FROM orders o
LEFT JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_ITEM_STATUS_ALL_1 dis
	ON o.country_1 = dis.country_1
		AND o.wh = dis.dis_wh
		AND o.item_nr = dis.dis_item_nr
		AND o.item_packagecapacity = dis.dis_packagecapacity
LEFT JOIN CORE.T_ORACLE_V_DIM_SUPPLIER_ITEM_HIST_1 dsi
	ON o.country_1 = dsi.country_1
		AND o.ITEM_NR = dsi.ITEM_NR
		AND o.wh = dsi.SUPPLIER_WH
		AND o.supplier_nr = dsi.SUPPLIER_NR
		AND o.item_packagecapacity = dsi.item_packagecapacity
		/*for DWH_VALID_FROM_TMSP: changes before 12 noon [mod_date = time of ADL extraction job] should count for this day 
	for DWH_VALID_TO_TMSP:
	changes after 12 noon [mod_date] count for the day after 
	[adding 12 hrs and substracting 24 hrs to end the previous record 1 day before the new record is valid to avoid double coounting]
	*/
		AND o.generation_date BETWEEN DATEADD(HOUR, 12, dsi.DWH_VALID_FROM_TMSP)::DATE AND DATEADD(HOUR, - 12, dsi.DWH_VALID_TO_TMSP)::DATE
LEFT JOIN CORE.T_ORACLE_V_DIM_ART_PACK_CONV_1 dapc
	ON dapc.country_1 = o.country_1
		AND dapc.PAC_ITEM_NR = o.ITEM_NR
		AND dapc.pac_item_packagecapacity = o.item_packagecapacity
		AND dapc.PAC_WH = o.WH
		AND dapc.PAC_ARTICLE_UNIT = o.order_unit_id_dis
LEFT JOIN CORE.T_ORACLE_V_DIC_SHC_1 dsh
	ON dsh.SHC_UNIT_ID = o.order_unit_id
WHERE dsi.active = 1
	AND dsi.deleted = 0;