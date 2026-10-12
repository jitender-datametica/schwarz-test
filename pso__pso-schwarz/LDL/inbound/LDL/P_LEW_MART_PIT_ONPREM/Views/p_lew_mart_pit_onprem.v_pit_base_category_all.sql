CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_BASE_CATEGORY_ALL

AS

-- AdvWeek Total Level for Category  ( 44):
SELECT
vt.client_id
,vt.adv_week_id
,COALESCE ( rwk.adv_week_id, -1::INTEGER )                              AS rltd_adv_week_id
,CAST ( ( vt.adv_week_id * 100::INTEGER ) + vt.client_id AS INTEGER )
                                                                    AS adv_week_sid
,CAST ( ( COALESCE ( rwk.adv_week_id, -1::INTEGER )  * 100::INTEGER ) + vt.client_id AS INTEGER )
                                                                    AS rltd_adv_week_sid
,44::SMALLINT                                                          AS hier_level_id
,'X'                                                                   AS sort_order_val
,-2::INTEGER                                                            AS item_grp_int_sid
,-2::INTEGER                                                            AS sub_item_grp_sid
,CAST ( ( -2::INTEGER  * 100::INTEGER ) + vt.client_id AS INTEGER )              AS item_grp_int_mstr_sid
,CAST ( ( -2::INTEGER  * 100::INTEGER ) + vt.client_id AS INTEGER )              AS sub_item_grp_mstr_sid
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )
 + COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )
 + COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                              AS advert_items_cnt
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )                                AS advert_items_pv_cnt
,COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )                                AS advert_items_nf_cnt
,COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                                AS advert_items_fa_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.total_receipts_cnt
,vt.total_sales_net_val
,vtr.receipts_cnt                                                      AS rltd_receipts_cnt
,vtr.sales_net_val                                                     AS rltd_sales_net_val
,vtr.stores_cnt                                                        AS rltd_stores_cnt
,vtr.total_receipts_cnt                                                AS rltd_total_receipts_cnt
,CASE WHEN RANK() OVER  ( PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week_total AS vt

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week AS rwk
ON  vt.client_id              = rwk.client_id
AND vt.adv_week_id            > rwk.adv_week_id

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_total AS vtr
ON  rwk.client_id              = vtr.client_id
AND rwk.adv_week_id            = vtr.adv_week_id

WHERE hier_level_id = 44    -- AdvWeek Total Level
-- AdvWeek Total Level


UNION ALL


-- Itemgroup  ( WGI )  Level  ( 43):
SELECT
awk.client_id
,awk.adv_week_id
,COALESCE ( rwk.adv_week_id, -1::INTEGER )                                              AS rltd_adv_week_id
,CAST ( ( awk.adv_week_id *100::INTEGER ) + awk.client_id AS INTEGER )
                                                                                    AS adv_week_sid
,CAST ( ( COALESCE ( rwk.adv_week_id, -1::INTEGER )  *100::INTEGER ) + awk.client_id AS INTEGER )
                                                                                    AS rltd_adv_week_sid
,43::SMALLINT                                                                        AS hier_level_id
,LPAD ( igi.src_itemgrp_int_cd, 20, '0')
 || '#X'                                                                               AS sort_order_val
,igi.item_grp_int_sid
,-2::INTEGER                                                                          AS sub_item_grp_sid
,CAST ( ( igi.item_grp_int_sid * 100::INTEGER ) + vt.client_id AS INTEGER )             AS item_grp_int_mstr_sid
,CAST ( ( -2::INTEGER  * 100::INTEGER ) + vt.client_id AS INTEGER )                    AS sub_item_grp_mstr_sid
,CASE WHEN vt.client_id IS NOT NULL
      THEN COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )
         + COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )
         + COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )
 END                                                                                   AS advert_items_cnt
,CASE WHEN vt.client_id IS NOT NULL
      THEN COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )
 END                                                                                   AS advert_items_pv_cnt
,CASE WHEN vt.client_id IS NOT NULL
      THEN COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )
 END                                                                                   AS advert_items_nf_cnt
,CASE WHEN vt.client_id IS NOT NULL
      THEN COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )
 END                                                                                   AS advert_items_fa_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.total_receipts_cnt
,vt.total_sales_net_val
,vtr.receipts_cnt                                  AS rltd_receipts_cnt
,vtr.sales_net_val                                 AS rltd_sales_net_val
,vtr.stores_cnt                                    AS rltd_stores_cnt
,vtr.total_receipts_cnt                            AS rltd_total_receipts_cnt
,CASE WHEN RANK() OVER  ( PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week AS awk

INNER JOIN p_lew_core_ac.v_itemgroup_international AS igi
ON  awk.client_id             = igi.client_id
AND try_TO_NUMBER( igi.src_itemgrp_int_cd )  > 0

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week AS rwk
ON  awk.client_id             = rwk.client_id
AND awk.adv_week_id           > rwk.adv_week_id

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_itemgroup_int AS vt
ON  awk.client_id             = vt.client_id
AND awk.adv_week_id           = vt.adv_week_id
AND igi.item_grp_int_sid      = vt.item_grp_int_sid

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_itemgroup_int AS vtr
ON  rwk.client_id             = vtr.client_id
AND rwk.adv_week_id           = vtr.adv_week_id
AND igi.item_grp_int_sid      = vtr.item_grp_int_sid

WHERE hier_level_id = 43    -- Itemgroup  ( WGI )  Level
-- Itemgroup  ( WGI )  Level



UNION ALL



-- Sub Itemgroup  ( UWG )  Level  ( 42):
SELECT
awk.client_id
,awk.adv_week_id
,COALESCE ( rwk.adv_week_id, -1::INTEGER )                                                  AS rltd_adv_week_id
,CAST ( ( awk.adv_week_id *100::INTEGER ) + awk.client_id AS INTEGER )
                                                                                        AS adv_week_sid
,CAST ( ( COALESCE ( rwk.adv_week_id, -1::INTEGER )  *100::INTEGER ) + awk.client_id AS INTEGER )
                                                                                        AS rltd_adv_week_sid
,CAST ( 42 AS SMALLINT )                                                                  AS hier_level_id
,LPAD ( igi.src_itemgrp_int_cd, 20, '0')                            
 || '#' || LPAD ( sig.src_subitemgrp_cd, 20, '0')                                        AS sort_order_val
,igi.item_grp_int_sid
,sig.sub_item_grp_sid
,CAST ( ( igi.item_grp_int_sid * 100::INTEGER ) + vt.client_id AS INTEGER )              AS item_grp_int_mstr_sid
,CAST ( ( sig.sub_item_grp_sid * 100::INTEGER ) + vt.client_id AS INTEGER )              AS sub_item_grp_mstr_sid
,CASE WHEN vt.client_id IS NOT NULL
      THEN COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )
         + COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )
         + COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )
 END                                                                                       AS advert_items_cnt
,CASE WHEN vt.client_id IS NOT NULL                                        
      THEN COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )                                        
 END                                                                                       AS advert_items_pv_cnt
,CASE WHEN vt.client_id IS NOT NULL                                        
     THEN COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )                                        
 END                                                                                       AS advert_items_nf_cnt
,CASE WHEN vt.client_id IS NOT NULL                                        
      THEN COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                                        
 END                                                                                       AS advert_items_fa_cnt
,vt.stores_cnt               
,vt.receipts_cnt                
,vt.sales_net_val                
,vt.sales_buy_price_net_val                
,vt.total_receipts_cnt                
,vt.total_sales_net_val                
,vtr.receipts_cnt                                                                          AS rltd_receipts_cnt
,vtr.sales_net_val                                                                         AS rltd_sales_net_val
,vtr.stores_cnt                                                                            AS rltd_stores_cnt
,vtr.total_receipts_cnt                                                                    AS rltd_total_receipts_cnt
,CASE WHEN RANK() OVER  ( PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week AS awk

INNER JOIN p_lew_core_ac.v_subitemgroup AS sig
ON  awk.client_id             = sig.client_id
AND TRY_TO_NUMBER(sig.src_subitemgrp_cd )  > 0
AND SUBSTR( sig.sub_item_grp_name, 1, 7) <> '!STORNO'

INNER JOIN p_lew_core_ac.v_subitemgroup_hist AS sgh
ON  sig.client_id             = sgh.client_id
AND sig.sub_item_grp_sid      = sgh.sub_item_grp_sid
AND CURRENT_DATE BETWEEN sgh.dwh_valid_from AND sgh.dwh_valid_to
AND sgh.deleted_fg = 0

INNER JOIN p_lew_core_ac.v_itemgroup_international AS igi
ON  sgh.client_id             = igi.client_id
AND sgh.item_grp_int_sid      = igi.item_grp_int_sid
AND TRY_TO_NUMBER( igi.src_itemgrp_int_cd )  > 0

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week AS rwk
ON  awk.client_id             = rwk.client_id
AND awk.adv_week_id           > rwk.adv_week_id

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_subitemgroup AS vt
ON  awk.client_id             = vt.client_id
AND awk.adv_week_id           = vt.adv_week_id
AND sig.sub_item_grp_sid      = vt.sub_item_grp_sid

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_subitemgroup AS vtr
ON  rwk.client_id             = vtr.client_id
AND rwk.adv_week_id           = vtr.adv_week_id
AND sig.sub_item_grp_sid      = vtr.sub_item_grp_sid

WHERE hier_level_id = 42    -- Sub Itemgroup  ( UWG )  Level
-- Sub Itemgroup  ( UWG )  Level
;