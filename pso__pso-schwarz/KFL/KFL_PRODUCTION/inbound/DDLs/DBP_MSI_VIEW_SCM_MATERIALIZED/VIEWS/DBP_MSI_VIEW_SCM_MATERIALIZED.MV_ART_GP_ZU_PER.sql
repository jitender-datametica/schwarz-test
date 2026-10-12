create or replace view DBP_MSI_VIEW_SCM_MATERIALIZED.MV_ART_GP_ZU_PER(
	ART_ID,
	GP_ID,
	MANDANT_ID,
	HERST_ID,
	GP_ART_ID,
	DAT_VON,
	DAT_BIS
) as
   SELECT
   art_id, gp_id, mandant_id, herst_id, gp_art_id, dat_von, dat_bis
   FROM dbp_view.v_art_gp_zu_per
   WHERE dat_bis = '9999-12-31';