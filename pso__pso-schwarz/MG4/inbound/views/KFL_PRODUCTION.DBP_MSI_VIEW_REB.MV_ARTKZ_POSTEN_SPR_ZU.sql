create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ARTKZ_POSTEN_SPR_ZU(
	POSTEN_ID_ORIG,
	MANDANT_ID,
	SPR_ID,
	POSTEN_BEZ
) as
   SELECT
   posten_id, mandant_id, spr_id, CASE WHEN posten_id = '' THEN 'nicht gepflegt' ELSE posten_bez END posten_bez
   FROM dbp_view.v_artkz_posten
   WHERE mandant_id = 1
   AND spr_id = 22;