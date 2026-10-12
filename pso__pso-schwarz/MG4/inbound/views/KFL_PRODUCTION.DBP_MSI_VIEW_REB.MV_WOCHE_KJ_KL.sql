create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_WOCHE_KJ_KL(
	KJWO_KL,
	KJWO_KL_DAT_VON,
	KJWO_KL_DAT_BIS,
	AKT_KJWO_KL,
	AKT_KJWO_KL_KOMPLETT,
	AKT_KJ,
	AKT_KJ_KOMPLETT,
	KJWO,
	KJ,
	AKT_WO
) as
   SELECT
   kjwo_kl,  kjwo_kl_dat_von,  kjwo_kl_dat_bis,  akt_kjwo_kl,  akt_kjwo_kl_komplett,  akt_kj,  akt_kj_komplett,  kjwo,  CAST (TRUNC(kjwo_kl / 100) AS SMALLINT) AS kj,  akt_wo
   FROM dbp_view.v_woche_kj_kl
   WHERE kjwo_kl > 200153
;