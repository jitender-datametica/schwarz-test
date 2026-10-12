CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STORE_DAY_ITEM_EJR_BO
/*
DescStart
$Revision: 10107 $, $LastChangedBy: umeister $
SubjectAreas: Preis und Verkaufsdaten (Kasse + Retail + Wawi)
DescEnd
*/
(
     store_id
,          client_id
,          item_id
,          dat_formdate
,          cy_month
,          orig_store_nr
,          discount_id
,          time_last_sold_ejr
,          cnt_retail_ejr
,          cnt_return_ejr
,          cnt_void_ejr
,          price_rtl_gross_ejr
,          price_rtl_net_ejr
,          price_rtl_gross_ejr_adjstd
,          price_rtl_net_ejr_adjstd
,          qty_piece_ejr
,          qty_weight_ejr
,          qty_piece_weight_ejr
,          qty_return_ejr
,          qty_void_ejr
,          val_rtl_gross_ejr
,          val_rtl_net_ejr
,          val_return_gross_ejr
,          val_return_net_ejr
,          val_void_gross_ejr
,          val_void_net_ejr
,          val_discount_gross_ejr
,          val_discount_net_ejr
,          qty_return_piece_weight_ejr
,          val_retail_orig_gross_ejr
,          val_retail_orig_net_ejr
,          val_discount_base_gross_ejr
,          val_discount_base_net_ejr
,          qty_discount_pos_ejr
,          qty_discount_hq_ejr
,          qty_return_defect_ejr
,          qty_return_saleable_ejr
,          qty_return_pc_wt_defect_ejr
,          qty_return_pc_wt_saleable_ejr
,          cnt_receipt_ejr
)
AS
   (
        SELECT      Agg.loc_sid_store                         AS store_id,
   Agg.client_id                             AS client_id,
   Agg.item_sid                              AS item_id,
   Agg.dwh_cal_dt                            AS dat_formdate,
   Agg.cy_month                              AS cy_month,
   Locn.src_orig_store_nr                    AS orig_store_nr,
   Agg.discount_sid                           AS discount_id,
   Agg.last_sold_tmsp                        AS time_last_sold_ejr,
   Agg.cnt_sale                              AS cnt_retail_ejr,
   Agg.cnt_return                            AS cnt_return_ejr,
   Agg.cnt_void                              AS cnt_void_ejr,
   Agg.total_item_unit_price_gross           AS price_rtl_gross_ejr,
   Agg.total_item_unit_price_net             AS price_rtl_net_ejr,
   Agg.total_item_unit_price_adjust_gross    AS price_rtl_gross_ejr_adjstd,
   Agg.total_item_unit_price_adjust_net      AS price_rtl_net_ejr_adjstd,
   Agg.sales_piece_qty                       AS qty_piece_ejr,
   Agg.sales_weight_qty                      AS qty_weight_ejr,
   Agg.piece_weight_qty                      AS qty_piece_weight_ejr,
   Agg.return_qty                            AS qty_return_ejr,
   Agg.void_qty                              AS qty_void_ejr,
   Agg.sales_gross_val                       AS val_rtl_gross_ejr,
   Agg.sales_net_val                         AS val_rtl_net_ejr,
   Agg.return_gross_val                      AS val_return_gross_ejr,
   Agg.return_net_val                        AS val_return_net_ejr,
   Agg.void_gross_val                        AS val_void_gross_ejr,
   Agg.void_net_val                          AS val_void_net_ejr,
   Agg.discount_gross_val                    AS val_discount_gross_ejr,
   Agg.discount_net_val                      AS val_discount_net_ejr,
   Agg.return_piece_weight_qty               AS qty_return_piece_weight_ejr,
   Agg.sales_orig_gross_val                  AS val_retail_orig_gross_ejr,
   Agg.sales_orig_net_val                    AS val_retail_orig_net_ejr,
   Agg.discount_base_gross_val               AS val_discount_base_gross_ejr,
   Agg.discount_base_net_val                 AS val_discount_base_net_ejr,
   Agg.discount_weight_qty                   AS qty_discount_pos_ejr,
   Agg.discount_piece_qty                    AS qty_discount_hq_ejr,
   Agg.return_defect_qty                     AS qty_return_defect_ejr,
   Agg.return_saleable_qty                   AS qty_return_saleable_ejr,
   Agg.return_defect_pc_wt_qty               AS qty_return_pc_wt_defect_ejr,
   Agg.return_saleable_pc_wt_qty             AS qty_return_pc_wt_saleable_ejr,
   Agg.cnt_distinct_receipt                  AS cnt_receipt_ejr
FROM p_lew_bil_ac.v_agg_pos_store_item_day        AS Agg
   INNER JOIN p_lew_core_ac.v_location        AS Locn
   ON     Agg.client_id = Locn.client_id
   AND
    Agg.loc_sid_store = Locn.loc_sid
)
;