create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ART_GP_AKTUELL_1(
	MANDANT_ID,
	ART_ID,
	AKT_GP_ID
) as
   SELECT
   mandant_id, art_id, gp_id

   FROM dbp_view.v_art_gp_zu_per_1
   WHERE dat_bis = '9999-12-31';