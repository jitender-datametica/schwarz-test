
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_SUPER_AP_ASWAS 

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   SELECT
   a.client_id                                                        AS client_id,
   wh.src_wh_id                                                 AS wh_id,
   item.item_sid                                                AS item_id,
   a.dat_adv                                                      AS dat_adv,
   a.orig_promotion_domain_nr                                     AS orig_promotion_domain_nr,
   a.dat_adv_desc                                                 AS dat_adv_desc,
   agg.qty_sales_dat_adv                                          AS qty_sales_dat_adv,
   agg.qty_sales_period1                                          AS qty_sales_period1,
   agg.qty_sales_period2                                          AS qty_sales_period2,
   agg.qty_sales_dat_adv_end                                      AS qty_sales_dat_adv_end,
   agg.qty_del_dat_behind_del                                     AS qty_del_dat_behind_del,
   agg.val_retail_ejr / cry.rate_currency_exchange                AS val_retail_ejr,
   agg.qty_return_period2                                         AS qty_return_period2,
   agg.qty_sales_period2_test                                     AS qty_sales_period2_test,
   agg.qty_del_dat_behind_del_test                                AS qty_del_dat_behind_del_test,
   agg.val_retail_ejr_total/ cry.rate_currency_exchange           AS val_retail_ejr_total,
   agg.val_retail_net_ejr_total / cry.rate_currency_exchange      AS val_retail_net_ejr_total,
   agg.val_pricechange/ cry.rate_currency_exchange                AS val_pricechange,
   agg.val_pricechange_net / cry.rate_currency_exchange           AS val_pricechange_net,
   agg.val_pricediff_pc / cry.rate_currency_exchange              AS val_pricediff_pc,
   agg.val_pricediff_net_pc / cry.rate_currency_exchange          AS val_pricediff_net_pc,
   agg.val_pc_dat_ext / cry.rate_currency_exchange                AS val_pc_dat_ext,
   agg.val_net_pc_dat_ext  / cry.rate_currency_exchange           AS val_net_pc_dat_ext,
   agg.val_pricediff_pc_dat_ext / cry.rate_currency_exchange      AS val_pricediff_pc_dat_ext,
   agg.val_pricediff_net_pc_dat_ext / cry.rate_currency_exchange  AS val_pricediff_net_pc_dat_ext,
   agg.val_writeoff / cry.rate_currency_exchange                  AS val_writeoff,
   agg.val_writeoff_net  / cry.rate_currency_exchange             AS val_writeoff_net,
   agg.val_pricediff_wo  / cry.rate_currency_exchange             AS val_pricediff_wo,
   agg.val_pricediff_net_wo / cry.rate_currency_exchange          AS val_pricediff_net_wo,
   agg.val_diff_inv / cry.rate_currency_exchange                  AS val_diff_inv,
   agg.val_diff_net_inv  / cry.rate_currency_exchange             AS val_diff_net_inv,
   agg.val_writeoff_zero  / cry.rate_currency_exchange            AS val_writeoff_zero,
   agg.val_writeoff_zero_net  / cry.rate_currency_exchange        AS val_writeoff_zero_net,
   agg.price_buying_sp_condition / cry.rate_currency_exchange     AS price_buying_sp_condition,
   agg.val_retail_net_ejr  / cry.rate_currency_exchange           AS val_retail_net_ejr,
   cry.currency_iso_cd
    FROM p_lew_core_ac.v_wawi_adv_item_advertising_s_ap AS a
   INNER JOIN p_lew_bil_ac.v_warehouse AS wh
   ON wh.client_id         = a.client_id
   AND wh.loc_sid_wh         = a.wh_loc_sid
   AND wh.dwh_actual_fg = 1
   INNER JOIN (
   SELECT
         dt_i.*
   FROM (
       SELECT
           i.client_id,
   i.item_sid,
   TRY_CAST(COALESCE(i.src_orig_item_nr, i.config_item_cd, i.src_matnr) AS DECIMAL(18,0)) AS orig_item_nr,
   COALESCE(i.src_dat_valid_from, MAX(i.src_dat_valid_from) OVER (PARTITION BY i.client_id, COALESCE(i.item_sid_config, i.item_sid))) AS dat_valid_from,
   ih.dwh_valid_to
      FROM p_lew_core_ac.v_item AS i
   INNER JOIN p_lew_core_ac.v_item_hist AS ih
   ON i.client_id = ih.client_id
   AND i.item_sid = ih.item_sid
   AND ih.deleted_fg = 0
   ) AS dt_i
-- Bei Zeitueberschneidungen wird der aktuellste Satz genommen.
QUALIFY ROW_NUMBER() OVER(PARTITION BY client_id, item_sid, dat_valid_from ORDER BY dwh_valid_to DESC NULLS LAST) = 1
) AS item
   ON a.client_id = item.client_id
   AND a.orig_item_nr = item.orig_item_nr
   AND a.dat_adv BETWEEN item.dat_valid_from AND item.dwh_valid_to
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
   ON  a.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   LEFT OUTER JOIN p_lew_mart_msi.t_agg_super_ap_aswas AS agg
   ON  a.client_id                 =     agg.client_id
   AND wh.src_wh_id         =     agg.wh_id
   AND item.item_sid        =      agg.item_sid
   AND a.dat_adv               =     agg.dat_adv
   WHERE CURRENT_DATE BETWEEN a.dat_rec_start AND a.dat_rec_end
   -- only one row per key and item_sid should be returned. dat_rec_start cannot be used to determine one single row per key
   -- as there may be new case sizes for an orig_item_nr with a dat_rec_start later than the dat_adv
    QUALIFY ROW_NUMBER() OVER(PARTITION BY   a.client_id, a.wh_loc_sid, item.item_sid, a.dat_adv, cry.currency_iso_cd ORDER BY item.dwh_valid_to) = 1
;
