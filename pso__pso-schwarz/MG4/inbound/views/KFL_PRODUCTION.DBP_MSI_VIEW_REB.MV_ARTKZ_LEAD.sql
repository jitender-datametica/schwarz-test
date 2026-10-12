create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_LEAD(
	MANDANT_ID,
	LEAD_ID,
	LEAD_BEZ
) as
   SELECT
   mandant_id, lead_id, lead_bez

   FROM dbp_view.v_artkz_lead
   WHERE mandant_id = 1
   AND spr_id =22;