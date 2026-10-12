create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_SHR_PRUEFBERICHTE(
	MANDANT_ID,
	KJMO_PRUEF
) as
   SELECT

   v01.mandant_id, max(v01.kjmo) AS kjmo_pruef

   FROM dbp_view.v_mitarbeiterbew  v01
   GROUP BY 1;