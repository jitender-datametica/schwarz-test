create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_ART_WG_ZU_PER_1(
	ART_ID,
	MANDANT_ID,
	ARTHIERTYP_ID,
	WUG_ID,
	WG_ID,
	DAT_VON,
	DAT_BIS
) as
   SELECT
   v01.art_id, v01.mandant_id, v01.arthiertyp_id, v01.wug_id, v01.wg_id, v01.dat_von, v01.dat_bis

   FROM dbp_view.v_art_wg_zu_per_1 v01

   WHERE v01.arthiertyp_id = 2
   AND   v01.dat_bis = '9999-12-31';