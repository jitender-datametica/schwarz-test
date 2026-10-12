CREATE OR REPLACE VIEW FE_MSTR_EKPSNF.V_DIM_NFPO_ITEM_ORDER_SALES_STATUS_2(
	 nfpo_item_order_sales_status_id
	,nfpo_item_order_sales_status_descr
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
) AS 
(SELECT 
	 nfpo_item_order_sales_status_id
	,nfpo_item_order_sales_status_descr
	,dwh_created_tmsp
	,dwh_updated_tmsp
	,dwh_src_tmsp
FROM CORE.T_DIM_NFPO_ITEM_ORDER_SALES_STATUS_2
);