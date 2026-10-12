CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_STORE_MTH_ITEM_EJR_BO_2 as
   SELECT
      agg.loc_sid_store             AS store_id,
   agg.client_id                 AS client_id,
   itmp.item_sid_map             AS item_id,
   agg.cy_month                  AS cy_month,
   loc.src_orig_store_nr         AS orig_store_nr,
   agg.discount_sid               AS discount_id,
   agg.cnt_sale                  AS cnt_retail_ejr,
   agg.cnt_return                AS cnt_return_ejr,
   agg.cnt_void                  AS cnt_void_ejr,
   agg.piece_weight_qty          AS qty_piece_ejr,
   agg.sales_weight_qty          AS qty_weight_ejr,
   agg.return_qty                AS qty_return_ejr,
   agg.void_qty                  AS qty_void_ejr,
   agg.sales_gross_val           AS val_rtl_gross_ejr,
   agg.sales_net_val             AS val_rtl_net_ejr,
   agg.return_gross_val          AS val_return_gross_ejr,
   agg.return_net_val            AS val_return_net_ejr,
   agg.void_gross_val            AS val_void_gross_ejr,
   agg.void_net_val              AS val_void_net_ejr,
   agg.discount_gross_val        AS val_discount_gross_ejr,
   agg.discount_net_val          AS val_discount_net_ejr,
   agg.piece_weight_qty          AS qty_piece_weight_ejr,
   agg.return_piece_weight_qty   AS qty_rt_piece_weight_ejr,
   agg.sales_orig_gross_val      AS val_retail_orig_gross_ejr,
   agg.sales_orig_net_val        AS val_retail_orig_net_ejr,
   agg.discount_base_gross_val   AS val_disc_base_gross_ejr,
   agg.discount_base_net_val     AS val_disc_base_net_ejr,
   agg.discount_weight_qty       AS qty_discount_pos_ejr,
   agg.discount_piece_qty        AS qty_discount_hq_ejr,
   agg.return_defect_qty         AS qty_return_defect_ejr,
   agg.return_saleable_qty       AS qty_return_saleable_ejr,
   agg.return_defect_pc_wt_qty   AS qty_rt_pc_wt_defect_ejr,
   agg.return_saleable_pc_wt_qty AS qty_rt_pc_wt_saleable_ejr,
   agg.cnt_distinct_receipt      AS cnt_receipt_ejr
   FROM p_lew_bil_ac.v_agg_pos_store_item_mth_2 agg
   INNER JOIN p_lew_core_ac.v_location_2 AS loc
   ON agg.client_id = loc.client_id
   AND agg.loc_sid_store = loc.loc_sid
   INNER JOIN p_lew_core_ac.v_item_map_key_2 itmp
   ON itmp.client_id = agg.client_id
   AND itmp.item_sid = agg.item_sid
;