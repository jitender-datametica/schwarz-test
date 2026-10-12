create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_GEKU.MV_WOCHE_GJ_KL_1(
	GJWO_KL,
	GJWO_KL_DAT_VON,
	GJWO_KL_DAT_BIS,
	AKT_GJWO_KL,
	AKT_GJWO_KL_KOMPLETT,
	AKT_GJ,
	GJ,
	AKT_GJ_KOMPLETT
) as
-- 01.02.2016 twie: kjwo_kl_vj entfernt

   SELECT
   gjwo_kl
   , gjwo_kl_dat_von
   , gjwo_kl_dat_bis
   , akt_gjwo_kl
   , akt_gjwo_kl_komplett
   , akt_gj
   , SUBSTRING(CAST(CAST(gjwo_kl AS INTEGER) AS CHAR(6)), 1, 4)
   , akt_gj_komplett
   FROM dbp_view.v_woche_gj_kl_1
   WHERE gjwo_kl > 200153;