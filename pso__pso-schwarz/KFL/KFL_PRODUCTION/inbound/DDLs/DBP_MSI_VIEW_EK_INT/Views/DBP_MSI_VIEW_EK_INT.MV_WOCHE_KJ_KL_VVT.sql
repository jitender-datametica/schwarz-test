CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WOCHE_KJ_KL_VVT
AS
   SELECT
   kjwo_kl, kjwo_kl_dat_von, kjwo_kl_dat_bis, akt_kjwo_kl, akt_kjwo_kl_komplett, akt_kj, akt_kj_komplett, kjwo, akt_wo
   FROM dbp_msi_view_ek_int.mv_tag
   GROUP BY 1,2,3,4,5,6,7,8,9;