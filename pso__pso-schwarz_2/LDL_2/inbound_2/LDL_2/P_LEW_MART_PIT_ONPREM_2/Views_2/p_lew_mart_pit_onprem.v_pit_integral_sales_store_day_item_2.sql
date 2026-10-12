CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_INTEGRAL_SALES_STORE_DAY_ITEM_2

      (
           client_id
,          store_sid
,          dwh_cal_dt
,          item_sid
,          sales_gross_val
,          sales_net_val
,          return_net_val
,          discount_net_val
,          till_discount_net_val
,          sales_qty
,          return_qty
,          discount_qty
,          distinct_receipt_count
,          vat_factor
,          vat_pct_val
,          sales_price_net
,          comparison_price_net
,          price_integrity_fg
,          client_price_fg
,          local_price_fg
,          pv_relevant_fg
,          pit_price_integrity_fg
,          pit_price
,          action_type_id
,          action_state_fg
      )
AS
   (SELECT
   Sales.client_id                 AS client_id
,   Sales.store_sid                 AS store_sid
,   Sales.dwh_cal_dt                AS dwh_cal_dt
,   Sales.item_sid                  AS item_sid
,   Sales.sales_gross_val           AS sales_gross_val
,   Sales.sales_net_val             AS sales_net_val
,   Sales.return_net_val            AS return_net_val
,   Sales.discount_net_val          AS discount_net_val
,   Sales.till_discount_net_val     AS till_discount_net_val
,   Sales.sales_qty                 AS sales_qty
,   Sales.return_qty                AS return_qty
,   Sales.discount_qty              AS discount_qty
,   Sales.distinct_receipt_count    AS distinct_receipt_count
,   Sales.vat_factor                AS vat_factor
,   Sales.vat_pct_val               AS vat_pct_val
,   Sales.sales_price_net           AS sales_price_net
,   Sales.comparison_price_net      AS comparison_price_net
,   Sales.price_integrity_fg        AS price_integrity_fg
,   Sales.client_price_fg           AS client_price_fg
,   Sales.local_price_fg            AS local_price_fg
,   Sales.pv_relevant_fg            AS pv_relevant_fg
,   Sales.pit_price_integrity_fg    AS pit_price_integrity_fg
,   Sales.pit_price                 AS pit_price
,   Sales.action_type_id            AS action_type_id
,   Sales.action_state_fg           AS action_state_fg
   FROM p_lew_mart_pit_onprem.t_pit_sales_store_day_item_2        AS Sales_2
   WHERE       Sales.pit_price_integrity_fg = 1
);