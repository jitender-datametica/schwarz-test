
/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for lew_mart_msi.v_agg_wh_mth_item_ejr_asis_2
#----------------------------------------------------------------------------
# History:
#  1.0  18.09.2017    -                        Generiert aus Teradata
#  1.1  15.11.2017    Wieber.Harald            Release 1.1
#  1.2  17.01.2018    Wieber.Harald            Release 2.2
#  1.3  25.06.2018    Michael Ueding           Aktivierung CAR
#  1.4  04.07.2018    Wieber,Harald            Fiy Comment Failures
#  1.6  24.07.2018    Michael Ueding           Referenz Item_2 Mapping geaendert
#  1.7  06.08.2018    Michael Ueding           Default discount_id auf -1 geaendert
#  1.8  29.10.2018    Arnold,Arne              V_LOC_MAP_KEY_2 mit V_WAREHOUSE_2 ersetzt
#  1.9  13.02.2019    Thole,Jens               renaming discount_sid aus Basis zu discount_id für Martstabilität
# 1.10  14.03.2019    Meister,Ulrich           Umstellung DDL zur Verwendung in Rollback-fähigen Patches
# 1.11  26.02.2021    Michael Morris           20210226_2764_agg_item_wh_mth - Added JOIN to lew_core_ac.v_tem_map_key
#                                              and use attribute item_sid_map as item_id
#                                              https://jira.schwarz/browse/REP4-8682
#----------------------------------------------------------------------------
*/
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_WH_MTH_ITEM_EJR_ASIS_2 COMMENT = 'Aggregated Warehouse Monthly Item_2 Turnovers'

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   /*
   DescStart
   $Revision: 10107 $, $LastChangedBy: umeister $
   SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
   DescEnd
   */
   SELECT
           agg.client_id,
            wh.src_wh_id                    AS wh_id,
             k.item_sid_map                 AS item_id,
           agg.cy_month                     AS month_id,
           agg.discount_sid                 AS discount_id,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.cnt_sale ELSE 0 END AS cnt_discount_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.cnt_sale ELSE 0 END AS cnt_retail_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.cnt_return ELSE 0 END AS cnt_return_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.cnt_void   ELSE 0 END AS cnt_void_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.sales_piece_qty        ELSE 0 END AS qty_disc_piece_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.sales_weight_qty       ELSE 0 END AS qty_disc_weight_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN agg.piece_weight_qty ELSE 0 END AS qty_disc_piece_weigth_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.sales_piece_qty        ELSE 0 END AS qty_piece_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.sales_weight_qty       ELSE 0 END AS qty_weight_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_qty       ELSE 0 END AS qty_return_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.void_qty         ELSE 0 END AS qty_void_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN  agg.discount_gross_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN  agg.discount_net_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_net_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_qty <> 0 THEN  agg.discount_gross_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_hq_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_qty <> 0 THEN  agg.discount_net_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_hq_net_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN  (agg.discount_base_gross_val + agg.discount_gross_val) / cry.rate_currency_exchange  ELSE NULL END AS val_disc_rtl_gross_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_qty <> 0 THEN  (agg.discount_base_net_val + agg.discount_net_val) / cry.rate_currency_exchange  ELSE NULL END AS val_disc_rtl_net_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.piece_weight_qty ELSE 0 END AS qty_piece_weight_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_piece_weight_qty ELSE 0 END AS qty_rt_piece_weight_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_defect_qty ELSE 0 END AS qty_return_defect_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_saleable_qty ELSE 0 END AS qty_return_saleable_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_defect_pc_wt_qty ELSE 0 END AS qty_rt_pc_wt_defect_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_saleable_pc_wt_qty ELSE 0 END AS qty_rt_pc_wt_saleable_ejr_asis,
   agg.sales_gross_val / cry.rate_currency_exchange  AS val_rtl_ejr_asis,
   agg.sales_net_val / cry.rate_currency_exchange    AS val_rtl_net_ejr_asis,
   agg.return_gross_val / cry.rate_currency_exchange AS val_return_ejr_asis,
   agg.return_net_val / cry.rate_currency_exchange   AS val_return_net_ejr_asis,
   agg.void_gross_val / cry.rate_currency_exchange   AS val_void_ejr_asis,
   agg.void_net_val / cry.rate_currency_exchange     AS val_void_net_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.sales_piece_fa_qty        ELSE 0 END AS qty_disc_piece_fa_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.sales_weight_fa_qty       ELSE 0 END AS qty_disc_weight_fa_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN agg.piece_weight_fa_qty ELSE 0 END AS qty_disc_piece_wt_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.sales_piece_fa_qty        ELSE 0 END AS qty_piece_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.sales_weight_fa_qty       ELSE 0 END AS qty_weight_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_fa_qty       ELSE 0 END AS qty_return_fa_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN  agg.discount_gross_fa_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_fa_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN  agg.discount_net_fa_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_net_fa_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_fa_qty <> 0 THEN  agg.discount_gross_fa_val / cry.rate_currency_exchange ELSE 0 END AS val_discount_hq_fa_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_piece_fa_qty <> 0 THEN  agg.discount_net_fa_val / cry.rate_currency_exchange ELSE 0 END AS val_disc_hq_net_fa_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN  (agg.return_piece_weight_fa_qty + agg.discount_gross_fa_val) / cry.rate_currency_exchange  ELSE NULL END AS val_disc_rtl_gross_fa_ejr_asis,
   CASE WHEN agg.discount_sid > -1 AND agg.discount_weight_fa_qty <> 0 THEN  (agg.return_piece_weight_fa_qty + agg.discount_net_fa_val) / cry.rate_currency_exchange  ELSE NULL END AS val_disc_rtl_net_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.piece_weight_fa_qty ELSE 0 END AS qty_piece_weight_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_piece_weight_fa_qty ELSE 0 END AS qty_rt_piece_wt_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_defect_fa_qty ELSE 0 END AS qty_return_defect_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_saleable_fa_qty ELSE 0 END AS qty_return_sale_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_defect_pc_wt_fa_qty ELSE 0 END AS qty_rt_pc_wt_dfct_fa_ejr_asis,
   CASE WHEN agg.discount_sid = -1     THEN agg.return_saleable_pc_wt_fa_qty ELSE 0 END AS qty_rt_pc_wt_sale_fa_ejr_asis,
   agg.sales_gross_fa_val / cry.rate_currency_exchange  AS val_rtl_fa_ejr_asis,
   agg.sales_net_fa_val / cry.rate_currency_exchange    AS val_rtl_net_fa_ejr_asis,
   agg.return_gross_fa_val / cry.rate_currency_exchange AS val_return_fa_ejr_asis,
   agg.return_net_fa_val / cry.rate_currency_exchange   AS val_return_net_fa_ejr_asis,
   cry.currency_iso_cd
   FROM p_lew_bil_ac.v_agg_pos_wh_mth_item_asis_2 AS agg
   INNER JOIN p_lew_bil_ac.v_warehouse_2 AS wh
   ON wh.client_id = agg.client_id
   AND wh.loc_sid_wh = agg.loc_sid_wh
   AND wh.dwh_actual_fg = 1
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
   ON  agg.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
   INNER JOIN p_lew_core_ac.v_item_map_key_2 AS k
      ON agg.client_id = k.client_id
     AND agg.item_sid  = k.item_sid
;
