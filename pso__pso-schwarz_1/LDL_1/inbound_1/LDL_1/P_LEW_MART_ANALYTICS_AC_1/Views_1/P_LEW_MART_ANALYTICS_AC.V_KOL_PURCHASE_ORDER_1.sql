CREATE OR REPLACE VIEW P_LEW_MART_ANALYTICS_AC.V_KOL_PURCHASE_ORDER_1
(
      client_cd
    , item_ian
    , purchase_order_qty
    , dwh_created
)
AS
   SELECT
         client_cd,
   item_ian,
   purchase_order_qty,
   dwh_created
  FROM p_lew_mart_analytics.t_kol_purchase_order_1
;