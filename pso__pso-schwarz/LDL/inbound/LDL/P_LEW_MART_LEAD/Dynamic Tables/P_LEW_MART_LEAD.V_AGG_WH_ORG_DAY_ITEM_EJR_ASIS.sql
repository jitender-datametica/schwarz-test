/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_lead.v_agg_wh_org_day_item_ejr_asis
#----------------------------------------------------------------------------
# History:
#  1.0  01.07.2019    Chandramani Kumbhale     Initial version.
#                                              VIEW migrated from MSI layer to LEAD layer for LEAD reports.
#                                              https://jira-lidl-public.pixsoftware.de/browse/IDMO-1975
#                                              20190701_2138_MCD_Obj_Migrt_To_Lead_Rep5
#  1.1  13.10.2020    Chandramani Kumbhale     Added reference with 'v_item_map_key' for item_sid to fix issue INC1649911.
#                                              https://jira.schwarz/browse/REP4-7559
#                                              20201013_2616_Correct_Sales_Diff
#  1.2  14.01.2021    Michael Morris           Removed SUM functions and GROUP BY clause.
#                                              https://jira.schwarz/browse/REP4-8327
#                                              20210114_2708_wh_org_day_item_grp_rm
#  1.3  15.02.2021    Michael Morris           Transfer to Snowflake
#                                              https://jira.schwarz/browse/REP4-8577
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_LEAD.V_AGG_WH_ORG_DAY_ITEM_EJR_ASIS COMMENT = 'Aggregated Preis und Verkaufsdaten (Kasse + Retail + Wawi)'

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_LEAD

AS
SELECT
    agg.client_id
  , wh.src_wh_id      AS wh_id
  , agg.aspect_id
  , itmp.item_sid_map AS item_id
  , agg.dwh_cal_dt    AS dat_formdate
  , agg.discount_sid  AS discount_id
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.cnt_sale ELSE 0 END               AS cnt_discount_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.cnt_sale   ELSE 0 END                                              AS cnt_retail_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.cnt_return ELSE 0 END                                              AS cnt_return_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.sales_piece_qty  ELSE 0 END       AS qty_disc_piece_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.sales_weight_qty ELSE 0 END       AS qty_disc_weight_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.piece_weight_qty ELSE 0 END       AS qty_disc_piece_weigth_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.sales_piece_qty         ELSE 0 END                                 AS qty_piece_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.sales_weight_qty        ELSE 0 END                                 AS qty_weight_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_qty              ELSE 0 END                                 AS qty_return_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.discount_gross_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.discount_net_val / cry.rate_currency_exchange   ELSE 0 END AS val_discount_net_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_qty  <> 0 THEN agg.discount_gross_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_hq_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_qty  <> 0 THEN agg.discount_net_val / cry.rate_currency_exchange   ELSE 0 END AS val_discount_hq_net_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN (agg.discount_base_gross_val + agg.discount_gross_val) / cry.rate_currency_exchange  ELSE NULL END AS val_disc_rtl_gross_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN (agg.discount_base_net_val + agg.discount_net_val) / cry.rate_currency_exchange      ELSE NULL END AS val_disc_rtl_net_ejr_asis
  , agg.sales_gross_val  / cry.rate_currency_exchange                                                           AS val_rtl_ejr_asis
  , agg.return_gross_val / cry.rate_currency_exchange                                                           AS val_return_ejr_asis
  , agg.sales_net_val    / cry.rate_currency_exchange                                                           AS val_rtl_net_ejr_asis
  , agg.return_net_val   / cry.rate_currency_exchange                                                           AS val_return_net_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.piece_weight_qty           ELSE 0 END                              AS qty_piece_weight_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_piece_weight_qty    ELSE 0 END                              AS qty_rt_piece_weight_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_defect_qty          ELSE 0 END                              AS qty_return_defect_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_saleable_qty        ELSE 0 END                              AS qty_return_saleable_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_defect_pc_wt_qty    ELSE 0 END                              AS qty_rt_pc_wt_defect_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_saleable_pc_wt_qty  ELSE 0 END                              AS qty_rt_pc_wt_saleable_ejr_asis
    /* Foodaction  */
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.sales_piece_fa_qty  ELSE 0 END AS qty_disc_piece_fa_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.sales_weight_fa_qty ELSE 0 END AS qty_disc_weight_fa_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.piece_weight_fa_qty ELSE 0 END AS qty_disc_piece_wt_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.sales_piece_fa_qty         ELSE 0 END                              AS qty_piece_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.sales_weight_fa_qty        ELSE 0 END                              AS qty_weight_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_fa_qty              ELSE 0 END                              AS qty_return_fa_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.discount_gross_fa_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_fa_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.discount_net_fa_val / cry.rate_currency_exchange   ELSE 0 END AS val_discount_net_fa_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_fa_qty  <> 0 THEN agg.discount_gross_fa_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_hq_fa_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_fa_qty  <> 0 THEN agg.discount_net_fa_val / cry.rate_currency_exchange   ELSE 0 END AS val_disc_hq_net_fa_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN (agg.return_piece_weight_fa_qty + agg.discount_gross_fa_val) / cry.rate_currency_exchange  ELSE NULL END AS val_disc_rtl_gross_fa_ejr_asis
  , CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN (agg.return_piece_weight_fa_qty + agg.discount_net_fa_val) / cry.rate_currency_exchange    ELSE NULL END AS val_disc_rtl_net_fa_ejr_asis
  , agg.sales_gross_fa_val  / cry.rate_currency_exchange                                                        AS val_rtl_fa_ejr_asis
  , agg.return_gross_fa_val / cry.rate_currency_exchange                                                        AS val_return_fa_ejr_asis
  , agg.sales_net_fa_val    / cry.rate_currency_exchange                                                        AS val_rtl_net_fa_ejr_asis
  , agg.return_net_fa_val   / cry.rate_currency_exchange                                                        AS val_return_net_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.piece_weight_fa_qty          ELSE 0 END                            AS qty_piece_weight_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_piece_weight_fa_qty   ELSE 0 END                            AS qty_rt_piece_wt_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_defect_fa_qty         ELSE 0 END                            AS qty_return_defect_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_saleable_fa_qty       ELSE 0 END                            AS qty_return_sale_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_defect_pc_wt_fa_qty   ELSE 0 END                            AS qty_rt_pc_wt_dfct_fa_ejr_asis
  , CASE WHEN agg.discount_sid = -1 THEN agg.return_saleable_pc_wt_fa_qty ELSE 0 END                            AS qty_rt_pc_wt_sale_fa_ejr_asis
  , cry.currency_iso_cd
FROM p_lew_bil_ac.v_agg_pos_wh_org_day_item_asis AS agg
/* Auflösung WH  */
INNER JOIN p_lew_bil_ac.v_warehouse AS wh
ON  wh.client_id     = agg.client_id
AND wh.loc_sid_wh    =  agg.loc_sid_wh
AND wh.dwh_actual_fg = 1
INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate AS cry
ON  agg.client_id = cry.client_id
AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
/* Ermittlung der Klammer-SID als "richtigste" SID dieses Artikel 
   Hauptsächlich zum Bugfix wg. HQ-Master-Nachlieferungen von SAP-Artikeln und wegen 
   dortiger Fehlerfassung eigentlich bereits korrekt angelegter Artikel */
INNER JOIN p_lew_core_ac.v_item_map_key AS itmp
ON  itmp.client_id = agg.client_id
AND itmp.item_sid  = agg.item_sid
;
