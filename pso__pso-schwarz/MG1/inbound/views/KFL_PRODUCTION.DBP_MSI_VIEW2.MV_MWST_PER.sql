create or replace view KFL_PRODUCTION.DBP_MSI_VIEW2.MV_MWST_PER(
	DAT_VON,
	MWST_ID,
	MWST,
	DAT_BIS
) as
   SELECT
  dat_von, mwst_id, mwst, dat_bis

   FROM dbp_view.v_mwst_per
   WHERE mandant_id = 1;