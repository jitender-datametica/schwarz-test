CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_store_mth_sig_ejr_asis_1 AS SELECT AGG.client_id,
 AGG.loc_sid_store AS store_id,
 ROUND(CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
 AGG.cy_month AS month_id,
 AGG.discount_sid AS discount_id,
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
  THEN AGG.sales_weight_qty
  ELSE 0
  END AS qty_weight_ejr_asis,
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
  AGG.sales_gross_val / CRY.rate_currency_exchange AS val_rtl_ejr_asis,
  AGG.sales_net_val / CRY.rate_currency_exchange AS val_rtl_net_ejr_asis,
  AGG.return_gross_val / CRY.rate_currency_exchange AS val_return_ejr_asis,
  AGG.return_net_val / CRY.rate_currency_exchange AS val_return_net_ejr_asis,
  AGG.void_gross_val / CRY.rate_currency_exchange AS val_void_ejr_asis,
  AGG.void_net_val / CRY.rate_currency_exchange AS val_void_net_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_fa_qty <> 0
  THEN AGG.sales_piece_fa_qty
  ELSE 0
  END AS qty_disc_piece_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_fa_qty <> 0
  THEN AGG.sales_weight_fa_qty
  ELSE 0
  END AS qty_disc_weight_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_fa_qty <> 0
  THEN AGG.piece_weight_fa_qty
  ELSE 0
  END AS qty_disc_piece_wt_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.sales_piece_fa_qty
  ELSE 0
  END AS qty_piece_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.sales_weight_fa_qty
  ELSE 0
  END AS qty_weight_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_fa_qty
  ELSE 0
  END AS qty_return_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_fa_qty <> 0
  THEN AGG.discount_gross_fa_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_fa_qty <> 0
  THEN AGG.discount_net_fa_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_net_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_piece_fa_qty <> 0
  THEN AGG.discount_gross_fa_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_discount_hq_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_piece_fa_qty <> 0
  THEN AGG.discount_net_fa_val / CRY.rate_currency_exchange
  ELSE 0
  END AS val_disc_hq_net_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_fa_qty <> 0
  THEN (AGG.return_piece_weight_fa_qty + AGG.discount_gross_fa_val) / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_disc_rtl_gross_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid > - 1 AND AGG.discount_weight_fa_qty <> 0
  THEN (AGG.return_piece_weight_fa_qty + AGG.discount_net_fa_val) / CRY.rate_currency_exchange
  ELSE NULL
  END AS val_disc_rtl_net_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.piece_weight_fa_qty
  ELSE 0
  END AS qty_piece_weight_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_piece_weight_fa_qty
  ELSE 0
  END AS qty_rt_piece_wt_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_defect_fa_qty
  ELSE 0
  END AS qty_return_defect_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_saleable_fa_qty
  ELSE 0
  END AS qty_return_sale_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_defect_pc_wt_fa_qty
  ELSE 0
  END AS qty_rt_pc_wt_dfct_fa_ejr_asis,
  CASE
  WHEN AGG.discount_sid = - 1
  THEN AGG.return_saleable_pc_wt_fa_qty
  ELSE 0
  END AS qty_rt_pc_wt_sale_fa_ejr_asis,
  AGG.sales_gross_fa_val / CRY.rate_currency_exchange AS val_rtl_fa_ejr_asis,
  AGG.sales_net_fa_val / CRY.rate_currency_exchange AS val_rtl_net_fa_ejr_asis,
  AGG.return_gross_fa_val / CRY.rate_currency_exchange AS val_return_fa_ejr_asis,
  AGG.return_net_fa_val / CRY.rate_currency_exchange AS val_return_net_fa_ejr_asis,
 CRY.currency_iso_cd
FROM ldl_p_lew_bil_ac.v_agg_pos_store_mth_sig_asis_1 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_1 AS SIG ON AGG.client_id = SIG.client_id AND AGG.sub_item_grp_sid = SIG.sub_item_grp_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_wawi_ref_client_currency_rate_1 AS CRY ON AGG.client_id = CRY.client_id AND CURRENT_DATE
   BETWEEN CRY.dat_rec_start AND CRY.dat_rec_end;