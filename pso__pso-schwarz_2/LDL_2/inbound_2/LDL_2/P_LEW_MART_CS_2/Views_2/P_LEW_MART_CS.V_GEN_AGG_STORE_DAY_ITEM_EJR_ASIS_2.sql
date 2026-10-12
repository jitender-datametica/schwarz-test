/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for #X_LEW_MART_CS#.V_GEN_AGG_STORE_DAY_ITEM_EJR_ASIS_2
#----------------------------------------------------------------------------
# History:
#  1.0  15.03.2021    Gunes, Oguzhan               Transfer to Snowflake.
#                                                  https://jira.schwarz/browse/DDLE-1783
#                                                  Create scripts for snowflake standardisation.
#  1.1  16.08.2021    Ross,Ulrich                  Erweiterung um LidlPlus Daten
#                                                  (sales_net_lp_val_ejr_asis,discount_net_lp_val_ejr_asis,piece_weight_lp_qty_ejr_asis)
#                                                  https://jira.schwarz/browse/DDLE-2558
#  1.2  12.10.2021    Ross,Ulrich                  LidlPlus Daten Change agg.discount_net_lp_val / cry.rate_currency_exchange to calculate discount_net_lp_val_ejr_asis
#                                                  https://jira.schwarz/browse/DDLE-2666
#  1.3  18.01.2022    Ross,Ulrich                  LidlPlus Daten Change calculate for piece_weight_lp_qty_ejr_asis and piece_weight_qty_ejr_asis
#                                                  https://dev.azure.com/schwarzit/schwarzit.bikid-lidl/_workitems/edit/273846
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE VIEW P_LEW_MART_CS.V_GEN_AGG_STORE_DAY_ITEM_EJR_ASIS_2
/*
* Date: 27.11.2019  User: wieberadm_asp
* View ist 1:1 aus MART_MSI und müsste in dem BIL überführt werden 
*************************************************************************************************************/
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
  ,sales_net_lp_val_ejr_asis     --SALES_VALUE_NET_lp
  ,discount_net_lp_val_ejr_asis  --DISCOUNT_PRICE_NET_lp
  ,piece_weight_lp_qty_ejr_asis  --SALES_AMOUNT_PIECES_lp

  ,currency_iso_cd
)
AS
(SELECT
agg.client_id                                                                                       AS client_id
,CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0    THEN agg.cnt_sale   ELSE 0 END  AS cnt_discount_ejr_asis
,CASE WHEN agg.discount_sid = -1                                     THEN agg.cnt_sale   ELSE 0 END  AS cnt_retail_ejr_asis
,CASE WHEN agg.discount_sid = -1                                     THEN agg.cnt_return ELSE 0 END  AS cnt_return_ejr_asis
,CASE WHEN agg.discount_sid = -1                                     THEN agg.cnt_void   ELSE 0 END  AS cnt_void_ejr_asis
,agg.dwh_cal_dt                                                                                      AS dat_formdate
,agg.cy_month                                                                                        AS cy_month
,itmp.item_sid_map                                                                                   AS item_id
,locn.src_orig_store_nr                                                                              AS orig_store_nr
,agg.discount_sid                                                                                    AS discount_id
,agg.total_item_unit_price_adjust_gross / cry.rate_currency_exchange                                 AS price_rtl_ejr_adjstd_asis
,agg.total_item_unit_price_adjust_net / cry.rate_currency_exchange                                   AS price_rtl_net_ejr_adjstd_asis
,agg.total_item_unit_price_gross / cry.rate_currency_exchange                                        AS price_rtl_ejr_asis
,agg.total_item_unit_price_net / cry.rate_currency_exchange                                          AS price_rtl_net_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0    THEN agg.sales_piece_qty     ELSE 0 END       AS qty_disc_piece_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0    THEN agg.sales_weight_qty    ELSE 0 END       AS qty_disc_weight_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0    THEN agg.piece_weight_qty    ELSE 0 END       AS qty_disc_piece_weigth_ejr_asis
,CASE WHEN agg.discount_sid = -1                                     THEN agg.sales_piece_qty     ELSE 0 END       AS qty_piece_ejr_asis
,CASE WHEN agg.discount_sid = -1                                     THEN agg.return_qty          ELSE 0 END       AS qty_return_ejr_asis
,CASE WHEN agg.discount_sid = -1                                     THEN agg.void_qty            ELSE 0 END       AS qty_void_ejr_asis
,CASE WHEN agg.discount_sid = -1                                     THEN agg.sales_weight_qty    ELSE 0 END       AS qty_weight_ejr_asis
,agg.loc_sid_store                                                                                                 AS store_id
,CASE WHEN agg.discount_sid = -1                                     THEN agg.last_sold_tmsp      ELSE NULL END    AS time_last_sold_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0
          THEN agg.discount_gross_val / cry.rate_currency_exchange                                         ELSE 0 END       AS val_discount_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0
          THEN agg.discount_net_val / cry.rate_currency_exchange                                           ELSE 0 END       AS val_discount_net_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_qty <> 0
          THEN agg.discount_gross_val / cry.rate_currency_exchange                                         ELSE 0 END       AS val_discount_hq_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_qty <> 0
          THEN agg.discount_net_val / cry.rate_currency_exchange                                           ELSE 0 END       AS val_discount_hq_net_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0
          THEN (agg.discount_base_gross_val + agg.discount_gross_val) / cry.rate_currency_exchange         ELSE NULL END    AS val_disc_rtl_gross_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0
          THEN (agg.discount_base_net_val + agg.discount_net_val) / cry.rate_currency_exchange             ELSE NULL END    AS val_disc_rtl_net_ejr_asis
,agg.return_gross_val / cry.rate_currency_exchange                                                                       AS val_return_ejr_asis
,agg.sales_gross_val / cry.rate_currency_exchange                                                                        AS val_rtl_ejr_asis
,agg.void_gross_val / cry.rate_currency_exchange                                                                         AS val_void_ejr_asis
,agg.void_net_val / cry.rate_currency_exchange                                                                           AS val_void_net_ejr_asis
,agg.sales_net_val / cry.rate_currency_exchange                                                                          AS val_rtl_net_ejr_asis
,agg.return_net_val / cry.rate_currency_exchange                                                                         AS val_return_net_ejr_asis
,CASE WHEN agg.discount_sid = -1    THEN (agg.sales_piece_qty + agg.sales_weight_qty)    ELSE 0 END                      AS qty_piece_weight_ejr_asis
,CASE WHEN agg.discount_sid = -1    THEN agg.return_piece_weight_qty          ELSE 0 END                                 AS qty_rt_piece_weight_ejr_asis
,CASE WHEN agg.discount_sid = -1    THEN agg.return_defect_qty                ELSE 0 END                                 AS qty_return_defect_ejr_asis
,CASE WHEN agg.discount_sid = -1    THEN agg.return_saleable_qty              ELSE 0 END                                 AS qty_return_saleable_ejr_asis
,CASE WHEN agg.discount_sid = -1    THEN agg.return_defect_pc_wt_qty          ELSE 0 END                                 AS qty_rt_pc_wt_defect_ejr_asis
,CASE WHEN agg.discount_sid = -1    THEN agg.return_saleable_pc_wt_qty        ELSE 0 END                                 AS qty_rt_pc_wt_saleable_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_disc_piece_ejr_asis           ELSE NULL END                            AS qty_disc_piece_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_disc_weight_ejr_asis          ELSE NULL END                            AS qty_disc_weight_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_disc_piece_weigth_ejr_asis    ELSE NULL END                            AS qty_disc_piece_wt_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_piece_ejr_asis                ELSE NULL END                            AS qty_piece_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_return_ejr_asis               ELSE NULL END                            AS qty_return_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_weight_ejr_asis               ELSE NULL END                            AS qty_weight_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_discount_ejr_asis             ELSE NULL END                            AS val_discount_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_discount_net_ejr_asis         ELSE NULL END                            AS val_discount_net_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_discount_hq_ejr_asis          ELSE NULL END                            AS val_discount_hq_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_discount_hq_net_ejr_asis      ELSE NULL END                            AS val_disc_hq_net_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_disc_rtl_gross_ejr_asis       ELSE NULL END                            AS val_disc_rtl_gross_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_disc_rtl_net_ejr_asis         ELSE NULL END                            AS val_disc_rtl_net_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_return_ejr_asis               ELSE NULL END                            AS val_return_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_rtl_ejr_asis                  ELSE NULL END                            AS val_rtl_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_rtl_net_ejr_asis              ELSE NULL END                            AS val_rtl_net_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN val_return_net_ejr_asis           ELSE NULL END                            AS val_return_net_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_piece_weight_ejr_asis         ELSE NULL END                            AS qty_piece_weight_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_rt_piece_weight_ejr_asis      ELSE NULL END                            AS qty_rt_piece_wt_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_return_defect_ejr_asis        ELSE NULL END                            AS qty_return_defect_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_return_saleable_ejr_asis      ELSE NULL END                            AS qty_return_sale_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_rt_pc_wt_defect_ejr_asis      ELSE NULL END                            AS qty_rt_pc_wt_dfct_fa_ejr_asis
,CASE WHEN agg.foodaction_fg_asis = 1    THEN qty_rt_pc_wt_saleable_ejr_asis    ELSE NULL END                            AS qty_rt_pc_wt_sale_fa_ejr_asis
,agg.sales_net_lp_val / cry.rate_currency_exchange                                                                       AS sales_net_lp_val_ejr_asis
,CASE WHEN agg.discount_sid > -1 AND agg.piece_weight_lp_qty <> 0    THEN agg.discount_net_lp_val / cry.rate_currency_exchange     ELSE 0 END           AS discount_net_lp_val_ejr_asis
,CASE WHEN agg.discount_sid = -1                                     THEN agg.sales_piece_lp_qty + agg.sales_weight_lp_qty       ELSE 0 END           AS piece_weight_lp_qty_ejr_asis
,cry.currency_iso_cd                                                                                                     AS currency_iso_cd
FROM p_lew_bil_ac.v_agg_pos_store_item_day_2 AS agg

INNER JOIN p_lew_core_ac.v_location_2 AS locn
ON agg.client_id = locn.client_id
AND agg.loc_sid_store = locn.loc_sid

INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
ON agg.client_id = cry.client_id
AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end

-- Ermittlung der Klammer-SID als "richtigste" SID dieses Artikel_2
-- Hauptsächlich zum Bugfix wg. HQ-Master-Nachlieferungen von SAP-Artikeln und wegen
-- dortiger Fehlerfassung eigentlich bereits korrekt angelegter Artikel_2 */
INNER JOIN p_lew_core_ac.v_item_map_key_2 AS itmp
ON itmp.client_id = agg.client_id
AND itmp.item_sid = agg.item_sid
)
;



