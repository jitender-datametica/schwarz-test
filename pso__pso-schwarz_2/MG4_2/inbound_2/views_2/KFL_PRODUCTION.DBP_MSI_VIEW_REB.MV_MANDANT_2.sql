create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_MANDANT_2(
	MANDANT_ID,
	MANDANT_BEZ,
	MANDANT_KBEZ
) as
   SELECT
   mandant_id, mandant_bez, mandant_kbez

   FROM dbp_view.v_mandant_2
   WHERE mandant_id = 1;