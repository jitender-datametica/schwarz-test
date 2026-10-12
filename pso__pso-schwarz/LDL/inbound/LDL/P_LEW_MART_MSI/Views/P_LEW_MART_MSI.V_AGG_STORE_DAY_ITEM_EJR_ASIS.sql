CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STORE_DAY_ITEM_EJR_ASIS
/*
DescStart
$Revision: 10110 $, $LastChangedBy: umeister $
SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
DescEnd
*/
(
   client_id
  ,cnt_discount_ejr_asis
  ,cnt_retail_ejr_asis
  ,cnt_return_ejr_asis
  ,cnt_void_ejr_asis
  ,dat_formdate
  ,cy_month
  ,item_id
  ,orig_store_nr
  ,discount_id
  ,price_rtl_ejr_adjstd_asis
  ,price_rtl_net_ejr_adjstd_asis
  ,price_rtl_ejr_asis
  ,price_rtl_net_ejr_asis

  ,qty_disc_piece_ejr_asis
  ,qty_disc_weight_ejr_asis
  ,qty_disc_piece_weigth_ejr_asis
  ,qty_piece_ejr_asis
  ,qty_return_ejr_asis
  ,qty_void_ejr_asis
  ,qty_weight_ejr_asis
  ,store_id
  ,time_last_sold_ejr_asis
  ,val_discount_ejr_asis
  ,val_discount_net_ejr_asis
  ,val_discount_hq_ejr_asis
  ,val_discount_hq_net_ejr_asis
  ,val_disc_rtl_gross_ejr_asis
  ,val_disc_rtl_net_ejr_asis
  ,val_return_ejr_asis
  ,val_rtl_ejr_asis
  ,val_void_ejr_asis
  ,val_void_net_ejr_asis

  ,val_rtl_net_ejr_asis
  ,val_return_net_ejr_asis
  ,qty_piece_weight_ejr_asis
  ,qty_rt_piece_weight_ejr_asis
  ,qty_return_defect_ejr_asis
  ,qty_return_saleable_ejr_asis
  ,qty_rt_pc_wt_defect_ejr_asis
  ,qty_rt_pc_wt_saleable_ejr_asis

  ,qty_disc_piece_fa_ejr_asis
  ,qty_disc_weight_fa_ejr_asis
  ,qty_disc_piece_wt_fa_ejr_asis
  ,qty_piece_fa_ejr_asis
  ,qty_return_fa_ejr_asis
  ,qty_weight_fa_ejr_asis
  ,val_discount_fa_ejr_asis
  ,val_discount_net_fa_ejr_asis
  ,val_discount_hq_fa_ejr_asis
  ,val_disc_hq_net_fa_ejr_asis
  ,val_disc_rtl_gross_fa_ejr_asis
  ,val_disc_rtl_net_fa_ejr_asis
  ,val_return_fa_ejr_asis
  ,val_rtl_fa_ejr_asis
  ,val_rtl_net_fa_ejr_asis
  ,val_return_net_fa_ejr_asis
  ,qty_piece_weight_fa_ejr_asis
  ,qty_rt_piece_wt_fa_ejr_asis
  ,qty_return_defect_fa_ejr_asis
  ,qty_return_sale_fa_ejr_asis
  ,qty_rt_pc_wt_dfct_fa_ejr_asis
  ,qty_rt_pc_wt_sale_fa_ejr_asis

  ,currency_iso_cd
)
AS
   (
     SELECT
        Agg.client_id                                                                                                           AS client_id,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0    THEN Agg.cnt_sale            ELSE 0 END       AS cnt_discount_ejr_asis,
   CASE WHEN Agg.discount_sid = -1                                         THEN Agg.cnt_sale            ELSE 0 END       AS cnt_retail_ejr_asis,
   CASE WHEN Agg.discount_sid = -1                                         THEN Agg.cnt_return          ELSE 0 END       AS cnt_return_ejr_asis,
   CASE WHEN Agg.discount_sid = -1                                         THEN Agg.cnt_void            ELSE 0 END       AS cnt_void_ejr_asis,
   Agg.dwh_cal_dt                                                                                                          AS dat_formdate,
   Agg.cy_month                                                                                                            AS cy_month,
   ITmp.item_sid_map                                                                                                       AS item_id,
   Locn.src_orig_store_nr                                                                                                  AS orig_store_nr,
   Agg.discount_sid                                                                                                        AS discount_id,
   Agg.total_item_unit_price_adjust_gross / Cry.rate_currency_exchange                                                     AS price_rtl_ejr_adjstd_asis,
   Agg.total_item_unit_price_adjust_net / Cry.rate_currency_exchange                                                      AS price_rtl_net_ejr_adjstd_asis,
   Agg.total_item_unit_price_gross / Cry.rate_currency_exchange                                                           AS price_rtl_ejr_asis,
   Agg.total_item_unit_price_net / Cry.rate_currency_exchange                                                             AS price_rtl_net_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0    THEN Agg.sales_piece_qty     ELSE 0 END       AS qty_disc_piece_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0    THEN Agg.sales_weight_qty    ELSE 0 END       AS qty_disc_weight_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0    THEN Agg.piece_weight_qty    ELSE 0 END       AS qty_disc_piece_weigth_ejr_asis,
   CASE WHEN Agg.discount_sid = -1                                         THEN Agg.sales_piece_qty     ELSE 0 END       AS qty_piece_ejr_asis,
   CASE WHEN Agg.discount_sid = -1                                         THEN Agg.return_qty          ELSE 0 END       AS qty_return_ejr_asis,
   CASE WHEN Agg.discount_sid = -1                                         THEN Agg.void_qty            ELSE 0 END       AS qty_void_ejr_asis,
   CASE WHEN Agg.discount_sid = -1                                         THEN Agg.sales_weight_qty    ELSE 0 END       AS qty_weight_ejr_asis,
   Agg.loc_sid_store                                                                                                       AS store_id,
   CASE WHEN Agg.discount_sid = -1                                         THEN last_sold_tmsp          ELSE NULL END    AS time_last_sold_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0
              THEN Agg.discount_gross_val / Cry.rate_currency_exchange                                         ELSE 0 END       AS val_discount_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0
              THEN Agg.discount_net_val / Cry.rate_currency_exchange                                           ELSE 0 END       AS val_discount_net_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_piece_qty <> 0
              THEN Agg.discount_gross_val / Cry.rate_currency_exchange                                         ELSE 0 END       AS val_discount_hq_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_piece_qty <> 0
              THEN Agg.discount_net_val / Cry.rate_currency_exchange                                           ELSE 0 END       AS val_discount_hq_net_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0
              THEN  (Agg.discount_base_gross_val + Agg.discount_gross_val) / Cry.rate_currency_exchange         ELSE NULL END    AS val_disc_rtl_gross_ejr_asis,
   CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0
              THEN  (Agg.discount_base_net_val + Agg.discount_net_val) / Cry.rate_currency_exchange             ELSE NULL END    AS val_disc_rtl_net_ejr_asis,
   Agg.return_gross_val / Cry.rate_currency_exchange                                                                       AS val_return_ejr_asis,
   Agg.sales_gross_val / Cry.rate_currency_exchange                                                                        AS val_rtl_ejr_asis,
   Agg.void_gross_val / Cry.rate_currency_exchange                                                                         AS val_void_ejr_asis,
   Agg.void_net_val / Cry.rate_currency_exchange                                                                           AS val_void_net_ejr_asis,
   Agg.sales_net_val / Cry.rate_currency_exchange                                                                          AS val_rtl_net_ejr_asis,
   Agg.return_net_val / Cry.rate_currency_exchange                                                                         AS val_return_net_ejr_asis,
   CASE WHEN Agg.discount_sid = -1    THEN Agg.piece_weight_qty                 ELSE 0 END                               AS qty_piece_weight_ejr_asis,
   CASE WHEN Agg.discount_sid = -1    THEN Agg.return_piece_weight_qty          ELSE 0 END                               AS qty_rt_piece_weight_ejr_asis,
   CASE WHEN Agg.discount_sid = -1    THEN Agg.return_defect_qty                ELSE 0 END                               AS qty_return_defect_ejr_asis,
   CASE WHEN Agg.discount_sid = -1    THEN Agg.return_saleable_qty              ELSE 0 END                               AS qty_return_saleable_ejr_asis,
   CASE WHEN Agg.discount_sid = -1    THEN Agg.return_defect_pc_wt_qty          ELSE 0 END                               AS qty_rt_pc_wt_defect_ejr_asis,
   CASE WHEN Agg.discount_sid = -1    THEN Agg.return_saleable_pc_wt_qty        ELSE 0 END                               AS qty_rt_pc_wt_saleable_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_disc_piece_ejr_asis           ELSE NULL END                            AS qty_disc_piece_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_disc_weight_ejr_asis          ELSE NULL END                            AS qty_disc_weight_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_disc_piece_weigth_ejr_asis    ELSE NULL END                            AS qty_disc_piece_wt_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_piece_ejr_asis                ELSE NULL END                            AS qty_piece_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_return_ejr_asis               ELSE NULL END                            AS qty_return_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_weight_ejr_asis               ELSE NULL END                            AS qty_weight_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_discount_ejr_asis             ELSE NULL END                            AS val_discount_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_discount_net_ejr_asis         ELSE NULL END                            AS val_discount_net_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_discount_hq_ejr_asis          ELSE NULL END                            AS val_discount_hq_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_discount_hq_net_ejr_asis      ELSE NULL END                            AS val_disc_hq_net_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_disc_rtl_gross_ejr_asis       ELSE NULL END                            AS val_disc_rtl_gross_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_disc_rtl_net_ejr_asis         ELSE NULL END                            AS val_disc_rtl_net_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_return_ejr_asis               ELSE NULL END                            AS val_return_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_rtl_ejr_asis                  ELSE NULL END                            AS val_rtl_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_rtl_net_ejr_asis              ELSE NULL END                            AS val_rtl_net_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN val_return_net_ejr_asis           ELSE NULL END                            AS val_return_net_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_piece_weight_ejr_asis         ELSE NULL END                            AS qty_piece_weight_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_rt_piece_weight_ejr_asis      ELSE NULL END                            AS qty_rt_piece_wt_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_return_defect_ejr_asis        ELSE NULL END                            AS qty_return_defect_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_return_saleable_ejr_asis      ELSE NULL END                            AS qty_return_sale_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_rt_pc_wt_defect_ejr_asis      ELSE NULL END                            AS qty_rt_pc_wt_dfct_fa_ejr_asis,
   CASE WHEN Agg.foodaction_fg_asis = 1    THEN qty_rt_pc_wt_saleable_ejr_asis    ELSE NULL END                            AS qty_rt_pc_wt_sale_fa_ejr_asis,
   Cry.currency_iso_cd                                                                                                     AS currency_iso_cd
     FROM p_lew_bil_ac.v_agg_pos_store_item_day AS Agg
   INNER JOIN p_lew_core_ac.v_location AS Locn
   ON Agg.client_id = Locn.client_id
   AND Agg.loc_sid_store = Locn.loc_sid
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS Cry
   ON Agg.client_id = Cry.client_id
   AND Current_Date BETWEEN Cry.dat_rec_start AND Cry.dat_rec_end
   INNER JOIN p_lew_core_ac.v_item_map_key AS ITmp
   ON ITmp.client_id = Agg.client_id
   AND ITmp.item_sid = Agg.item_sid
)
;