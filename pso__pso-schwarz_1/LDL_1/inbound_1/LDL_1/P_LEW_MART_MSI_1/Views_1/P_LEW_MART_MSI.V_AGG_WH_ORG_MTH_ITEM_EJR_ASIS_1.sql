CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_WH_ORG_MTH_ITEM_EJR_ASIS_1 as
   /*
   DescStart
   $Revision: 10107 $, $LastChangedBy: umeister $
   SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
   DescEnd
   */
   SELECT
      agg.client_id                             AS client_id,
   loc.src_wh_id                             AS wh_id,
   agg.aspect_id                             AS aspect_id,
   itmp.item_sid_map                         AS item_id,
   agg.cy_month                              AS month_id,
   agg.discount_sid                          AS discount_id,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.cnt_sale ELSE 0 END) AS cnt_discount_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.cnt_sale ELSE 0 END) AS cnt_retail_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.cnt_return ELSE 0 END) AS cnt_return_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.cnt_void   ELSE 0 END) AS cnt_void_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.sales_piece_qty        ELSE 0 END) AS qty_disc_piece_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.sales_weight_qty       ELSE 0 END) AS qty_disc_weight_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.piece_weight_qty ELSE 0 END) AS qty_disc_piece_weigth_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.sales_piece_qty        ELSE 0 END) AS qty_piece_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.sales_weight_qty       ELSE 0 END) AS qty_weight_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_qty       ELSE 0 END) AS qty_return_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.void_qty         ELSE 0 END) AS qty_void_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.discount_gross_val / cry.rate_currency_exchange ELSE 0 END) AS val_discount_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.discount_net_val / cry.rate_currency_exchange ELSE 0 END) AS val_discount_net_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_qty <> 0 THEN agg.discount_gross_val / cry.rate_currency_exchange ELSE 0 END) AS val_discount_hq_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_qty <> 0 THEN agg.discount_net_val / cry.rate_currency_exchange ELSE 0 END) AS val_discount_hq_net_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN (agg.discount_base_gross_val + agg.discount_gross_val) / cry.rate_currency_exchange  ELSE NULL END) AS val_disc_rtl_gross_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN (agg.discount_base_net_val + agg.discount_net_val) / cry.rate_currency_exchange  ELSE NULL END) AS val_disc_rtl_net_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.piece_weight_qty ELSE 0 END) AS qty_piece_weight_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_piece_weight_qty ELSE 0 END) AS qty_rt_piece_weight_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_defect_qty ELSE 0 END) AS qty_return_defect_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_saleable_qty ELSE 0 END) AS qty_return_saleable_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_defect_pc_wt_qty ELSE 0 END) AS qty_rt_pc_wt_defect_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_saleable_pc_wt_qty ELSE 0 END) AS qty_rt_pc_wt_saleable_ejr_asis,
   Sum(agg.sales_gross_val) / cry.rate_currency_exchange  AS val_rtl_ejr_asis,
   Sum(agg.sales_net_val) / cry.rate_currency_exchange    AS val_rtl_net_ejr_asis,
   Sum(agg.return_gross_val) / cry.rate_currency_exchange AS val_return_ejr_asis,
   Sum(agg.return_net_val) / cry.rate_currency_exchange   AS val_return_net_ejr_asis,
   Sum(agg.void_gross_val) / cry.rate_currency_exchange   AS val_void_ejr_asis,
   Sum(agg.void_net_val) / cry.rate_currency_exchange     AS val_void_net_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.sales_piece_fa_qty        ELSE 0 END) AS qty_disc_piece_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.sales_weight_fa_qty       ELSE 0 END) AS qty_disc_weight_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.piece_weight_fa_qty ELSE 0 END) AS qty_disc_piece_wt_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.sales_piece_fa_qty        ELSE 0 END) AS qty_piece_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.sales_weight_fa_qty       ELSE 0 END) AS qty_weight_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_fa_qty       ELSE 0 END) AS qty_return_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.discount_gross_fa_val / cry.rate_currency_exchange ELSE 0 END) AS val_discount_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.discount_net_fa_val / cry.rate_currency_exchange ELSE 0 END) AS val_discount_net_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_fa_qty <> 0 THEN agg.discount_gross_fa_val / cry.rate_currency_exchange ELSE 0 END) AS val_discount_hq_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_fa_qty <> 0 THEN agg.discount_net_fa_val / cry.rate_currency_exchange ELSE 0 END) AS val_disc_hq_net_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN (agg.return_piece_weight_fa_qty + agg.discount_gross_fa_val) / cry.rate_currency_exchange  ELSE NULL END) AS val_disc_rtl_gross_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN (agg.return_piece_weight_fa_qty + agg.discount_net_fa_val) / cry.rate_currency_exchange  ELSE NULL END) AS val_disc_rtl_net_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.piece_weight_fa_qty ELSE 0 END) AS qty_piece_weight_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_piece_weight_fa_qty ELSE 0 END) AS qty_rt_piece_wt_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_defect_fa_qty ELSE 0 END) AS qty_return_defect_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_saleable_fa_qty ELSE 0 END) AS qty_return_sale_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_defect_pc_wt_fa_qty ELSE 0 END) AS qty_rt_pc_wt_dfct_fa_ejr_asis,
   Sum(CASE WHEN agg.discount_sid = -1     THEN agg.return_saleable_pc_wt_fa_qty ELSE 0 END) AS qty_rt_pc_wt_sale_fa_ejr_asis,
   Sum(agg.sales_gross_fa_val) / cry.rate_currency_exchange  AS val_rtl_fa_ejr_asis,
   Sum(agg.sales_net_fa_val) / cry.rate_currency_exchange    AS val_rtl_net_fa_ejr_asis,
   Sum(agg.return_gross_fa_val) / cry.rate_currency_exchange AS val_return_fa_ejr_asis,
   Sum(agg.return_net_fa_val) / cry.rate_currency_exchange   AS val_return_net_fa_ejr_asis,
   cry.currency_iso_cd
    FROM p_lew_bil_ac.v_agg_pos_wh_org_day_item_asis_1 AS agg
   INNER JOIN p_lew_core_ac.v_location_1 AS loc
   ON agg.client_id = loc.client_id
   AND agg.loc_sid_wh = loc.loc_sid
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS cry
   ON agg.client_id = cry.client_id
   AND Current_Date BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   INNER JOIN p_lew_core_ac.v_item_map_key_1 itmp
   ON itmp.client_id = agg.client_id
   AND itmp.item_sid = agg.item_sid

 GROUP BY
    agg.client_id
   ,loc.src_wh_id
   ,agg.aspect_id
   ,itmp.item_sid_map
   ,agg.cy_month
   ,agg.discount_sid
   ,cry.currency_iso_cd
   ,cry.rate_currency_exchange
;