CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT_BO_BASE_ABS_1
AS
/* Bestimmung aller beschreibenden Informationen

   Die View ist die zweite Ebene zur Ziel-View v_mat_bo_base_abs_1 und deren Materialisierung
   v_mat0_bo_base_abs_1 ---> v_mat1_bo_base_abs_1---> v_mat_bo_base_abs_1 ---> t_bo_base_abs_1 */
SELECT
agg.client_id,
agg.store_id,
agg.dat_formdate,
agg.cy_week,
agg.cy_week_seq,
agg.cy_month,
agg.currency_iso_cd,
agg.sub_item_grp_sid,
agg.subitemgroup_id,
agg.item_grp_int_sid,
agg.itemgroup_int_id,
descs.country_id,
descs.country_desc,
descs.country_iso_cd,
descs.orig_store_nr,
descs.store_desc,
descs.wh_id,
descs.wh_desc,
descs.city,
descs.account_manager_id,
descs.account_manager_name,
descs.sales_manager_id,
descs.sales_manager_name,
agg.val_rtl_rl_sfo,
agg.val_rtl_rl_net_sfo,
agg.val_rtl_net_sfo_mhd_break,
agg.val_rtl_net_sfo_other_stc_loss,
agg.val_rtl_net_sfo_str_deliv_qlty,
agg.val_rtl_rl_sfo_py,
agg.val_rtl_rl_net_sfo_py,
agg.val_net_sfo_mhd_break_py,
agg.val_net_sfo_other_stc_loss_py,
agg.val_net_sfo_str_deliv_qlty_py,
agg.val_wrtoff_zero,
agg.val_wrtoff_zero_net,
agg.val_wrtoff_zero_net_mhd_break,
agg.val_wrtoff_zero_net_other_stc_loss,
agg.val_wrtoff_zero_net_str_deliv_qlty,
agg.val_discount_ejr,
agg.val_discount_net_ejr,
agg.val_rtl_ejr_adj,
agg.val_rtl_net_ejr_adj,
agg.val_rtl_ejr_adj_py,
agg.val_rtl_net_ejr_adj_py,
DATE '1800-01-01' AS dwh_updated
FROM p_lew_mart_msi.v_mat1_bo_base_abs_1 AS agg
INNER JOIN p_lew_mart_msi.v_bo_descs_1 AS descs
ON agg.client_id = descs.client_id
AND agg.store_id = descs.store_id
;



