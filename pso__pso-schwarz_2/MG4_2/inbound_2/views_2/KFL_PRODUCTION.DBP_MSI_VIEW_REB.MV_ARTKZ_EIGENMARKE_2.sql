create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_EIGENMARKE_2(
	MANDANT_ID,
	EIGENMARKE_ID,
	EIGENMARKE_BEZ
) as
   SELECT
   mandant_id, eigenmarke_id, eigenmarke_bez

   FROM dbp_view.v_artkz_eigenmarke_2
   WHERE mandant_id = 1
   AND spr_id = 22;