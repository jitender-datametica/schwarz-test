CREATE OR REPLACE VIEW DBP_MSI_VIEW_EK_INT.MV_JAHR_KJ_1
(
   kj,
   akt_kj,
   akt_kj_komplett
)
AS
   SELECT
   v01.kj, 
   v01.akt_kj, 
   v01.akt_kj_komplett
/* SPEC0249727 Umstellung auf VTA (vorher mv_jahr_kj_vvt_1) / sschuecke 23.05.2024 */
   FROM dbp_view.v_jahr_kj_1 v01

   WHERE v01.akt_kj BETWEEN -11 AND 2;