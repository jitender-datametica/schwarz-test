CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_WH_DAY_SALES_PRCLC_1 as
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
   currency_iso_cd,
   curr_tot_id,
   dat_formdate,
   val_retail_net_asis,
   val_retail_net_asis_py,
   cnt_customer_asis,
   cnt_customer_asis_py,
   val_retail_gross_asis,
   val_retail_gross_asis_py,
   cnt_customer_adj_asis,
   cnt_customer_adj_asis_py,
   cnt_customer_adj_asis_ppy,
   val_retail_net_adj_asis,
   val_retail_net_adj_asis_py,
   val_retail_net_adj_asis_ppy,
   val_retail_gross_adj_asis,
   val_retail_gross_adj_asis_py,
   val_retail_gross_adj_asis_ppy,
   val_rtl_gro_extrapol_asis,
   val_rtl_net_extrapol_asis
   FROM p_lew_mart_msi.t_agg_wh_day_sales_prclc_1;