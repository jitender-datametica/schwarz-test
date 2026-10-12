/*
#----------------------------------------------------------------------------
# @ LIDL Stiftung & Co. KG - DWH / MIS
#----------------------------------------------------------------------------
# Interface: DDL for P_LEW_MART_LEAD.V_AGG_STORE_DAY_ITEM_EJR_ASIS
#----------------------------------------------------------------------------
# History:
#  1.0  18.03.2022    Białek, Aleksander        Implementing Container context (part of Sortimentmodularity, AzureDevops: US 298238, BBT-3750, AP0101040)
#----------------------------------------------------------------------------
*/


CREATE OR REPLACE VIEW ldl_p_lew_mart_lead.v_agg_store_day_item_ejr_asis_somo (client_id, cnt_discount_ejr_asis,
cnt_retail_ejr_asis, cnt_return_ejr_asis, cnt_void_ejr_asis, dat_formdate, cy_month, item_id, orig_store_nr,
container_id, container_hist_id, discount_id, price_rtl_ejr_adjstd_asis, price_rtl_net_ejr_adjstd_asis,
price_rtl_ejr_asis, price_rtl_net_ejr_asis, qty_disc_piece_ejr_asis, qty_disc_weight_ejr_asis,
qty_disc_piece_weigth_ejr_asis, qty_piece_ejr_asis, qty_return_ejr_asis, qty_void_ejr_asis, qty_weight_ejr_asis,
store_id, move_to_store_id, time_last_sold_ejr_asis, val_discount_ejr_asis, val_discount_net_ejr_asis,
val_discount_hq_ejr_asis, val_discount_hq_net_ejr_asis, val_disc_rtl_gross_ejr_asis, val_disc_rtl_net_ejr_asis,
val_return_ejr_asis, val_rtl_ejr_asis, val_void_ejr_asis, val_void_net_ejr_asis, val_rtl_net_ejr_asis,
val_return_net_ejr_asis, qty_piece_weight_ejr_asis, qty_rt_piece_weight_ejr_asis, qty_return_defect_ejr_asis,
qty_return_saleable_ejr_asis, qty_rt_pc_wt_defect_ejr_asis, qty_rt_pc_wt_saleable_ejr_asis, qty_disc_piece_fa_ejr_asis,
qty_disc_weight_fa_ejr_asis, qty_disc_piece_wt_fa_ejr_asis, qty_piece_fa_ejr_asis, qty_return_fa_ejr_asis,
qty_weight_fa_ejr_asis, val_discount_fa_ejr_asis, val_discount_net_fa_ejr_asis, val_discount_hq_fa_ejr_asis,
val_disc_hq_net_fa_ejr_asis, val_disc_rtl_gross_fa_ejr_asis, val_disc_rtl_net_fa_ejr_asis, val_return_fa_ejr_asis,
val_rtl_fa_ejr_asis, val_rtl_net_fa_ejr_asis, val_return_net_fa_ejr_asis, qty_piece_weight_fa_ejr_asis,
qty_rt_piece_wt_fa_ejr_asis, qty_return_defect_fa_ejr_asis, qty_return_sale_fa_ejr_asis, qty_rt_pc_wt_dfct_fa_ejr_asis,
qty_rt_pc_wt_sale_fa_ejr_asis, currency_iso_cd) AS SELECT AGG.client_id,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
  THEN AGG.cnt_sale
  ELSE 0
  END AS cnt_discount_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.cnt_sale
  ELSE 0
  END AS cnt_retail_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.cnt_return
  ELSE 0
  END AS cnt_return_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.cnt_void
  ELSE 0
  END AS cnt_void_ejr_asis,
 AGG.dwh_cal_dt AS dat_formdate,
 AGG.cy_month,
 ITMP.item_sid_map AS item_id,
 LOCN.src_orig_store_nr AS orig_store_nr,
 SM.container_id,
 SM_HIST.container_id AS container_hist_id,
 AGG.discount_sid AS discount_id,
  AGG.total_item_unit_price_adjust_gross / CRY.rate_currency_exchange AS price_rtl_ejr_adjstd_asis,
  AGG.total_item_unit_price_adjust_net / CRY.rate_currency_exchange AS price_rtl_net_ejr_adjstd_asis,
  AGG.total_item_unit_price_gross / CRY.rate_currency_exchange AS price_rtl_ejr_asis,
  AGG.total_item_unit_price_net / CRY.rate_currency_exchange AS price_rtl_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
  THEN AGG.sales_piece_qty
  ELSE 0
  END AS qty_disc_piece_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
  THEN AGG.sales_weight_qty
  ELSE 0
  END AS qty_disc_weight_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
  THEN AGG.piece_weight_qty
  ELSE 0
  END AS qty_disc_piece_weigth_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.sales_piece_qty
  ELSE 0
  END AS qty_piece_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_qty
  ELSE 0
  END AS qty_return_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.void_qty
  ELSE 0
  END AS qty_void_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.sales_weight_qty
  ELSE 0
  END AS qty_weight_ejr_asis,
 AGG.loc_sid_store AS store_id,
 OSM.loc_sid_store_move_to AS move_to_store_id,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.last_sold_tmsp
  ELSE NULL
  END AS time_last_sold_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
  THEN AGG.discount_gross_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
  THEN AGG.discount_net_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_piece_qty <> 0
  THEN AGG.discount_gross_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_hq_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_piece_qty <> 0
  THEN AGG.discount_net_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_hq_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
  THEN (AGG.discount_base_gross_val + AGG.discount_gross_val) / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_disc_rtl_gross_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
  THEN (AGG.discount_base_net_val + AGG.discount_net_val) / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_disc_rtl_net_ejr_asis,
  AGG.return_gross_val / CRY.rate_currency_exchange AS val_return_ejr_asis,
  AGG.sales_gross_val / CRY.rate_currency_exchange AS val_rtl_ejr_asis,
  AGG.void_gross_val / CRY.rate_currency_exchange AS val_void_ejr_asis,
  AGG.void_net_val / CRY.rate_currency_exchange AS val_void_net_ejr_asis,
  AGG.sales_net_val / CRY.rate_currency_exchange AS val_rtl_net_ejr_asis,
  AGG.return_net_val / CRY.rate_currency_exchange AS val_return_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.piece_weight_qty
  ELSE 0
  END AS qty_piece_weight_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_piece_weight_qty
  ELSE 0
  END AS qty_rt_piece_weight_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_defect_qty
  ELSE 0
  END AS qty_return_defect_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_saleable_qty
  ELSE 0
  END AS qty_return_saleable_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_defect_pc_wt_qty
  ELSE 0
  END AS qty_rt_pc_wt_defect_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_saleable_pc_wt_qty
  ELSE 0
  END AS qty_rt_pc_wt_saleable_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
   THEN AGG.sales_piece_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_disc_piece_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
   THEN AGG.sales_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_disc_weight_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
   THEN AGG.piece_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_disc_piece_wt_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.sales_piece_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_piece_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.return_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_return_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.sales_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_weight_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
   THEN AGG.discount_gross_val / CRY.rate_currency_exchange
   ELSE 0
   END
  ELSE NULL
  END AS val_discount_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
   THEN AGG.discount_net_val / CRY.rate_currency_exchange
   ELSE 0
   END
  ELSE NULL
  END AS val_discount_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_piece_qty <> 0
   THEN AGG.discount_gross_val / CRY.rate_currency_exchange
   ELSE 0
   END
  ELSE NULL
  END AS val_discount_hq_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_piece_qty <> 0
   THEN AGG.discount_net_val / CRY.rate_currency_exchange
   ELSE 0
   END
  ELSE NULL
  END AS val_disc_hq_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
   THEN (AGG.discount_base_gross_val + AGG.discount_gross_val) / CRY.rate_currency_exchange
   ELSE NULL
   END
  ELSE NULL
  END AS val_disc_rtl_gross_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_qty <> 0
   THEN (AGG.discount_base_net_val + AGG.discount_net_val) / CRY.rate_currency_exchange
   ELSE NULL
   END
  ELSE NULL
  END AS val_disc_rtl_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.return_gross_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_return_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sales_gross_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_rtl_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.sales_net_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_rtl_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN AGG.return_net_val / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_return_net_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.piece_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_piece_weight_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.return_piece_weight_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_rt_piece_wt_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.return_defect_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_return_defect_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.return_saleable_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_return_sale_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.return_defect_pc_wt_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_rt_pc_wt_dfct_fa_ejr_asis,
  CASE
  WHEN AGG.foodaction_fg_asis = 1
  THEN CASE
   WHEN AGG.discount_sid = - 1
   THEN AGG.return_saleable_pc_wt_qty
   ELSE 0
   END
  ELSE NULL
  END AS qty_rt_pc_wt_sale_fa_ejr_asis,
 CRY.currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_pos_store_item_day AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_location AS LOCN ON AGG.client_id = LOCN.client_id AND AGG.loc_sid_store = LOCN.loc_sid
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end /* Ermittlung der Klammer-SID als "richtigste" SID dieses Artikel */
   /* Hauptsächlich zum Bugfix wg. HQ-Master-Nachlieferungen von SAP-Artikeln und wegen */
   /* dortiger Fehlerfassung eigentlich bereits korrekt angelegter Artikel */
 INNER JOIN ldl_p_lew_core_ac.v_item_map_key AS ITMP ON AGG.client_id = ITMP.client_id AND AGG.item_sid
   /* Get move_to_store_id of respective store */ = ITMP.item_sid
 LEFT JOIN ldl_p_lew_bil_ac.v_org_store_merge AS OSM ON AGG.client_id = OSM.client_id AND AGG.loc_sid_store = OSM.loc_sid_store
     AND OSM.aspect_id = 1
 LEFT JOIN ldl_p_lew_bil_ac.v_sm_map_item_container_str AS SM ON AGG.client_id = SM.client_id AND AGG.item_sid = SM.item_sid
      AND OSM.loc_sid_store_move_to = SM.move_to_store_id AND CURRENT_DATE BETWEEN SM.dat_rec_start AND SM.dat_rec_end
 LEFT JOIN ldl_p_lew_bil_ac.v_sm_map_item_container_str AS SM_HIST ON AGG.client_id = SM_HIST.client_id AND AGG.item_sid
      = SM_HIST.item_sid AND OSM.loc_sid_store_move_to = SM_HIST.move_to_store_id AND AGG.dwh_cal_dt BETWEEN SM_HIST.dat_rec_start
   AND SM_HIST.dat_rec_end;