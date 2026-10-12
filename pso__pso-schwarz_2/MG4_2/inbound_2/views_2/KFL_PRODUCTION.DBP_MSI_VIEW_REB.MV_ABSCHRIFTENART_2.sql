create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_ABSCHRIFTENART_2(
	ABSCHRIFTENART_ID,
	ABSCHRIFTENART_BEZ,
	MANDANT_ID,
	SPR_ID
) as
   SELECT
   abschriftart_id, abschriftart_bez, mandant_id, spr_id

   FROM dbp_view.v_abschriftart_spr_zu_2
   WHERE mandant_id = 1
   AND abschriftart_id <> 90
;