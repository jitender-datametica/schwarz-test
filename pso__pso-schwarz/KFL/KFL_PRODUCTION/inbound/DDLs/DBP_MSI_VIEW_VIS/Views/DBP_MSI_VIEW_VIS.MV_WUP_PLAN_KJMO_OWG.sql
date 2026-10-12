create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_WUP_PLAN_KJMO_OWG(
	MANDANT_ID,
	NB_ID,
	WUP_ID,
	KJMO,
	OWG_ID,
	WRG_ID,
	UMSATZ_NETTO_PLAN,
	ABSCHRIFTEN_NETTO_OPERATIV_PLAN
) as
 






 
SELECT
	wpk.mandant_id
	, wpk.nb_id
	, wup.aktuell_wup_id AS wup_id
	, wpk.kjmo
	, wpk.hwg_id      AS owg_id
	, krs.nach_wrg_id AS wrg_id
	, wpk.umsatz_netto_plan * krs.umrechnungskurs               AS umsatz_netto_plan
	, wpk.abschriften_netto_operativ_plan * krs.umrechnungskurs AS abschriften_netto_operativ_plan
FROM dbp_view.v_wup_plan_kjmo_owg wpk
 
INNER JOIN ( 
	SELECT krs1.von_wrg_id, krs1.nach_wrg_id, krs1.umrechnungskurs 
	FROM dbp_data.kurs krs1 
	WHERE krs1.kurstyp_id = 3 AND krs1.dat_bis = '9999-12-31' 
	AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
	UNION ALL 
	SELECT krs2.von_wrg_id, krs2.von_wrg_id, 1.0000 
	FROM dbp_data.kurs krs2 
	WHERE krs2.kurstyp_id = 3 AND krs2.dat_bis = '9999-12-31'  
	AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')  
) krs
ON krs.von_wrg_id = wpk.wrg_id

INNER JOIN dbp_view.v_wup wup
ON wpk.mandant_id = wup.mandant_id AND wpk.wup_id = wup.wup_id

;
