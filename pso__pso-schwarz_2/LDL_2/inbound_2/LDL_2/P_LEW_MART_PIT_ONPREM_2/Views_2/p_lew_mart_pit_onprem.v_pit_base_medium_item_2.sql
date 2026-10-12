CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_BASE_MEDIUM_ITEM_2

AS
SELECT
vt.client_id
,vt.adv_week_id
,vt.item_sid
,CAST (  ( vt.item_sid * 100::INTEGER ) + vt.client_id  AS INTEGER  )                 AS item_mstr_sid
,vt.adv_period_id                                                                       AS adv_period_id
,CAST (  ( vt.adv_week_id * 100::INTEGER ) + vt.client_id   AS INTEGER )               AS adv_week_sid
,MIN (  vt.adv_week_id  )                               AS orig_adv_week_id
,CAST ( MIN ( (  vt.adv_week_id   * 100::INTEGER ) + vt.client_id )  AS INTEGER )
                                                                                    AS orig_adv_week_sid
,CASE WHEN MIN ( vt.orig_adv_week_id )  IS NOT NULL THEN 1::SMALLINT ELSE 0::SMALLINT END   
                                                                                    AS extended_week_fg
,CAST ( 21 AS SMALLINT )                                                                AS hier_level_id
,MIN ( 
--LPAD ( CAST ( act.action_type_sort_val AS VARCHAR ( 3)), 3, '0')
TRIM(TO_CHAR( act.action_type_sort_val, '09'))
 || '#' || 
--LPAD ( CAST ( awp.adv_week_period_sort_val AS VARCHAR ( 3)), 3, '0')
TRIM(TO_CHAR( awp.adv_week_period_sort_val, '009'))
 || '#' || 
--LPAD ( CAST ( vt.orig_item_nr /*** MSC-WARNING - MSCEWSMALLINT,033 - FORMAT 'Z ( 18 ) 9' REMOVED, SEMANTIC INFORMATION NOT FOUND. ***/ AS VARCHAR ( 10)), 10, '0'))
TRIM(TO_CHAR( vt.orig_item_nr, '0000000009'))
)                                                                            AS sort_order_val
,MIN ( vt.action_type_id )                                                     AS action_type_id
,med.adv_medium_sid
,CAST ( ( med.adv_medium_sid * 100::INTEGER ) + vt.client_id AS INTEGER )      AS adv_medium_mstr_sid
,CASE WHEN  ROW_NUMBER() OVER ( PARTITION BY vt.client_id, vt.adv_week_id, vt.orig_item_nr, vt.item_sid, vt.adv_period_id, med.adv_medium_grp_sid
                                    ORDER BY med.adv_medium_sid DESC NULLS LAST)  = 1
      THEN 1::SMALLINT
      ELSE 0::SMALLINT
 END                                                                         AS adv_medium_grp_drilldown_disp_fg
,MIN ( vt.price_retail_old )                                                   AS price_retail_old
,MIN ( vt.price_retail_new )                                                   AS price_retail_new
,MIN ( vt.price_retail_net_old )                                               AS price_retail_net_old
,MIN ( vt.price_retail_net_new )                                               AS price_retail_net_new
,MIN ( vt.vat_pct_val )                                                        AS vat_pct_val
,SUM ( vt.pv_net_val )                                                         AS pv_net_val
,MAX ( vt.stores_cnt )                                                         AS stores_cnt
,SUM ( vt.receipts_cnt )                                                       AS receipts_cnt
,SUM ( vt.sales_net_val )                                                      AS sales_net_val
,SUM ( CAST (vt.price_buy * vt.sales_qty AS NUMBER(38,5)))                                
                                                                            AS sales_buy_price_net_val
,SUM ( vt.sales_qty )                                                          AS sales_qty
,SUM ( vt.sales_1d_qty )                                                       AS sales_1d_qty
,SUM ( vt.sales_3d_qty )                                                       AS sales_3d_qty
,SUM ( vt.sales_7d_qty )                                                       AS sales_7d_qty
,SUM ( vt.deliv_qty )                                                          AS deliv_qty
,MAX ( vt.total_receipts_cnt )                                                 AS total_receipts_cnt
,MAX ( vt.total_sales_net_val )                                                AS total_sales_net_val
,SUM ( vt.cherry_pick_receipts_cnt )                                           AS cherry_pick_receipts_cnt
,SUM ( vt.heavy_buy_receipts_cnt )                                             AS heavy_buy_receipts_cnt
,SUM ( vt.exclusive_buy_receipts_cnt )                                         AS exclusive_buy_receipts_cnt
,SUM ( vt.base_receipts_cnt )                                                  AS base_receipts_cnt
,SUM ( vt.base_sales_net_val )                                                 AS base_sales_net_val
,SUM ( vt.base_sales_qty )                                                     AS base_sales_qty
,SUM ( vt.receipt_total_sales_net_val )                                        AS receipt_total_sales_net_val
,SUM ( vt.receipt_action_sales_net_val )                                       AS receipt_action_sales_net_val
FROM p_lew_mart_pit_onprem.t_advert_week_item_period_2 vt

INNER JOIN p_lew_mart_pit_onprem.t_advert_week_item_medium_2 AS md
ON  vt.client_id   = md.client_id
AND vt.item_sid    = md.item_sid
AND vt.adv_week_id = md.adv_week_id

INNER JOIN p_lew_mart_pit_onprem.t_advert_week_period_2 AS awp
ON  vt.client_id     = awp.client_id
AND vt.adv_week_id   = awp.adv_week_id
AND vt.adv_period_id = awp.adv_period_id

INNER JOIN p_lew_mart_pit_onprem.v_pit_advert_medium_2 med
ON md.client_id = med.client_id
AND md.adv_medium_sid = med.adv_medium_sid

INNER JOIN p_lew_mart_pit_onprem.t_pit_action_type_2 AS act
ON  vt.action_type_id    = act.action_type_id

WHERE hier_level_id = 21

GROUP BY
  vt.client_id
, vt.adv_week_id
, vt.orig_item_nr
, vt.item_sid
, vt.adv_period_id
, med.adv_medium_grp_sid
, med.adv_medium_sid;