CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_SALES_CLIENT_DAY_ITEM_2
(
     client_id
,          dwh_cal_dt
,          item_sid
,          sales_net_val
,          return_net_val
,          discount_net_val
,          till_discount_net_val
,          sales_qty
,          return_qty
,          discount_qty
,          distinct_receipt_count
,          sales_price_net
,          comparison_price_net
,          median_distinct_receipt_count
,          median_sales_price_net
,          median_comparison_price_net
,          price_integrity_fg
,          pv_relevant_fg
)
AS
(SELECT
Sales.client_id
,Sales.dwh_cal_dt
,Sales.item_sid
,Sales.sales_net_val
,Sales.return_net_val
,Sales.discount_net_val
,Sales.till_discount_net_val
,Sales.sales_qty
,Sales.return_qty
,Sales.discount_qty
,Sales.distinct_receipt_count
,Sales.sales_price_net
,Sales.comparison_price_net
,Sales.median_distinct_receipt_count
,Sales.median_sales_price_net
,Sales.median_comparison_price_net
,Sales.price_integrity_fg
,Sales.pv_relevant_fg
FROM p_lew_mart_pit_onprem.t_pit_sales_client_day_item_2        AS Sales_2
);