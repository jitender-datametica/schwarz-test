CREATE OR REPLACE MATERIALIZED VIEW ldl_p_lew_mart_msi.v_agg_stor_mth_sig_ejr_asis_bo_1
OPTIONS(ENABLE_REFRESH = TRUE, REFRESH_INTERVAL_MINUTES = 90) AS
SELECT AGG.loc_sid_store AS store_id,
 AGG.client_id,
 ROUND(CAST(SIG.src_subitemgrp_cd AS BIGNUMERIC), 0) AS subitemgroup_id,
 AGG.cy_month,
 LOC.src_orig_store_nr AS orig_store_nr,
 AGG.discount_sid AS discount_id,
 AGG.cnt_sale AS cnt_retail_ejr_asis,
 AGG.cnt_return AS cnt_return_ejr_asis,
 AGG.cnt_void AS cnt_void_ejr_asis,
 AGG.piece_weight_qty AS qty_piece_ejr_asis,
 AGG.sales_weight_qty AS qty_weight_ejr_asis,
 AGG.return_qty AS qty_return_ejr_asis,
 AGG.void_qty AS qty_void_ejr_asis,
 AGG.sales_gross_val AS val_rtl_gross_ejr_asis,
 AGG.sales_net_val AS val_rtl_net_ejr_asis,
 AGG.return_gross_val AS val_return_gross_ejr_asis,
 AGG.return_net_val AS val_return_net_ejr_asis,
 AGG.void_gross_val AS val_void_gross_ejr_asis,
 AGG.void_net_val AS val_void_net_ejr_asis,
 AGG.discount_gross_val AS val_discount_gross_ejr_asis,
 AGG.discount_net_val AS val_discount_net_ejr_asis,
 AGG.piece_weight_qty AS qty_piece_weight_ejr_asis,
 AGG.return_piece_weight_qty AS qty_rt_piece_weight_ejr_asis,
 AGG.sales_orig_gross_val AS val_retail_orig_gross_ejr_asis,
 AGG.sales_orig_net_val AS val_retail_orig_net_ejr_asis,
 AGG.discount_base_gross_val AS val_disc_base_gross_ejr_asis,
 AGG.discount_base_net_val AS val_disc_base_net_ejr_asis,
 AGG.discount_weight_qty AS qty_discount_pos_ejr_asis,
 AGG.discount_piece_qty AS qty_discount_hq_ejr_asis,
 AGG.return_defect_qty AS qty_return_defect_ejr_asis,
 AGG.return_saleable_qty AS qty_return_saleable_ejr_asis,
 AGG.return_defect_pc_wt_qty AS qty_rt_pc_wt_defect_ejr_asis,
 AGG.return_saleable_pc_wt_qty AS qty_rt_pc_wt_saleable_ejr_asis
FROM ldl_p_lew_bil_ac.v_agg_pos_store_mth_sig_asis_1 AS AGG
 INNER JOIN ldl_p_lew_core_ac.v_subitemgroup_1 AS SIG ON AGG.client_id = SIG.client_id AND AGG.sub_item_grp_sid = SIG.sub_item_grp_sid
   
 INNER JOIN ldl_p_lew_core_ac.v_location_1 AS LOC ON AGG.client_id = LOC.client_id AND AGG.loc_sid_store = LOC.loc_sid;