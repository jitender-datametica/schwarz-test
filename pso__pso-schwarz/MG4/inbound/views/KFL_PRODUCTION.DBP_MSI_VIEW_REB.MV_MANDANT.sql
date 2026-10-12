create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_MANDANT(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ
) as
   SELECT
   mandant_id, mandant_bez, mandant_kbez

   FROM dbp_view.v_mandant
   WHERE mandant_id = 1;