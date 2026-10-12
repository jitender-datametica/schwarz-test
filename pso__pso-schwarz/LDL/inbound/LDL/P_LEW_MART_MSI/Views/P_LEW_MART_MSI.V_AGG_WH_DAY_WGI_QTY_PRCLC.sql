CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_WH_DAY_WGI_QTY_PRCLC as
   /*
   #DescStart#
   #$Revision: 6244 $, $LastChangedBy: hwieber $
   #SubjectAreas#: Quickview
   #DescEnd#
   */
   SELECT
    client_id,
   client_desc,
   country_group_id,
   country_group_desc,
   gl_region_id,
   gl_region_desc,
   wh_id,
   wh_desc,
   aspect_id,
   aspect_desc,
   itemgroup_int_id,
   itemgroup_int_desc,
   dat_formdate,
   cnt_miss_item,
   cnt_miss_item_py,
   case when cnt_miss_item IS NOT NULL then cnt_dat_miss_item ELSE NULL END cnt_dat_miss_item,
   case when cnt_miss_item_py IS NOT NULL then cnt_dat_miss_item_py ELSE NULL END cnt_dat_miss_item_py,
   val_roc_prclc_wh,
   val_roc_prclc_wh_py,
   avg_stc_wh,
   avg_stc_wh_py
   FROM p_lew_mart_msi.t_agg_wh_day_wgi_prclc
   WHERE curr_tot_id=0;