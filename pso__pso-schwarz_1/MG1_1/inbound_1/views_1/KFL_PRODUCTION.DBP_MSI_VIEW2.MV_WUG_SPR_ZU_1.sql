create or replace view KFL_PRODUCTION.DBP_MSI_VIEW2.MV_WUG_SPR_ZU_1(
	MANDANT_ID,
	WUG_ID,
	ARTHIERTYP_ID,
	WG_ID,
	SPR_ID,
	WUG_BEZ,
	WUG_ID_BEZ
) as
   SELECT mandant_id, wug_id, arthiertyp_id, wg_id, spr_id, wug_bez,
   cast( cast(wug_id as CHAR(10)) || '   ' || wug_bez AS CHAR(50)) from dbp_view.v_wug_spr_zu_1 where spr_id=22 and mandant_id=1 and arthiertyp_id=2;