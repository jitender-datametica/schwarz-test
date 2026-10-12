CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_JAHR_GJ_2
(
   gj,
   akt_gj,
   akt_gj_komplett
)
AS
   SELECT
   v01.gj, 
   v01.akt_gj, 
   v01.akt_gj_komplett
/* SPEC0249727 Umstellung auf VTA (vorher mv_jahr_gj_vvt_2) / sschuecke 23.05.2024 */
   FROM dbp_view.v_jahr_gj_2 v01

   WHERE v01.akt_gj BETWEEN -10 AND 1;