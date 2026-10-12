CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_MAT1_BO_BASE_ABS as
      SELECT basis.client_id,	
      basis.store_id,	
      basis.dat_formdate,	
      basis.cy_week,	
      basis.cy_week_seq,	
      basis.cy_month,	
      basis.currency_iso_cd,	
      basis.sub_item_grp_sid,	
      basis.subitemgroup_id,	
      basis.item_grp_int_sid,	
      basis.itemgroup_int_id,	
      Sum(basis.val_rtl_rl_sfo) AS val_rtl_rl_sfo,	
      Sum(basis.val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo,	
      Sum(basis.val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,	
      Sum(basis.val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,	
      Sum(basis.val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,	
      Sum(basis.val_rtl_rl_sfo_py) AS val_rtl_rl_sfo_py,	
      Sum(basis.val_rtl_rl_net_sfo_py) AS val_rtl_rl_net_sfo_py,	
      Sum(basis.val_net_sfo_mhd_break_py) AS val_net_sfo_mhd_break_py,	
      Sum(basis.val_net_sfo_other_stc_loss_py) AS val_net_sfo_other_stc_loss_py,	
      Sum(basis.val_net_sfo_str_deliv_qlty_py) AS val_net_sfo_str_deliv_qlty_py,	
      Sum(basis.val_wrtoff_zero) AS val_wrtoff_zero,	
      Sum(basis.val_wrtoff_zero_net) AS val_wrtoff_zero_net,	
      Sum(basis.val_wrtoff_zero_net_mhd_break)      AS val_wrtoff_zero_net_mhd_break,	
      Sum(basis.val_wrtoff_zero_net_other_stc_loss) AS val_wrtoff_zero_net_other_stc_loss,	
      Sum(basis.val_wrtoff_zero_net_str_deliv_qlty) AS val_wrtoff_zero_net_str_deliv_qlty,	
      Sum(basis.val_discount_ejr) AS val_discount_ejr,	
      Sum(basis.val_discount_net_ejr) AS val_discount_net_ejr,	
      Sum(basis.val_rtl_ejr_adj) AS val_rtl_ejr_adj,	
      Sum(basis.val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj,	
      Sum(basis.val_rtl_ejr_adj_py) AS val_rtl_ejr_adj_py,	
      Sum(basis.val_rtl_net_ejr_adj_py) AS val_rtl_net_ejr_adj_py	
     FROM p_lew_mart_msi.v_mat0_bo_base_abs AS basis	
      GROUP BY basis.client_id	
          , basis.store_id	
          , basis.dat_formdate	
          , basis.cy_week	
          , basis.cy_week_seq	
          , basis.cy_month	
          , basis.currency_iso_cd	
          , basis.sub_item_grp_sid	
          , basis.subitemgroup_id	
          , basis.item_grp_int_sid	
          , basis.itemgroup_int_id	
;