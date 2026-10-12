CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_JAHR_GJ_VVT_2
AS
   SELECT
     gj, akt_gj, akt_gj_komplett
   FROM dbp_msi_view_ek_int.mv_tag_2
   GROUP BY 1,2,3;