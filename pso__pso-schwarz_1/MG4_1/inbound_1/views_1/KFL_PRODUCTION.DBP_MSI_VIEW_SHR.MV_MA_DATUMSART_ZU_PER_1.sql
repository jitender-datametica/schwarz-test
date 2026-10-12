create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_SHR.MV_MA_DATUMSART_ZU_PER_1(
	MANDANT_ID,
	DATUMSART_ID,
	MITARBEITER_ID,
	KJMO,
	DAT_VON
) as
   SELECT
   v01.mandant_id, v01.datumsart_id, v01.mitarbeiter_id, v01.kjmo, v01.dat_von

   FROM dbp_view.v_ma_datumsart_zu_per_1 v01;