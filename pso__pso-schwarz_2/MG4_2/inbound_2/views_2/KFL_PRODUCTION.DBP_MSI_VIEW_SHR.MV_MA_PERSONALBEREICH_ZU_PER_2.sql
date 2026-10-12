create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MA_PERSONALBEREICH_ZU_PER_2(
	MANDANT_ID,
	SYSTEM_ID,
	BUCHUNGSKREIS_ID,
	MITARBEITER_ID,
	KJMO
) as
   SELECT
   mandant_id, system_id, buchungskreis_id, mitarbeiter_id, kjmo


   FROM dbp_view.v_ma_personalbereich_zu_per_2;