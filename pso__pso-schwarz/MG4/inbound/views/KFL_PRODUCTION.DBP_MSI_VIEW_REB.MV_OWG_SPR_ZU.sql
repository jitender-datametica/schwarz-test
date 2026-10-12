create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_OWG_SPR_ZU(
	OWG_ID,
	SPR_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	OWG_BEZ
) as
   SELECT
   owg_id, spr_id, arthiertyp_id, mandant_id, owg_bez

   FROM dbp_view.v_owg_spr_zu
   WHERE spr_id=22
   AND mandant_id=1;