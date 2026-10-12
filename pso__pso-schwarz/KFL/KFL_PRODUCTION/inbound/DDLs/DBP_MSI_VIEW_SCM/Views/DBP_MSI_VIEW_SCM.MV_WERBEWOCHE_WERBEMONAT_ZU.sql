create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SCM.MV_WERBEWOCHE_WERBEMONAT_ZU(
	MANDANT_ID,
	KJWO,
	AKT_MO,
	KJMO
) as


SELECT 
w.mandant_id, 
w.kjwo,
m.akt_mo,
w.kjmo
 FROM (
 SELECT
 mandant_id, 
 kjwo,
 MAX(kjmo) kjmo 
 FROM dbp_view.v_werbe_typ_woche_zu 
 GROUP BY mandant_id, kjwo) w
JOIN dbp_view.v_monat m
ON w.kjmo = m.kjmo;
