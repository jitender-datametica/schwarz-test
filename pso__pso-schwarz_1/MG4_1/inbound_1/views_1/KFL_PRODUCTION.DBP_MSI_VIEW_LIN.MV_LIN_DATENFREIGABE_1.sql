create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_LIN.MV_LIN_DATENFREIGABE_1(
	KJMO,
	AKT_KJMO
) as
   SELECT v01.kjmo, RANK() OVER (ORDER BY kjmo DESC NULLS LAST) AS akt_kjmo
   FROM dbp_msi_v_view.v_lin_datenfreigabe_1 v01

   WHERE v01.lin_freigabe_fg = 1
   AND v01.vertrieb_fg = 0
   GROUP BY v01.kjmo
;