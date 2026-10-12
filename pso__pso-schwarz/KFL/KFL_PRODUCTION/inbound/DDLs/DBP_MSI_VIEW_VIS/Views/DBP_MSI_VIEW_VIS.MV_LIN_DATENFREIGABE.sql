CREATE OR REPLACE VIEW DBP_MSI_VIEW_VIS.MV_LIN_DATENFREIGABE
(
kjmo
,akt_kjmo
)
AS
   SELECT kjmo, RANK() OVER (ORDER BY kjmo DESC NULLS LAST) AS akt_kjmo
   FROM
   (
   SELECT v01.kjmo

   FROM dbp_msi_v_view.v_lin_datenfreigabe v01
   WHERE v01.lin_freigabe_fg = 1
   AND v01.vertrieb_fg = 1
   GROUP BY v01.kjmo
   ) dt1
;