create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_QUARTAL_KJ_2(
	KJQU,
	AKT_KJQU,
	AKT_KJQU_KOMPLETT,
	KJ,
	AKT_KJ,
	AKT_KJ_KOMPLETT
) as
   SELECT
   kjqu, akt_kjqu, akt_kjqu_komplett, kj, akt_kj, akt_kj_komplett

   FROM dbp_view.v_quartal_kj_2
   WHERE kjqu > 200104
;