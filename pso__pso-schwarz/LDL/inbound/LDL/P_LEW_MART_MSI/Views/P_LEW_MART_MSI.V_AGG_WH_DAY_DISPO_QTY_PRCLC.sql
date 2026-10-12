CREATE OR REPLACE VIEW P_LEW_MART_MSI.V_AGG_WH_DAY_DISPO_QTY_PRCLC as
         /*
         #DescStart#
         #$Revision: 6244 $, $LastChangedBy: hwieber $
         #SubjectAreas#: Fehlartikel
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
         cnt_miss_item,
         cnt_miss_item_py,
         cnt_dat_miss_item,
         cnt_dat_miss_item_py,
         val_roc_prclc_wh,
         val_roc_prclc_wh_py,
         avg_stc_wh,
         avg_stc_wh_py
         FROM p_lew_mart_msi.t_agg_wh_day_dispo_prclc
         WHERE curr_tot_id=0;