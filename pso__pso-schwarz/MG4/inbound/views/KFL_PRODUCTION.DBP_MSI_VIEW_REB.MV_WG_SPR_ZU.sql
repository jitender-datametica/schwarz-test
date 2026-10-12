create or replace view KFL_PRODUCTION.DBP_MSI_VIEW_REB.MV_WG_SPR_ZU(
	WG_ID,
	SPR_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	WG_BEZ,
	WG_ID_BEZ
) as
   SELECT
   wg_id, spr_id, arthiertyp_id, mandant_id, wg_bez, CASE WHEN wg_id < 10  THEN '00' || CAST(wg_id AS VARCHAR(3))
   WHEN wg_id < 100 THEN '0' || CAST(wg_id AS VARCHAR(3))
   ELSE CAST(wg_id AS VARCHAR(3)) END|| '  ' ||wg_bez

   FROM dbp_view.v_wg_spr_zu
   WHERE spr_id = 22
   AND arthiertyp_id = 2
   AND mandant_id = 1
   AND wg_id  >= -3
;