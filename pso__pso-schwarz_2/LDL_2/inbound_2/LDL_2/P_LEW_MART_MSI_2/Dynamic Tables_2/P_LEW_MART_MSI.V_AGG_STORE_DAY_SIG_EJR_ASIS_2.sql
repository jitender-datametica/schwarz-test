
CREATE OR REPLACE DYNAMIC TABLE P_LEW_MART_MSI.V_AGG_STORE_DAY_SIG_EJR_ASIS_2
/*
descstart
$revision: $, $lastchangedby: $
subjectareas: preis und verkaufsdaten (kasse + retail + wawi)
descend
*/
(
     client_id
,          subitemgroup_id
,          store_id
,          orig_store_nr
,          dat_formdate
,          discount_id
,          cnt_discount_ejr_asis
,          cnt_retail_ejr_asis
,          cnt_return_ejr_asis
,          cnt_void_ejr_asis
,          qty_disc_piece_ejr_asis
,          qty_disc_weight_ejr_asis
,          qty_disc_piece_weigth_ejr_asis
,          qty_piece_ejr_asis
,          qty_weight_ejr_asis
,          qty_return_ejr_asis
,          val_discount_ejr_asis
,          val_discount_net_ejr_asis
,          val_discount_hq_ejr_asis
,          val_discount_hq_net_ejr_asis
,          val_disc_rtl_gross_ejr_asis
,          val_disc_rtl_net_ejr_asis
,          qty_piece_weight_ejr_asis
,          qty_rt_piece_weight_ejr_asis
,          qty_return_defect_ejr_asis
,          qty_return_saleable_ejr_asis
,          qty_rt_pc_wt_defect_ejr_asis
,          qty_rt_pc_wt_saleable_ejr_asis
,          val_rtl_ejr_asis
,          val_rtl_net_ejr_asis
,          val_return_ejr_asis
,          val_return_net_ejr_asis
,          qty_disc_piece_fa_ejr_asis
,          qty_disc_weight_fa_ejr_asis
,          qty_disc_piece_wt_fa_ejr_asis
,          qty_piece_fa_ejr_asis
,          qty_weight_fa_ejr_asis
,          qty_return_fa_ejr_asis
,          val_discount_fa_ejr_asis
,          val_discount_net_fa_ejr_asis
,          val_discount_hq_fa_ejr_asis
,          val_disc_hq_net_fa_ejr_asis
,          val_disc_rtl_gross_fa_ejr_asis
,          val_disc_rtl_net_fa_ejr_asis
,          qty_piece_weight_fa_ejr_asis
,          qty_rt_piece_wt_fa_ejr_asis
,          qty_return_defect_fa_ejr_asis
,          qty_return_sale_fa_ejr_asis
,          qty_rt_pc_wt_dfct_fa_ejr_asis
,          qty_rt_pc_wt_sale_fa_ejr_asis
,          val_rtl_fa_ejr_asis
,          val_rtl_net_fa_ejr_asis
,          val_return_fa_ejr_asis
,          val_return_net_fa_ejr_asis
,          currency_iso_cd
)

TARGET_LAG = '1 hour, 30 minutes' 
REFRESH_MODE = FULL 
INITIALIZE = ON_CREATE 
WAREHOUSE = WH_LDL_%%environmentAbbreviation%%_DYNAMIC_TABLE_P_LEW_MART_MSI

AS
   (
SELECT
agg.client_id,
   CAST(sig.src_subitemgrp_cd AS INTEGER) AS subitemgroup_id,
   agg.loc_sid_store AS store_id,
   l.src_orig_store_nr AS orig_store_nr,
   agg.dwh_cal_dt AS dat_formdate,
   agg.discount_sid AS discount_id,
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
   FROM p_lew_bil_ac.v_agg_pos_store_day_sig_asis_2 AS agg
   INNER JOIN p_lew_core_ac.v_subitemgroup_2 AS sig
   ON agg.client_id = sig.client_id
   AND agg.sub_item_grp_sid = sig.sub_item_grp_sid
   INNER JOIN p_lew_core_ac.v_location_2 AS l
   ON agg.client_id = l.client_id
   AND agg.loc_sid_store = l.loc_sid
   INNER JOIN p_lew_core_ac.v_wawi_ref_client_currency_rate_2 AS cry
   ON agg.client_id = cry.client_id
   AND CURRENT_DATE BETWEEN cry.dat_rec_start AND cry.dat_rec_end
       )
;
