CREATE OR REPLACE VIEW FE_MSTR_AUTODISPO.V_ORACLE_FK_WH_OPTIMIZATION_1 (
	COUNTRY_1
	,STORE_WH
	,STORE_NR
	,ITEM_NR
	,DATE
	,ORD_ORDER_TYPE
	,ORD_STORECALCULATION_ID
	,OPT_TYPE_NAME
	,ORDER_QUANTITY_IN_BOXES
	,OPT_BEFORE
	,OPT_AFTER
	,ORD_UNIT_ID
	,MINMAX
	,CUTBACK
	,WH_NEXT_DELIVERY
	,R_N
	) AS

	/* Version: 1.4
	** Author:	Dominik Pfarr
	** Date: 	2024-03-22
    ** Changes:	remove date filter for last 60 days only; add coalesce to wh_next_delivery
	*/
	
SELECT fo.country_1
	,store_wh
	,fo.store_nr
	,fo.item_nr
	,DATE
	,fo.ord_order_type
	,fo.ord_storecalculation_id
	,opt_type_name
	,order_quantity_in_boxes
	,opt_before
	,opt_after
	,ord_unit_id
	,CASE WHEN opt_type_name = 'Warehouse Adjustment' THEN opt_before - opt_after END MinMax
	,CASE WHEN opt_type_name = 'Warehouse Stock' THEN opt_before - opt_after END Cutback
	,COALESCE(DATEADD(DAY, wdel_time_id - 365.25 * (4712) - 2, '0000-01-01')::DATE, '0000-01-01') wh_next_delivery
	,ROW_NUMBER() OVER (
		PARTITION BY DATE
		,opt_type_name
		,fo.ord_storecalculation_id
		,fo.country_1
		,store_wh
		,fo.store_nr
		,fo.item_nr ORDER BY wdel_time_id ASC
		) r_n
FROM (
	SELECT country_1
		,generation_date DATE
		,ord_order_type
		,store store_nr
		,item_nr
		,ord_storecalculation_id
		,ord_pieces_quantity / ord_case_size order_quantity_in_boxes
		,NULL opt_before
		,NULL opt_after
		,ord_unit_id
		,'Finalorder' opt_type_name
		,'fk_order' tabl
	FROM FE_MSTR_AUTODISPO.V_ORACLE_FK_ORDER_1
	
	UNION ALL
	
	SELECT country_1
		,DATE
		,opt_order_type ord_order_type
		,store store_nr
		,item_nr
		,opt_storecalculation_id ord_storecalculation_id
		,NULL order_quantity_in_boxes
		,opt_before
		,opt_after
		,opt_unit_id ord_unit_id
		,opt_type_name
		,'fk_optimization' tabl
	FROM FE_MSTR_AUTODISPO.V_ORACLE_FK_OPTIMIZATION_1
	) fo
INNER JOIN FE_MSTR_AUTODISPO.V_ORACLE_DIM_STORE_1 ds ON fo.store_nr = ds.store_nr AND fo.country_1 = ds.country_1
LEFT JOIN CORE.T_ORACLE_V_FK_WH_DELIVERY_1 fwd ON fwd.wdel_wh_nr = store_wh AND fwd.wdel_item_nr = fo.item_nr AND DATEADD(DAY, fwd.WDEL_TIME_ID - 365.25 * (4712) - 2, '0000-01-01') > DATE AND fwd.country_1 = fo.country_1
WHERE ord_order_type IN (
		'CALCULATION'
		,'PRECALCULATION'
		) AND opt_type_name IN (
		'Finalorder'
		,'Warehouse Stock'
		,'Warehouse Adjustment'
		) QUALIFY r_n = 1;