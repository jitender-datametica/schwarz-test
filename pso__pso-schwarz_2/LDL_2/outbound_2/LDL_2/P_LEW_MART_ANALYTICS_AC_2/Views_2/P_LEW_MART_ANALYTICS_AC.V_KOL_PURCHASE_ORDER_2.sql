CREATE OR REPLACE VIEW ldl_p_lew_mart_analytics_ac.v_kol_purchase_order_2 (client_cd, item_ian, purchase_order_qty,
dwh_created) AS SELECT client_cd,
 item_ian,
 purchase_order_qty,
 dwh_created
FROM ldl_p_lew_mart_analytics.t_kol_purchase_order_2;