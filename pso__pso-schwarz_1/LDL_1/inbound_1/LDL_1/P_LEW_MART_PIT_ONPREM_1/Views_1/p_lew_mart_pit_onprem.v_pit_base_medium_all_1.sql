CREATE OR REPLACE VIEW P_LEW_MART_PIT_ONPREM.V_PIT_BASE_MEDIUM_ALL_1

AS
/* Medium Groups level */
SELECT
awk.client_id
,awk.adv_week_id
,CAST ( ( awk.adv_week_id *100::INTEGER ) + awk.client_id AS INTEGER )                   AS adv_week_sid
,COALESCE ( rwk.adv_week_id, -1::INTEGER )                                               AS rltd_adv_week_id
,CAST ( ( rwk.adv_week_id *100::INTEGER )  + rwk.client_id AS INTEGER )                   AS rltd_adv_week_sid
,CAST ( 23 AS SMALLINT )                                                                 AS hier_level_id
--LPAD ( CAST ( COALESCE ( mdg.adv_medium_grp_sort_val,0 )  AS VARCHAR ( 10)),3,'0')
--||  LPAD (CAST( 0 AS VARCHAR ( 10)),2,'0')  
--                                         AS sort_order_val

/* Aparna 17-11-2021 - corrected sort_order_val by adding 3rd digit to fix the sorting issue on Frontend */

,TRIM(TO_CHAR ( COALESCE ( mdg.adv_medium_grp_sort_val,0 ),  '009'))
||  '000'                                                                                 AS sort_order_val
,CAST((-2::INTEGER * mdg.adv_medium_grp_sid * mdg.client_id) AS INTEGER )                AS adv_medium_sid
,CAST(( -2::INTEGER * mdg.adv_medium_grp_sid * mdg.client_id  * 100::INTEGER) + mdg.client_id AS INTEGER )    
                                                                                        AS adv_medium_mstr_sid
,CAST ( ( mdg.adv_medium_grp_sid * 100::INTEGER ) + mdg.client_id AS INTEGER )           AS adv_medium_grp_mstr_sid
,mdg.adv_medium_grp_descr                                                                AS advert_medium_grp_descr
,'TOT - ' || mdg.adv_medium_grp_descr                                                    AS advert_medium_descr
,mdg.adv_medium_grp_sort_val                                                             AS adv_medium_grp_disp_order_nbr
,CAST( 0 AS INTEGER)                                                                       AS adv_medium_disp_order_nbr
,mdg.adv_medium_grp_sid
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
,CASE WHEN RANK() Over  ( PARTITION BY awk.client_id, awk.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week_1 AS awk

INNER JOIN p_lew_mart_pit_onprem.t_advert_medium_group_1 AS mdg
ON  awk.client_id          = mdg.client_id

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_1 AS rwk
ON  awk.client_id          = rwk.client_id
AND awk.adv_week_id        > rwk.adv_week_id

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_medium_grp_1 AS vt
ON  awk.client_id          = vt.client_id
AND awk.adv_week_id        = vt.adv_week_id
AND mdg.adv_medium_grp_sid = vt.adv_medium_grp_sid

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_medium_grp_1 AS vtr
ON  rwk.client_id          = vtr.client_id
AND rwk.adv_week_id        = vtr.adv_week_id
AND mdg.adv_medium_grp_sid = vtr.adv_medium_grp_sid

WHERE hier_level_id = 23
AND
 (
       mdg.adv_medium_grp_alw_vis_fg = 1    /* Medium Group should be always visible */
    OR vt.client_id IS NOT NULL             /* Medium Group has some actual data in corresponding week */
 )
AND mdg.adv_medium_grp_ignore_fg = 0

UNION ALL

/* Medium level */
SELECT
vt.client_id
,vt.adv_week_id
,CAST ( ( vt.adv_week_id *100::INTEGER ) + vt.client_id AS INTEGER )                 AS adv_week_sid
,COALESCE ( rwk.adv_week_id, -1::INTEGER )                                           AS rltd_adv_week_id
,CAST ( ( rwk.adv_week_id *100::INTEGER ) + vt.client_id AS INTEGER )                AS rltd_adv_week_sid
,CAST ( 22 AS SMALLINT )                                     AS hier_level_id
/* Aparna 17-11-2021 - corrected sort_order_val by adding 3rd digit to fix the sorting issue on Frontend */
--LPAD ( CAST ( COALESCE ( md.advert_medium_group_sort_val,0 )  AS VARCHAR ( 10)),3,'0')
--||  LPAD ( CAST ( COALESCE ( md.advert_medium_sort_val,0 )        AS VARCHAR ( 10)),2,'0')                                               AS sort_order_val
,TRIM(TO_CHAR ( COALESCE ( md.advert_medium_group_sort_val,0 ) , '009'))
||  
TRIM(TO_CHAR ( COALESCE ( md.advert_medium_sort_val,0 )  , '009'))                     AS sort_order_val
,vt.adv_medium_sid                                                                      AS adv_medium_sid
,CAST ( ( vt.adv_medium_sid *100::INTEGER ) + vt.client_id AS INTEGER )              AS adv_medium_mstr_sid
,CAST ( ( md.advert_medium_group_sid *100::INTEGER ) + md.client_id AS INTEGER )     AS adv_medium_grp_mstr_sid
,md.advert_medium_group                                                                 AS advert_medium_grp_descr
,md.advert_medium                                                                       AS advert_medium_descr
,COALESCE ( md.advert_medium_group_sort_val, 127::INTEGER )                          AS adv_medium_grp_disp_order_nbr    --  not NULL, Coalesce should be superflous

,COALESCE ( md.advert_medium_sort_val, 0::INTEGER )                                              AS adv_medium_disp_order_nbr        --  not NULL, Coalesce should be superflous
,md.advert_medium_group_sid                                                             AS adv_medium_grp_sid
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )
 + COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )
 + COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                                           AS advert_items_cnt
,COALESCE ( vt.advert_items_pv_cnt, 0::INTEGER )                                              AS advert_items_pv_cnt
,COALESCE ( vt.advert_items_nf_cnt, 0::INTEGER )                                              AS advert_items_nf_cnt
,COALESCE ( vt.advert_items_fa_cnt, 0::INTEGER )                                              AS advert_items_fa_cnt
,vt.stores_cnt
,vt.receipts_cnt
,vt.sales_net_val
,vt.sales_buy_price_net_val
,vt.total_receipts_cnt
,vt.total_sales_net_val
,vtr.receipts_cnt                                AS rltd_receipts_cnt
,vtr.sales_net_val                               AS rltd_sales_net_val
,CASE WHEN RANK() Over  ( PARTITION BY vt.client_id, vt.adv_week_id ORDER BY rltd_adv_week_id DESC NULLS LAST )  = 1 THEN 1::SMALLINT ELSE 0::SMALLINT END AS nearest_rltd_adv_week_fg
FROM p_lew_mart_pit_onprem.t_advert_week_medium_1 AS vt


--   MJD: 20200429
--INNER JOIN p_lew_mart_pit_onprem.t_advert_medium_1 AS md
--ON  vt.client_id           = md.client_id
--AND vt.adv_medium_sid      = md.adv_medium_sid
--
--INNER JOIN p_lew_mart_pit_onprem.t_advert_medium_hist_1 AS mdh
--ON  md.client_id           = mdh.client_id
--AND md.adv_medium_sid      = mdh.adv_medium_sid
--AND CURRENT_DATE BETWEEN mdh.dwh_valid_from AND mdh.dwh_valid_to
--
--INNER JOIN p_lew_mart_pit_onprem.t_advert_medium_group_1 AS mdg
--ON  mdh.client_id          = mdg.client_id
--AND mdh.adv_medium_grp_sid = mdg.adv_medium_grp_sid
INNER JOIN p_lew_mart_pit_onprem.t_pit_apt_advert_medium_client_1 AS md
ON  vt.client_id           = md.client_id
AND vt.adv_medium_sid      = md.advert_medium_sid


LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_1 AS rwk
ON  vt.client_id           = rwk.client_id
AND vt.adv_week_id         > rwk.adv_week_id

LEFT OUTER JOIN p_lew_mart_pit_onprem.t_advert_week_medium_1 AS vtr
ON  rwk.client_id          = vtr.client_id
AND rwk.adv_week_id        = vtr.adv_week_id
AND vt.adv_medium_sid      = vtr.adv_medium_sid

WHERE hier_level_id = 22

--   MJD: 20200429
--   AND mdh.adv_medium_ignore_fg = 0;
     AND md.advert_medium_ignore_fg = 0;