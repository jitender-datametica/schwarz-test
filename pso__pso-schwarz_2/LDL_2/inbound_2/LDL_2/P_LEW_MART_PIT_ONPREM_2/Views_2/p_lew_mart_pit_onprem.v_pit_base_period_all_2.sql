CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_BASE_PERIOD_ALL_2

AS

-- Overall country_2 sum (action, non-action)
SELECT
vt.client_id
,vt.adv_week_id
,COALESCE ( rwk.adv_week_id, -1::INTEGER )              AS rltd_adv_week_id
,CAST ( ( vt.adv_week_id *100::INTEGER ) + vt.client_id AS INTEGER )
                                               AS adv_week_sid
,CAST ( ( COALESCE ( rwk.adv_week_id, -1::INTEGER )  *100::INTEGER ) + vt.client_id AS INTEGER )
                                               AS rltd_adv_week_sid
,CAST ( 15 AS SMALLINT )                        AS hier_level_id
,'000'
 || '#' || '999'
 || '#' || '9999999999'                      AS sort_order_val
,CAST(-2 AS SMALLINT )                        AS action_type_id
,CAST(-2 AS SMALLINT )                        AS adv_period_id
,-2::INTEGER                        AS item_sid
,-2::INTEGER                        AS item_fam_grp_sid
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_old
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_new
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_net_old
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_net_new
,CAST ( NULL AS NUMBER(38,5) )              AS vat_pct_val
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_diff_pct
,CAST ( NULL AS NUMBER(38,5) )              AS pv_net_val
,CAST ( NULL AS INTEGER )                  AS advert_items_cnt
,tot.total_stores_cnt                      AS stores_cnt
,vt.total_receipts_cnt                     AS receipts_cnt
,vt.total_sales_net_val                    AS sales_net_val
,CAST ( NULL AS NUMBER(38,5) )              AS sales_buy_price_net_val
,CAST ( NULL AS NUMBER(38,5) )              AS sales_qty
,CAST ( NULL AS NUMBER(38,5) )              AS sales_1d_qty
,CAST ( NULL AS NUMBER(38,5) )              AS sales_3d_qty
,CAST ( NULL AS NUMBER(38,5) )              AS sales_7d_qty
,CAST ( NULL AS NUMBER(38,5) )              AS deliv_qty
,vt.total_receipts_cnt
,vt.total_sales_net_val
,vt.total_sales_net_val                        AS total_adv_week_sales_net_val
,CAST ( NULL AS INTEGER )                      AS cherry_pick_receipts_cnt
,CAST ( NULL AS INTEGER )                      AS heavy_buy_receipts_cnt
,CAST ( NULL AS INTEGER )                      AS exclusive_buy_receipts_cnt
,CAST ( NULL AS INTEGER )                        AS base_receipts_cnt
,CAST ( NULL AS NUMBER(38,5) )              AS base_sales_net_val
,CAST ( NULL AS NUMBER(38,5) )              AS base_sales_qty
,CAST ( NULL AS NUMBER(38,5) )              AS receipt_total_sales_net_val
,CAST ( NULL AS NUMBER(38,5) )              AS receipt_action_sales_net_val
,vtr.total_receipts_cnt                    AS rltd_receipts_cnt
,vtr.total_sales_net_val                   AS rltd_sales_net_val
,vtr.total_sales_net_val                   AS rltd_total_sales_net_val
,CASE WHEN RANK() OVER  ( PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week_total_2 AS vt

INNER JOIN
 (SELECT
str.client_id
,awk.adv_week_id
,COUNT ( DISTINCT loc_sid_store )  AS total_stores_cnt
FROM p_lew_bil_ac.v_org_store_merge_2 AS str
INNER JOIN
 (SELECT
client_id
,adv_week_id
,MIN ( adv_week_period_start_dt )  AS adv_week_start_dt
FROM p_lew_mart_pit_onprem.t_advert_week_period_2
GROUP BY 1,2
)  AS awk

    ON  str.client_id          = awk.client_id
    /* Store was opened during the advertising week */
    AND str.dat_opening       <= DATEadd('day', + 6, awk.adv_week_start_dt)
    AND awk.adv_week_start_dt <= COALESCE ( str.dat_closing, TO_DATE('9999-12-31','YYYY-MM_2-DD'))
WHERE aspect_id = 2
GROUP BY 1,2
)  AS tot

ON  vt.client_id              = tot.client_id
AND vt.adv_week_id            = tot.adv_week_id

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_2 AS rwk
ON  vt.client_id              = rwk.client_id
AND vt.adv_week_id            > rwk.adv_week_id
LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_total_2 AS vtr
ON  rwk.client_id             = vtr.client_id
AND rwk.adv_week_id           = vtr.adv_week_id
WHERE hier_level_id = 15


-- All Action Items Sum
UNION ALL
SELECT
vt.client_id
,vt.adv_week_id
,COALESCE ( rwk.adv_week_id, -1::INTEGER )                      AS rltd_adv_week_id
,CAST ( ( vt.adv_week_id *100::INTEGER ) + vt.client_id AS INTEGER )
                                                            AS adv_week_sid
,CAST ( ( COALESCE ( rwk.adv_week_id, -1::INTEGER )  *100::INTEGER ) + vt.client_id AS INTEGER )
                                                            AS rltd_adv_week_sid
,CAST ( 14 AS SMALLINT )                                        AS hier_level_id
,'999'            
 || '#' || '999'            
 || '#' || '9999999999'                                      AS sort_order_val
,CAST(-2 AS SMALLINT )                                        AS action_type_id
,CAST(-2 AS SMALLINT )                                        AS adv_period_id
,-2::INTEGER                                                    AS item_sid
,-2::INTEGER                                                    AS item_fam_grp_sid
,CAST ( NULL AS NUMBER(38,5) )                                  AS price_retail_old
,CAST ( NULL AS NUMBER(38,5) )                                  AS price_retail_new
,CAST ( NULL AS NUMBER(38,5) )                                  AS price_retail_net_old
,CAST ( NULL AS NUMBER(38,5) )                                  AS price_retail_net_new
,CAST ( NULL AS NUMBER(38,5) )                                  AS vat_pct_val
,CAST ( NULL AS NUMBER(38,5) )                                  AS price_retail_diff_pct
,CAST ( NULL AS NUMBER(38,5) )                                  AS pv_net_val
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )            
 + COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )            
 + COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                      AS advert_items_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.sales_qty
,vt.sales_1d_qty
,vt.sales_3d_qty
,vt.sales_7d_qty
,CAST ( NULL AS NUMBER(38,5) )                                AS deliv_qty
,vt.total_receipts_cnt
,vt.total_sales_net_val
,vt.total_sales_net_val                                        AS total_adv_week_sales_net_val
,CAST ( NULL AS INTEGER )                                      AS cherry_pick_receipts_cnt
,CAST ( NULL AS INTEGER )                                      AS heavy_buy_receipts_cnt
,CAST ( NULL AS INTEGER )                                      AS exclusive_buy_receipts_cnt
,CAST ( NULL AS INTEGER )                                      AS base_receipts_cnt
,CAST ( NULL AS NUMBER(38,5) )                                AS base_sales_net_val
,CAST ( NULL AS NUMBER(38,5) )                                AS base_sales_qty
,CAST ( NULL AS NUMBER(38,5) )                                AS receipt_total_sales_net_val
,CAST ( NULL AS NUMBER(38,5) )                                AS receipt_action_sales_net_val
,vtr.receipts_cnt                                              AS rltd_receipts_cnt
,vtr.sales_net_val                                             AS rltd_sales_net_val
,vtr.total_sales_net_val                                       AS rltd_total_sales_net_val
,CASE WHEN RANK() OVER  ( PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week_total_2 AS vt
LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_2 AS rwk
ON  vt.client_id              = rwk.client_id
AND vt.adv_week_id            > rwk.adv_week_id
LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_total_2 AS vtr
ON  rwk.client_id             = vtr.client_id
AND rwk.adv_week_id           = vtr.adv_week_id
WHERE hier_level_id = 14


-- Action Type Sum
UNION ALL
SELECT
vt.client_id
,vt.adv_week_id
,COALESCE ( rwk.adv_week_id, -1::INTEGER )              AS rltd_adv_week_id
,CAST ( ( vt.adv_week_id *100::INTEGER ) + vt.client_id AS INTEGER )
                                               AS adv_week_sid
,CAST ( ( COALESCE ( rwk.adv_week_id, -1::INTEGER )  *100::INTEGER ) + vt.client_id AS INTEGER )
                                               AS rltd_adv_week_sid
,CAST ( 13 AS SMALLINT )                        AS hier_level_id
--LPAD ( CAST ( act.action_type_sort_val AS VARCHAR ( 3)), 3, '0')
,TRIM(TO_CHAR ( act.action_type_sort_val ,'000'))
 || '#' || '999'
 || '#' || '9999999999'                    AS sort_order_val
,vt.action_type_id                         AS action_type_id
,CAST(-2 AS SMALLINT )                      AS adv_period_id
,-2::INTEGER                      AS item_sid
,-2::INTEGER                      AS item_fam_grp_sid
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_old
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_new
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_net_old
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_net_new
,CAST ( NULL AS NUMBER(38,5) )              AS vat_pct_val
,CAST ( NULL AS NUMBER(38,5) )              AS price_retail_diff_pct
,vt.pv_net_val
,vt.advert_items_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.sales_qty
,vt.sales_1d_qty
,vt.sales_3d_qty
,vt.sales_7d_qty
,vt.deliv_qty
,vt.total_receipts_cnt
,vt.total_sales_net_val
,vt.total_sales_net_val                    AS total_adv_week_sales_net_val
,CASE WHEN vt.action_type_id IN  ( 2,3 )
       THEN CAST ( NULL AS INTEGER )
       ELSE vt.cherry_pick_receipts_cnt
 END                                       AS cherry_pick_receipts_cnt
,CAST ( NULL AS INTEGER )  AS heavy_buy_receipts_cnt
,CAST ( NULL AS INTEGER )  AS exclusive_buy_receipts_cnt
,CAST ( NULL AS INTEGER )                  AS base_receipts_cnt
,vt.base_sales_net_val                     AS base_sales_net_val
,CAST ( NULL AS NUMBER(38,5) )        AS base_sales_qty
,CAST ( NULL AS NUMBER(38,5) )        AS receipt_total_sales_net_val
,CAST ( NULL AS NUMBER(38,5) )        AS receipt_action_sales_net_val
,vtr.receipts_cnt                          AS rltd_receipts_cnt
,vtr.sales_net_val                         AS rltd_sales_net_val
,vtr.total_sales_net_val                   AS rltd_total_sales_net_val
,CASE WHEN RANK() OVER  ( PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week_action_type_2 AS vt
LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_2 AS rwk
ON  vt.client_id              = rwk.client_id
AND vt.adv_week_id            > rwk.adv_week_id
INNER JOIN p_lew_mart_pit_onprem.t_pit_action_type_2 AS act
ON  vt.action_type_id          = act.action_type_id
LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_action_type_2 AS vtr
ON  rwk.client_id             = vtr.client_id
AND rwk.adv_week_id           = vtr.adv_week_id
AND vt.action_type_id         = vtr.action_type_id

WHERE hier_level_id = 13


-- Period Sum
UNION ALL
SELECT
vt.client_id
,vt.adv_week_id
,COALESCE ( rwk.adv_week_id, -1::INTEGER )              AS rltd_adv_week_id
,CAST ( ( vt.adv_week_id *100::INTEGER ) + vt.client_id AS INTEGER )
                                               AS adv_week_sid
,CAST ( ( COALESCE ( rwk.adv_week_id, -1::INTEGER )  *100::INTEGER ) + vt.client_id AS INTEGER )
                                               AS rltd_adv_week_sid
,CAST ( 12 AS SMALLINT )                        AS hier_level_id
--LPAD ( CAST ( act.action_type_sort_val AS VARCHAR ( 3)), 3, '0')
-- '#' || LPAD ( CAST ( awp.adv_week_period_sort_val AS VARCHAR ( 3)), 3, '0')
-- || '#' || '9999999999'                    AS sort_order_val
,TRIM(TO_CHAR ( act.action_type_sort_val, '000'))
|| '#' || 
TRIM(TO_CHAR ( awp.adv_week_period_sort_val, '000'))
|| '#' || 
'9999999999'                                    AS sort_order_val
,vt.action_type_id                                 AS action_type_id
,vt.adv_period_id                                  AS adv_period_id
,-2::INTEGER                                      AS item_sid
,-2::INTEGER                                      AS item_fam_grp_sid
,CAST ( NULL AS NUMBER(38,5) )                    AS price_retail_old
,CAST ( NULL AS NUMBER(38,5) )                    AS price_retail_new
,CAST ( NULL AS NUMBER(38,5) )                    AS price_retail_net_old
,CAST ( NULL AS NUMBER(38,5) )                    AS price_retail_net_new
,CAST ( NULL AS NUMBER(38,5) )                    AS vat_pct_val
,vt.price_retail_diff_pct
,vt.pv_net_val
,vt.advert_items_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.sales_qty
,vt.sales_1d_qty
,vt.sales_3d_qty
,vt.sales_7d_qty
,vt.deliv_qty
,vt.total_receipts_cnt
,vt.total_sales_net_val
,tot.total_sales_net_val                   AS total_adv_week_sales_net_val
,CASE WHEN vt.action_type_id IN  ( 2,3 )
       THEN CAST ( NULL AS INTEGER )
       ELSE vt.cherry_pick_receipts_cnt
 END                                       AS cherry_pick_receipts_cnt
,CAST ( NULL AS INTEGER )                  AS heavy_buy_receipts_cnt
,CAST ( NULL AS INTEGER )                  AS exclusive_buy_receipts_cnt
,CAST ( NULL AS INTEGER )                  AS base_receipts_cnt
,vt.base_sales_net_val                     AS base_sales_net_val
,CAST ( NULL AS NUMBER(38,5) )        AS base_sales_qty
,CAST ( NULL AS NUMBER(38,5) )        AS receipt_total_sales_net_val
,CAST ( NULL AS NUMBER(38,5) )        AS receipt_action_sales_net_val
,vtr.receipts_cnt                          AS rltd_receipts_cnt
,vtr.sales_net_val                         AS rltd_sales_net_val
,vtr.total_sales_net_val                   AS rltd_total_sales_net_val
,CASE WHEN RANK() OVER  ( PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week_period_action_type_2 AS vt
INNER JOIN p_lew_mart_pit_onprem.t_advert_week_period_2 AS awp
ON  vt.client_id              = awp.client_id
AND vt.adv_week_id            = awp.adv_week_id
AND vt.adv_period_id          = awp.adv_period_id
INNER JOIN p_lew_mart_pit_onprem.t_pit_action_type_2 AS act
ON  vt.action_type_id         = act.action_type_id
LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_2 AS rwk
ON  vt.client_id              = rwk.client_id
AND vt.adv_week_id            > rwk.adv_week_id
LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_period_action_type_2 AS vtr
ON  rwk.client_id             = vtr.client_id
AND rwk.adv_week_id           = vtr.adv_week_id
AND vt.adv_period_id          = vtr.adv_period_id
AND vt.action_type_id         = vtr.action_type_id
INNER JOIN p_lew_mart_pit_onprem.t_advert_week_total_2 AS tot
ON  vt.client_id              = tot.client_id
AND vt.adv_week_id            = tot.adv_week_id

WHERE hier_level_id = 12;