CREATE OR REPLACE VIEW DBP_MSI_VIEW_IOS.MV_MAX_GJ_2 as
   SELECT
   gj, akt_gj, max(dat)  dat_termin_gj
   FROM dbp_msi_view_ios.mv_tag_2
   GROUP BY 1,2;