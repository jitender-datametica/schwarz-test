CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_WOCHE_VVT_2
AS
   SELECT
     gjwo, gjwo_vj, kjwo, kjwo_vj, wo_dat_von, wo_dat_bis, akt_wo, akt_wo_komplett, (wo_dat_von-(CURRENT_DATE-(MOD((CURRENT_DATE-Cast('1990-01-01' AS DATE)), 7))))/7 AS akt_wo_kalendarisch
   FROM dbp_msi_view_ek_int.mv_tag_2
   GROUP BY 1,2,3,4,5,6,7,8,9;