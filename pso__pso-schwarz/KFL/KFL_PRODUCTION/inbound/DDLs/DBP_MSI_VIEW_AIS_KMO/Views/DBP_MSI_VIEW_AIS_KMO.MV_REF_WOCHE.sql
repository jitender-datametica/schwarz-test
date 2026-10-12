CREATE OR REPLACE VIEW DBP_MSI_VIEW_AIS_KMO.MV_REF_WOCHE
(
kjwo
, kjwo_ref
, kjwo_abstand
)
AS
   SELECT
  v01.kjwo,
   v02.kjwo,
   v01.akt_kjwo_kalendarisch - v02.akt_kjwo_kalendarisch AS kjwo_abstand
  FROM dbp_msi_view_ais_kmo.mv_woche v01
   CROSS JOIN dbp_msi_view_ais_kmo.mv_woche v02;