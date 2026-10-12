/* DescStart
 $Revision: 10107 $, $LastChangedBy: umeister $
 SubjectAreas:
 DescEnd */
CREATE OR REPLACE VIEW ldl_p_lew_mart_msi.v_agg_wh_org_merg_day_item_ejr (client_id, wh_id, aspect_id, item_id,
dat_formdate, discount_id, foodaction_fg, qty_discount_pos_ejr, qty_discount_hq_ejr, cnt_retail_ejr, cnt_return_ejr,
qty_piece_ejr, qty_weight_ejr, qty_piece_weight_ejr, qty_return_ejr, val_discount_gross_ejr, val_discount_net_ejr,
val_discount_base_gross_ejr, val_discount_base_net_ejr, val_rtl_gross_ejr, val_return_gross_ejr, val_rtl_net_ejr,
val_return_net_ejr, qty_return_piece_weight_ejr, qty_return_defect_ejr, qty_return_saleable_ejr,
qty_return_pc_wt_defect_ejr, qty_return_pc_wt_saleable_ejr) AS SELECT AGG.client_id,
 AGG.loc_sid_wh AS wh_id,
 AGG.aspect_id,
 AGG.item_sid AS item_id,
 AGG.dwh_cal_dt AS dat_formdate,
 AGG.discount_sid AS discount_id,
  CASE
  WHEN FA.client_id IS NOT NULL
  THEN 1
  ELSE 0
  END AS foodaction_fg,
 AGG.discount_weight_qty AS qty_discount_pos_ejr,
 AGG.discount_piece_qty AS qty_discount_hq_ejr,
 AGG.cnt_sale AS cnt_retail_ejr,
 AGG.cnt_return AS cnt_return_ejr,
 AGG.sales_piece_qty AS qty_piece_ejr,
 AGG.sales_weight_qty AS qty_weight_ejr,
 AGG.piece_weight_qty AS qty_piece_weight_ejr,
 AGG.return_qty AS qty_return_ejr,
 AGG.discount_gross_val AS val_discount_gross_ejr,
 AGG.discount_net_val AS val_discount_net_ejr,
 AGG.discount_base_gross_val AS val_discount_base_gross_ejr,
 AGG.discount_base_net_val AS val_discount_base_net_ejr,
 AGG.sales_gross_val AS val_rtl_gross_ejr,
 AGG.return_gross_val AS val_return_gross_ejr,
 AGG.sales_net_val AS val_rtl_net_ejr,
 AGG.return_net_val AS val_return_net_ejr,
 AGG.return_piece_weight_qty AS qty_return_piece_weight_ejr,
 AGG.return_defect_qty AS qty_return_defect_ejr,
 AGG.return_saleable_qty AS qty_return_saleable_ejr,
 AGG.return_defect_pc_wt_qty AS qty_return_pc_wt_defect_ejr,
 AGG.return_saleable_pc_wt_qty AS qty_return_pc_wt_saleable_ejr
FROM ldl_p_lew_bil_ac.v_agg_pos_wh_org_day_item_asis AS AGG
 LEFT JOIN ldl_p_lew_bil_ac.v_item_foodaction_hist AS FA ON AGG.client_id = FA.client_id AND AGG.item_sid = FA.item_sid
  AND AGG.dwh_cal_dt BETWEEN FA.dwh_valid_from AND FA.dwh_valid_to;