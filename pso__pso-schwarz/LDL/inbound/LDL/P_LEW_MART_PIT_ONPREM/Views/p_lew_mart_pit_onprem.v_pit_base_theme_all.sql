CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_BASE_THEME_ALL

(
    client_id
,          adv_week_id
,          adv_week_sid
,          hier_level_id
,          sort_order_val
,          adv_theme_sid
,          adv_theme_mstr_sid
,          advert_items_cnt
,          advert_items_pv_cnt
,          advert_items_nf_cnt
,          advert_items_fa_cnt
,          stores_cnt
,          receipts_cnt
,          sales_net_val
,          sales_buy_price_net_val
,          total_receipts_cnt
,          total_sales_net_val
)
AS
(

-- HIER LEVEL 33 = ADVERT WEEK THEME TOTAL (subtotal reporting line)
SELECT
vt.client_id
,vt.adv_week_id
,CAST ( vt.adv_week_id *100::INTEGER +  vt.client_id AS INTEGER )    AS adv_week_sid
,CAST ( 33 AS SMALLINT )                                             AS hier_level_id
,'2#X'                                                               AS sort_order_val
,CAST(-2000 - client_id AS INTEGER )                                 AS adv_theme_sid           --  have made sid PRIMARY KEY across the clients
,CAST((-2000 - client_id) * 100::INTEGER - client_id AS INTEGER )    AS adv_theme_mstr_sid      --  - client_id since total adv_theme_sid = -2000, speaking sid to see the client no.
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )
             + COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )
             + COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )               AS advert_items_cnt
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )                    AS advert_items_pv_cnt
,COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )                    AS advert_items_nf_cnt
,COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                    AS advert_items_fa_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.total_receipts_cnt
,vt.total_sales_net_val
FROM p_lew_mart_pit_onprem.t_advert_week_theme_total AS vt

WHERE hier_level_id = 33
--  why? probably legacy from previous version

UNION ALL

-- HIER LEVEL 32 = ADVERT WEEK THEME (each theme as reporting line)
SELECT
vt.client_id
,vt.adv_week_id
,CAST ( vt.adv_week_id * 100::INTEGER +  vt.client_id AS INTEGER )       AS adv_week_sid
,CAST ( 32 AS SMALLINT )                                                 AS hier_level_id
,'1#' || th.adv_theme_descr                                              AS sort_order_val
,vt.adv_theme_sid                                                        AS adv_theme_sid
,CAST ( vt.adv_theme_sid * 100::INTEGER +  vt.client_id AS INTEGER )     AS adv_theme_mstr_sid
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )
             + COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )
             + COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                   AS advert_items_cnt
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )                    AS advert_items_pv_cnt
,COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )                    AS advert_items_nf_cnt
,COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                    AS advert_items_fa_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.total_receipts_cnt
,vt.total_sales_net_val
FROM p_lew_mart_pit_onprem.t_advert_week_theme AS vt

INNER JOIN p_lew_mart_pit_onprem.t_advert_theme AS th
ON  vt.client_id       = th.client_id
AND vt.adv_theme_sid   = th.adv_theme_sid

WHERE hier_level_id = 32                         
--  why? probably legacy from previous version
      AND vt.adv_theme_sid >= 0
--  exclude 'Kein Werbethema definiert'

UNION ALL

-- HIER LEVEL 34 = ADVERT WEEK THEME 'Kein Werbethema definiert' and empty if there are any (single reporting line)
SELECT
vt.client_id
,vt.adv_week_id
,CAST ( ( vt.adv_week_id *100::INTEGER ) +  vt.client_id AS INTEGER )    AS adv_week_sid
,CAST ( 34 AS SMALLINT )                                                 AS hier_level_id
,'3#' || th.adv_theme_descr                                              AS sort_order_val
,vt.adv_theme_sid                                                        AS adv_theme_sid              --  -2 is a value here  ( clashes with total above ) 
,CAST ( ( vt.adv_theme_sid *100::INTEGER)  - vt.client_id AS INTEGER )   AS adv_theme_mstr_sid         --  - client_id since adv_theme_sid < 0, speaking sid to see the client no.
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )
 + COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )
 + COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                  AS advert_items_cnt
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )                    AS advert_items_pv_cnt
,COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )                    AS advert_items_nf_cnt
,COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                    AS advert_items_fa_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.total_receipts_cnt
,vt.total_sales_net_val
FROM p_lew_mart_pit_onprem.t_advert_week_theme vt

INNER JOIN p_lew_mart_pit_onprem.t_advert_theme th
ON  vt.client_id       = th.client_id
   AND
    vt.adv_theme_sid   = th.adv_theme_sid

WHERE       vt.adv_theme_sid < 0
);