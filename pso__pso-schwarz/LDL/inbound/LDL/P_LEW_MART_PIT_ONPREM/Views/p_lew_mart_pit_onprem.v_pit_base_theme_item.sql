CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_BASE_THEME_ITEM

AS
SELECT
vt.client_id
,vt.adv_week_id
,vt.item_sid
,CAST ( ( vt.item_sid * 100::INTEGER +  vt.client_id )  AS INTEGER  )             AS item_mstr_sid
,CAST ( vt.adv_week_id * 100::INTEGER +  vt.client_id AS INTEGER )                AS adv_week_sid
,MIN (  vt.adv_week_id )               AS orig_adv_week_id
,CAST ( MIN (  vt.adv_week_id   * 100::INTEGER +  vt.client_id )  AS INTEGER )
                                                                    AS orig_adv_week_sid
,CASE WHEN MIN ( vt.orig_adv_week_id )  IS NOT NULL THEN 1::SMALLINT ELSE 0::SMALLINT END   AS extended_week_fg
,31::SMALLINT                                 AS hier_level_id
,MIN ( 
 TRIM( TO_CHAR(act.action_type_sort_val, '09') )
 || '#' || 
 TRIM( TO_CHAR ( awp.adv_week_period_sort_val, '009') )
 || '#' || 
 TRIM( TO_CHAR( vt.orig_item_nr, '0000000009') )
 )                                            AS sort_order_val
,MIN ( vt.action_type_id )                     AS action_type_id
,MIN ( vt.adv_period_id )                      AS adv_period_id
,MIN ( vt.adv_theme_sid )                      AS adv_theme_sid
,CAST ( MIN ( vt.adv_theme_sid )  *100::INTEGER +  vt.client_id AS INTEGER )  AS adv_theme_mstr_sid
,MIN ( vt.price_retail_old )                   AS price_retail_old
,MIN ( vt.price_retail_new )                   AS price_retail_new
,MIN ( vt.price_retail_net_old )               AS price_retail_net_old
,MIN ( vt.price_retail_net_new )               AS price_retail_net_new
,MIN ( vt.vat_pct_val )                        AS vat_pct_val
,SUM ( vt.pv_net_val )                                   AS pv_net_val
,MAX ( vt.stores_cnt )                         AS stores_cnt
,SUM ( vt.receipts_cnt )                       AS receipts_cnt
,SUM ( vt.sales_net_val )                      AS sales_net_val
,SUM ( CAST ( vt.price_buy * vt.sales_qty AS NUMBER(38,5)))
                                               AS sales_buy_price_net_val
,SUM ( vt.sales_qty )                          AS sales_qty
,SUM ( vt.sales_1d_qty )                       AS sales_1d_qty
,SUM ( vt.sales_3d_qty )                       AS sales_3d_qty
,SUM ( vt.sales_7d_qty )                       AS sales_7d_qty
,SUM ( vt.deliv_qty )                          AS deliv_qty
,MAX ( vt.total_receipts_cnt )                 AS total_receipts_cnt
,MAX ( vt.total_sales_net_val )                AS total_sales_net_val
,SUM ( vt.cherry_pick_receipts_cnt )           AS cherry_pick_receipts_cnt
,SUM ( vt.heavy_buy_receipts_cnt )             AS heavy_buy_receipts_cnt
,SUM ( vt.exclusive_buy_receipts_cnt )         AS exclusive_buy_receipts_cnt
,SUM ( vt.base_receipts_cnt )                  AS base_receipts_cnt
,SUM ( vt.base_sales_net_val )                 AS base_sales_net_val
,SUM ( vt.base_sales_qty )                     AS base_sales_qty
,SUM ( vt.receipt_total_sales_net_val )        AS receipt_total_sales_net_val
,SUM ( vt.receipt_action_sales_net_val )       AS receipt_action_sales_net_val
FROM p_lew_mart_pit_onprem.t_advert_week_item_period vt

INNER JOIN p_lew_mart_pit_onprem.t_advert_week_period AS awp
ON  vt.client_id       = awp.client_id
AND vt.adv_week_id     = awp.adv_week_id
AND vt.adv_period_id   = awp.adv_period_id

INNER JOIN p_lew_mart_pit_onprem.t_pit_action_type AS act
ON  vt.action_type_id  = act.action_type_id

WHERE hier_level_id = 31

GROUP BY
  vt.client_id
, vt.adv_week_id
, vt.orig_item_nr
, vt.item_sid
, vt.adv_period_id;