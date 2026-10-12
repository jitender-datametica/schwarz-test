create or replace view KFL_PRODUCTION_CLONE_GCP_MIGRATION_20260608_0800.DBP_MSI_VIEW_SHR.MV_MONAT(
	KJMO,
	KJMO_VJ,
	GJMO,
	GJMO_VJ,
	KJQU,
	GJQU,
	KJ,
	GJ,
	AKT_MO,
	AKT_MO_KOMPLETT,
	AKT_GJQU,
	AKT_GJQU_KOMPLETT,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	AKT_GJ,
	AKT_GJ_KOMPLETT,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	MO_GJ,
	MO_KJ,
	KJMO_VM,
	KJMO_VM6
) as
   SELECT
   v01.kjmo, v01.kjmo_vj, v01.gjmo, v01.gjmo_vj, v01.kjqu, v01.gjqu, v01.kj, 
   v01.gj, v01.akt_mo, v01.akt_mo_komplett, v01.akt_gjqu, v01.akt_gjqu_komplett, v01.akt_kjqu, 
   v01.akt_kjqu_komplett, v01.akt_gj, v01.akt_gj_komplett, v01.akt_kj, v01.akt_kj_komplett, v01.mo_gj, v01.mo_kj,
   to_number(to_char(add_months(to_date(to_char(KJMO),'YYYYMM'),-1),'YYYYMM')) AS kjmo_vm,
   MIN (kjmo) OVER (ORDER BY kjmo ASC ROWS 6 PRECEDING) AS kjmo_vm6
   FROM dbp_view.v_monat v01;
