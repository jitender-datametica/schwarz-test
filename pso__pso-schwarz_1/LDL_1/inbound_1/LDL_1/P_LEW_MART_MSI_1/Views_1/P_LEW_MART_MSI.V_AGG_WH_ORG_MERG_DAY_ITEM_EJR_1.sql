CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_WH_ORG_MERG_DAY_ITEM_EJR_1
/*
 DescStart
 $Revision: 10107 $, $LastChangedBy: umeister $
 SubjectAreas:
 DescEnd
 */
(
   client_id
  ,wh_id
  ,aspect_id
  ,item_id
  ,dat_formdate
  ,discount_id
  ,foodaction_fg
  ,qty_discount_pos_ejr
  ,qty_discount_hq_ejr
  ,cnt_retail_ejr
  ,cnt_return_ejr
  ,qty_piece_ejr
  ,qty_weight_ejr
  ,qty_piece_weight_ejr
  ,qty_return_ejr
  ,val_discount_gross_ejr
  ,val_discount_net_ejr
  ,val_discount_base_gross_ejr
  ,val_discount_base_net_ejr
  ,val_rtl_gross_ejr
  ,val_return_gross_ejr
  ,val_rtl_net_ejr
  ,val_return_net_ejr
  ,qty_return_piece_weight_ejr
  ,qty_return_defect_ejr
  ,qty_return_saleable_ejr
  ,qty_return_pc_wt_defect_ejr
  ,qty_return_pc_wt_saleable_ejr
)
AS
   SELECT
      agg.client_id                                        AS client_id,
   agg.loc_sid_wh                                       AS wh_id,
   agg.aspect_id                                        AS aspect_id,
   agg.item_sid                                         AS item_id,
   agg.dwh_cal_dt                                       AS dat_formdate,
   agg.discount_sid                                     AS discount_id,
   CASE WHEN fa.client_id IS NOT NULL THEN 1 ELSE 0 END AS foodaction_fg,
   agg.discount_weight_qty                              AS qty_discount_pos_ejr,
   agg.discount_piece_qty                               AS qty_discount_hq_ejr,
   agg.cnt_sale                                         AS cnt_retail_ejr,
   agg.cnt_return                                       AS cnt_return_ejr,
   agg.sales_piece_qty                                  AS qty_piece_ejr,
   agg.sales_weight_qty                                 AS qty_weight_ejr,
   agg.piece_weight_qty                                 AS qty_piece_weight_ejr,
   agg.return_qty                                       AS qty_return_ejr,
   agg.discount_gross_val                               AS val_discount_gross_ejr,
   agg.discount_net_val                                 AS val_discount_net_ejr,
   agg.discount_base_gross_val                          AS val_discount_base_gross_ejr,
   agg.discount_base_net_val                            AS val_discount_base_net_ejr,
   agg.sales_gross_val                                  AS val_rtl_gross_ejr,
   agg.return_gross_val                                 AS val_return_gross_ejr,
   agg.sales_net_val                                    AS val_rtl_net_ejr,
   agg.return_net_val                                   AS val_return_net_ejr,
   agg.return_piece_weight_qty                          AS qty_return_piece_weight_ejr,
   agg.return_defect_qty                                AS qty_return_defect_ejr,
   agg.return_saleable_qty                              AS qty_return_saleable_ejr,
   agg.return_defect_pc_wt_qty                          AS qty_return_pc_wt_defect_ejr,
   agg.return_saleable_pc_wt_qty                        AS qty_return_pc_wt_saleable_ejr
   FROM p_lew_bil_ac.v_agg_pos_wh_org_day_item_asis_1 AS agg
   LEFT OUTER JOIN p_lew_bil_ac.v_item_foodaction_hist_1 AS fa
   ON agg.client_id = fa.client_id
   AND agg.item_sid = fa.item_sid
   AND dwh_cal_dt BETWEEN fa.dwh_valid_from AND fa.dwh_valid_to
;