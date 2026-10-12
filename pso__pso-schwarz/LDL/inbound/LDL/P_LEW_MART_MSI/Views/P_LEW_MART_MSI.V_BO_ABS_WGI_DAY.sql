CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_BO_ABS_WGI_DAY as
   SELECT base.client_id,
   base.country_desc,
   base.country_id,
   base.country_iso_cd,
   base.store_id,
   base.orig_store_nr,
   base.store_desc,
   base.city,
   base.wh_id,
   base.wh_desc,
   base.sales_manager_id,
   base.sales_manager_name,
   base.account_manager_id,
   base.account_manager_name,
   base.itemgroup_int_id AS item_wgi_id,
   base.dat_formdate,
   base.cy_week AS week_page_by,
   base.currency_iso_cd,
   Sum(base.val_rtl_rl_sfo) AS val_rtl_rl_sfo_store_asis,
   Sum(base.val_rtl_rl_net_sfo) AS val_rtl_rl_net_sfo_store_asis,
   Sum(base.val_rtl_net_sfo_mhd_break) AS val_rtl_net_sfo_mhd_break,
   Sum(base.val_rtl_net_sfo_other_stc_loss) AS val_rtl_net_sfo_other_stc_loss,
   Sum(base.val_rtl_net_sfo_str_deliv_qlty) AS val_rtl_net_sfo_str_deliv_qlty,
   Sum(base.val_wrtoff_zero) AS val_wrtoff_zero_asis,
   Sum(base.val_wrtoff_zero_net) AS val_wrtoff_zero_net_asis,
   Sum(base.val_wrtoff_zero_net_mhd_break) AS val_wofz_st_net_mhd_break,
   Sum(base.val_wrtoff_zero_net_other_stc_loss) AS val_wofz_st_net_other_stc_loss,
   Sum(base.val_wrtoff_zero_net_str_deliv_qlty) AS val_wofz_st_net_deliv_qlty,
   Sum(base.val_discount_ejr) AS val_discount_sfo_asis,
   Sum(base.val_discount_net_ejr) AS val_discount_net_sfo_asis,
   Sum(base.val_rtl_ejr_adj) AS val_rtl_ejr_adj_asis,
   Sum(base.val_rtl_net_ejr_adj) AS val_rtl_net_ejr_adj_asis,
   Cast(ZeroIfNull(Sum(base.val_rtl_rl_sfo) / CASE WHEN Sum(val_rtl_ejr_adj) = 0 THEN null ELSE Sum(val_rtl_ejr_adj) END) AS DECIMAL(36, 10)) AS sfo_to_val_retail_pct,
   Cast(ZeroIfNull(Sum(base.val_rtl_rl_net_sfo) / CASE WHEN Sum(val_rtl_net_ejr_adj) = 0 THEN null ELSE Sum(val_rtl_net_ejr_adj) END) AS DECIMAL(36, 10)) AS sfo_to_val_retail_net_pct
   FROM p_lew_mart_msi.t_bo_base_abs AS base
   WHERE base.cy_week_seq BETWEEN -4 AND 0
       -- Keine Dummy WGIs anzeigen. In der alten Version wurden hierzu alle Sätze mit einer SIG < -2 ausgeschlosen, dies hat nur WGIs < 0 betroffen.
       -- Ansonsten werden nur Sätze mit WGI >= 0 selektiert, weshalb auch eine Umschlüsselung negativer WGIs auf 0 unnötig ist.
       AND base.itemgroup_int_id >= 0
       -- Nur Zeilen anzeigen, für die auch Werte für das aktuelle Jahr vorliegen. Aktuell ""dreckig"" gelöst. In Zukunft gibt es in der Tabelle T_BO_BASE_ABS ein Kennzeichen hierfür.
       AND (
           base.val_rtl_rl_sfo IS NOT NULL
           OR base.val_rtl_rl_net_sfo IS NOT NULL
           OR base.val_wrtoff_zero IS NOT NULL
           OR base.val_wrtoff_zero_net IS NOT NULL
           OR base.val_discount_ejr IS NOT NULL
           OR base.val_discount_net_ejr IS NOT NULL
           OR base.val_rtl_ejr_adj IS NOT NULL
           OR base.val_rtl_net_ejr_adj IS NOT NULL
       )
   GROUP BY base.client_id
       , base.country_desc
       , base.country_id
       , base.country_iso_cd
       , base.store_id
       , base.orig_store_nr
       , base.store_desc
       , base.city
       , base.wh_id
       , base.wh_desc
       , base.sales_manager_id
       , base.sales_manager_name
       , base.account_manager_id
       , base.account_manager_name
       , base.itemgroup_int_id
       , base.dat_formdate
       , base.cy_week
       , base.currency_iso_cd
;