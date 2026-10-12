/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_EJR_ASIS_1
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#----------------------------------------------------------------------------
*/

CREATE OR REPLACE VIEW P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_EJR_ASIS_SOMO_1 (
  CLIENT_ID
, CNT_DISCOUNT_EJR_ASIS
, CNT_RETAIL_EJR_ASIS
, CNT_RETURN_EJR_ASIS
, CNT_VOID_EJR_ASIS
, DAT_FORMDATE
, CY_MONTH
, ITEM_ID
, ORIG_STORE_NR
, CONTAINER_ID
, CONTAINER_HIST_ID
, DISCOUNT_ID
, PRICE_RTL_EJR_ADJSTD_ASIS
, PRICE_RTL_NET_EJR_ADJSTD_ASIS
, PRICE_RTL_EJR_ASIS
, PRICE_RTL_NET_EJR_ASIS
, QTY_DISC_PIECE_EJR_ASIS
, QTY_DISC_WEIGHT_EJR_ASIS
, QTY_DISC_PIECE_WEIGTH_EJR_ASIS
, QTY_PIECE_EJR_ASIS
, QTY_RETURN_EJR_ASIS
, QTY_VOID_EJR_ASIS
, QTY_WEIGHT_EJR_ASIS
, STORE_ID
, MOVE_TO_STORE_ID
, TIME_LAST_SOLD_EJR_ASIS
, VAL_DISCOUNT_EJR_ASIS
, VAL_DISCOUNT_NET_EJR_ASIS
, VAL_DISCOUNT_HQ_EJR_ASIS
, VAL_DISCOUNT_HQ_NET_EJR_ASIS
, VAL_DISC_RTL_GROSS_EJR_ASIS
, VAL_DISC_RTL_NET_EJR_ASIS
, VAL_RETURN_EJR_ASIS
, VAL_RTL_EJR_ASIS
, VAL_VOID_EJR_ASIS
, VAL_VOID_NET_EJR_ASIS
, VAL_RTL_NET_EJR_ASIS
, VAL_RETURN_NET_EJR_ASIS
, QTY_PIECE_WEIGHT_EJR_ASIS
, QTY_RT_PIECE_WEIGHT_EJR_ASIS
, QTY_RETURN_DEFECT_EJR_ASIS
, QTY_RETURN_SALEABLE_EJR_ASIS
, QTY_RT_PC_WT_DEFECT_EJR_ASIS
, QTY_RT_PC_WT_SALEABLE_EJR_ASIS
, QTY_DISC_PIECE_FA_EJR_ASIS
, QTY_DISC_WEIGHT_FA_EJR_ASIS
, QTY_DISC_PIECE_WT_FA_EJR_ASIS
, QTY_PIECE_FA_EJR_ASIS
, QTY_RETURN_FA_EJR_ASIS
, QTY_WEIGHT_FA_EJR_ASIS
, VAL_DISCOUNT_FA_EJR_ASIS
, VAL_DISCOUNT_NET_FA_EJR_ASIS
, VAL_DISCOUNT_HQ_FA_EJR_ASIS
, VAL_DISC_HQ_NET_FA_EJR_ASIS
, VAL_DISC_RTL_GROSS_FA_EJR_ASIS
, VAL_DISC_RTL_NET_FA_EJR_ASIS
, VAL_RETURN_FA_EJR_ASIS
, VAL_RTL_FA_EJR_ASIS
, VAL_RTL_NET_FA_EJR_ASIS
, VAL_RETURN_NET_FA_EJR_ASIS
, QTY_PIECE_WEIGHT_FA_EJR_ASIS
, QTY_RT_PIECE_WT_FA_EJR_ASIS
, QTY_RETURN_DEFECT_FA_EJR_ASIS
, QTY_RETURN_SALE_FA_EJR_ASIS
, QTY_RT_PC_WT_DFCT_FA_EJR_ASIS
, QTY_RT_PC_WT_SALE_FA_EJR_ASIS
, CURRENCY_ISO_CD
) AS
(SELECT
  Agg.client_id                                                                                                  AS client_id
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0    THEN Agg.cnt_sale            ELSE 0 END    AS cnt_discount_ejr_asis
, CASE WHEN Agg.discount_sid = -1                                     THEN Agg.cnt_sale            ELSE 0 END    AS cnt_retail_ejr_asis
, CASE WHEN Agg.discount_sid = -1                                     THEN Agg.cnt_return          ELSE 0 END    AS cnt_return_ejr_asis
, CASE WHEN Agg.discount_sid = -1                                     THEN Agg.cnt_void            ELSE 0 END    AS cnt_void_ejr_asis
, Agg.dwh_cal_dt                                                                                                 AS dat_formdate
, Agg.cy_month                                                                                                   AS cy_month
, ITmp.item_sid_map                                                                                              AS item_id
, Locn.src_orig_store_nr                                                                                         AS orig_store_nr
, sm.container_id                                                                                                AS container_id
, sm_hist.container_id                                                                                           AS container_hist_id
, Agg.discount_sid                                                                                               AS discount_id
, Agg.total_item_unit_price_adjust_gross / Cry.rate_currency_exchange                                            AS price_rtl_ejr_adjstd_asis
, Agg.total_item_unit_price_adjust_net / Cry.rate_currency_exchange                                              AS price_rtl_net_ejr_adjstd_asis
, Agg.total_item_unit_price_gross / Cry.rate_currency_exchange                                                   AS price_rtl_ejr_asis
, Agg.total_item_unit_price_net / Cry.rate_currency_exchange                                                     AS price_rtl_net_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0    THEN Agg.sales_piece_qty     ELSE 0 END    AS qty_disc_piece_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0    THEN Agg.sales_weight_qty    ELSE 0 END    AS qty_disc_weight_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0    THEN Agg.piece_weight_qty    ELSE 0 END    AS qty_disc_piece_weigth_ejr_asis
, CASE WHEN Agg.discount_sid = -1                                     THEN Agg.sales_piece_qty     ELSE 0 END    AS qty_piece_ejr_asis
, CASE WHEN Agg.discount_sid = -1                                     THEN Agg.return_qty          ELSE 0 END    AS qty_return_ejr_asis
, CASE WHEN Agg.discount_sid = -1                                     THEN Agg.void_qty            ELSE 0 END    AS qty_void_ejr_asis
, CASE WHEN Agg.discount_sid = -1                                     THEN Agg.sales_weight_qty    ELSE 0 END    AS qty_weight_ejr_asis
, Agg.loc_sid_store                                                                                              AS store_id
, osm.loc_sid_store_move_to                                                                                      AS move_to_store_id
, CASE WHEN Agg.discount_sid = -1                                         THEN Agg.last_sold_tmsp  ELSE NULL END AS time_last_sold_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0
            THEN Agg.discount_gross_val / Cry.rate_currency_exchange                                   ELSE 0 END    AS val_discount_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0
            THEN Agg.discount_net_val / Cry.rate_currency_exchange                                     ELSE 0 END    AS val_discount_net_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_piece_qty <> 0
            THEN Agg.discount_gross_val / Cry.rate_currency_exchange                                   ELSE 0 END    AS val_discount_hq_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_piece_qty <> 0
            THEN Agg.discount_net_val / Cry.rate_currency_exchange                                     ELSE 0 END    AS val_discount_hq_net_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0
            THEN (Agg.discount_base_gross_val + Agg.discount_gross_val) / Cry.rate_currency_exchange   ELSE NULL END AS val_disc_rtl_gross_ejr_asis
, CASE WHEN Agg.discount_sid > -1 AND Agg.discount_weight_qty <> 0
            THEN (Agg.discount_base_net_val + Agg.discount_net_val) / Cry.rate_currency_exchange       ELSE NULL END AS val_disc_rtl_net_ejr_asis
, Agg.return_gross_val / Cry.rate_currency_exchange                                                              AS val_return_ejr_asis
, Agg.sales_gross_val / Cry.rate_currency_exchange                                                               AS val_rtl_ejr_asis
, Agg.void_gross_val / Cry.rate_currency_exchange                                                                AS val_void_ejr_asis
, Agg.void_net_val / Cry.rate_currency_exchange                                                                  AS val_void_net_ejr_asis
, Agg.sales_net_val / Cry.rate_currency_exchange                                                                 AS val_rtl_net_ejr_asis
, Agg.return_net_val / Cry.rate_currency_exchange                                                                AS val_return_net_ejr_asis
, CASE WHEN Agg.discount_sid = -1      THEN Agg.piece_weight_qty           ELSE 0 END                            AS qty_piece_weight_ejr_asis
, CASE WHEN Agg.discount_sid = -1      THEN Agg.return_piece_weight_qty    ELSE 0 END                            AS qty_rt_piece_weight_ejr_asis
, CASE WHEN Agg.discount_sid = -1      THEN Agg.return_defect_qty          ELSE 0 END                            AS qty_return_defect_ejr_asis
, CASE WHEN Agg.discount_sid = -1      THEN Agg.return_saleable_qty        ELSE 0 END                            AS qty_return_saleable_ejr_asis
, CASE WHEN Agg.discount_sid = -1      THEN Agg.return_defect_pc_wt_qty    ELSE 0 END                            AS qty_rt_pc_wt_defect_ejr_asis
, CASE WHEN Agg.discount_sid = -1      THEN Agg.return_saleable_pc_wt_qty  ELSE 0 END                            AS qty_rt_pc_wt_saleable_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_disc_piece_ejr_asis        ELSE NULL END                         AS qty_disc_piece_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_disc_weight_ejr_asis       ELSE NULL END                         AS qty_disc_weight_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_disc_piece_weigth_ejr_asis ELSE NULL END                         AS qty_disc_piece_wt_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_piece_ejr_asis             ELSE NULL END                         AS qty_piece_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_return_ejr_asis            ELSE NULL END                         AS qty_return_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_weight_ejr_asis            ELSE NULL END                         AS qty_weight_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_discount_ejr_asis          ELSE NULL END                         AS val_discount_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_discount_net_ejr_asis      ELSE NULL END                         AS val_discount_net_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_discount_hq_ejr_asis       ELSE NULL END                         AS val_discount_hq_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_discount_hq_net_ejr_asis   ELSE NULL END                         AS val_disc_hq_net_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_disc_rtl_gross_ejr_asis    ELSE NULL END                         AS val_disc_rtl_gross_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_disc_rtl_net_ejr_asis      ELSE NULL END                         AS val_disc_rtl_net_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_return_ejr_asis            ELSE NULL END                         AS val_return_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_rtl_ejr_asis               ELSE NULL END                         AS val_rtl_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_rtl_net_ejr_asis           ELSE NULL END                         AS val_rtl_net_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN val_return_net_ejr_asis        ELSE NULL END                         AS val_return_net_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_piece_weight_ejr_asis      ELSE NULL END                         AS qty_piece_weight_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_rt_piece_weight_ejr_asis   ELSE NULL END                         AS qty_rt_piece_wt_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_return_defect_ejr_asis     ELSE NULL END                         AS qty_return_defect_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_return_saleable_ejr_asis   ELSE NULL END                         AS qty_return_sale_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_rt_pc_wt_defect_ejr_asis   ELSE NULL END                         AS qty_rt_pc_wt_dfct_fa_ejr_asis
, CASE WHEN Agg.foodaction_fg_asis = 1 THEN qty_rt_pc_wt_saleable_ejr_asis ELSE NULL END                         AS qty_rt_pc_wt_sale_fa_ejr_asis
, Cry.currency_iso_cd                                                                                            AS currency_iso_cd
FROM p_lew_bil_ac.v_agg_pos_store_item_day_1 AS Agg

INNER JOIN p_lew_core_ac.v_location_1 AS Locn
ON  Agg.client_id     = Locn.client_id
AND Agg.loc_sid_store = Locn.loc_sid

INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS Cry
ON  Agg.client_id = Cry.client_id
AND CURRENT_DATE BETWEEN Cry.dat_rec_start AND Cry.dat_rec_end

/* Ermittlung der Klammer-SID als "richtigste" SID dieses Artikel_1 */
/* Hauptsächlich zum Bugfix wg. HQ-Master-Nachlieferungen von SAP-Artikeln und wegen */
/* dortiger Fehlerfassung eigentlich bereits korrekt angelegter Artikel_1 */
INNER JOIN p_lew_core_ac.v_item_map_key_1 AS ITmp
ON  ITmp.client_id = Agg.client_id
AND ITmp.item_sid  = Agg.item_sid

/* Get move_to_store_id of respective store */
LEFT OUTER JOIN p_lew_bil_ac.v_org_store_merge_1 AS osm
ON  Agg.client_id     = osm.client_id
AND Agg.loc_sid_store = osm.loc_sid_store
AND osm.aspect_id     = 1

LEFT OUTER JOIN p_lew_BIL_ac.v_sm_map_item_container_str_1 sm_1
ON Agg.client_id = sm.client_id
AND Agg.item_sid = sm.item_sid
AND osm.loc_sid_store_move_to = sm.move_to_store_id
AND CURRENT_DATE BETWEEN sm.dat_rec_start AND sm.dat_rec_end

LEFT OUTER JOIN p_lew_bil_ac.v_sm_map_item_container_str_1 sm_hist
ON Agg.client_id = sm_hist.client_id
AND Agg.item_sid = sm_hist.item_sid
AND osm.loc_sid_store_move_to = sm_hist.move_to_store_id
AND Agg.dwh_cal_dt BETWEEN sm_hist.dat_rec_start AND sm_hist.dat_rec_end
)
;