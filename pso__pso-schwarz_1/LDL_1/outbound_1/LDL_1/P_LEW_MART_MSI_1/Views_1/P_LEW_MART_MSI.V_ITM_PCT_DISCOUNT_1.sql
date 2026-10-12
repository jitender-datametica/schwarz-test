CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_itm_pct_discount_1 AS SELECT client_id,
 pct_discount
FROM ldl_p_lew_core_ac.v_wawi_itm_item_1 AS ITEM_1
GROUP BY client_id,
 pct_discount;