create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_WUG_SPR_ZU_2(
	MANDANT_ID,
	WUG_ID,
	ARTHIERTYP_ID,
	WG_ID,
	SPR_ID,
	WUG_BEZ,
	WUG_ID_BEZ
) as
   SELECT
   mandant_id, wug_id, arthiertyp_id, wg_id, spr_id, wug_bez, CAST( CAST(wug_id AS CHAR(10)) || '   ' || wug_bez AS CHAR(50))

   FROM dbp_view.v_wug_spr_zu_2
   WHERE spr_id = 22
   AND mandant_id = 1
   AND arthiertyp_id = 2
;