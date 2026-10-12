CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WOCHE_KJ_KL_2
(
   kjwo_kl,
   kjwo_kl_dat_von, 
   kjwo_kl_dat_bis, 
   akt_kjwo_kl, 
   akt_kjwo_kl_komplett, 
   akt_kj, 
   akt_kj_komplett, 
   kj,
   kjwo,
   akt_wo
)
AS
   SELECT
   v01.kjwo_kl, 
   v01.kjwo_kl_dat_von, 
   v01.kjwo_kl_dat_bis, 
   v01.akt_kjwo_kl, 
   v01.akt_kjwo_kl_komplett, 
   v01.akt_kj, v01.akt_kj_komplett, 
   CAST (FLOOR(v01.kjwo_kl / 100) AS SMALLINT) AS kj, 
   v01.kjwo, 
   v01.akt_wo
   /* SPEC0249727 Umstellung auf VTA (vorher mv_woche_kj_kl_vvt_2) / sschuecke 23.05.2024 */
   FROM dbp_view.v_woche_kj_kl_2 v01;