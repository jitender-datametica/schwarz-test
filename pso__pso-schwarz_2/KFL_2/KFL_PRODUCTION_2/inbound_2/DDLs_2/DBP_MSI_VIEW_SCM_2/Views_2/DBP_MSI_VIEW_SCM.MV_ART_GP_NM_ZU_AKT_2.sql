CREATE OR REPLACE VIEW DBP_MSI_VIEW_SCM.MV_ART_GP_NM_ZU_AKT_2(
	MANDANT_ID,
	ART_ID,
	WUP_ID,
	NB_ID,
	DAT_VON,
	AKT_GP_ID,
	EINKAUFSORGANISATION_ID,
	DAT_BIS
) AS
--2024-04-22, AP0179753, dknop, initial
   SELECT
  v01.mandant_id,
   v01.art_id,
   v01.wup_id,
   v01.nb_id,
   v01.dat_von,
   v01.gp_id,
   v01.einkaufsorganisation_id,
   v01.dat_bis
   FROM dbp_view.v_art_gp_nm_zu_per_2 v01
   WHERE v01.dat_bis = '9999-12-31';