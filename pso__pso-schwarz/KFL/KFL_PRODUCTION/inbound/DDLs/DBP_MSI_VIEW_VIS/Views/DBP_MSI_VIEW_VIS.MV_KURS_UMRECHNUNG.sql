create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_VIS.MV_KURS_UMRECHNUNG(
	VON_WRG_ID,
	NACH_WRG_ID,
	UMRECHNUNGSKURS
) as
/*
2025-07-25 tekin: Erstellung der Lookup-View zur Waehrungsumrechnung
*/
SELECT krs1.von_wrg_id
	, krs1.nach_wrg_id
	, krs1.umrechnungskurs
FROM dbp_data.kurs krs1
WHERE krs1.kurstyp_id = 3
	AND krs1.dat_bis = '9999-12-31' 
	AND krs1.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT') 
UNION ALL 
SELECT krs2.von_wrg_id
	, krs2.von_wrg_id
	, 1.0000
FROM dbp_data.kurs krs2
WHERE krs2.kurstyp_id = 3
	AND krs2.dat_bis = '9999-12-31'
	AND krs2.von_wrg_id NOT IN ('AUD', 'DEM', 'SIT', 'EUR')
;
