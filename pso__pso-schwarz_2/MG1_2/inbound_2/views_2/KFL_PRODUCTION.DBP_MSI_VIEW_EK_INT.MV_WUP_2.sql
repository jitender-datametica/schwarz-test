create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_EK_INT.MV_WUP_2(
	WUP_ID,
	NB_ID,
	MANDANT_ID,
	DAT_VON,
	DAT_BIS,
	DAT_EROEFFNUNG,
	BREITENGRAD,
	LAENGENGRAD
) as
   SELECT
   wup_id,
   nb_id,
   mandant_id,
   dat_von,
   dat_bis,
   dat_eroeffnung,
   breitengrad,
   laengengrad
   FROM dbp_view.v_wup_2  v01;