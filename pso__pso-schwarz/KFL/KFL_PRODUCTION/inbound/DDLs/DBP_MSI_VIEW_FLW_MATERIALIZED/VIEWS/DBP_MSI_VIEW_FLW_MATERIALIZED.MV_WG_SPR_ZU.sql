create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_WG_SPR_ZU(
	WG_ID,
	SPR_ID,
	ARTHIERTYP_ID,
	MANDANT_ID,
	WG_BEZ,
	WG_ID_BEZ
) as 


   SELECT
   v01.wg_id, v01.spr_id, v01.arthiertyp_id, v01.mandant_id, v01.wg_bez, wg_id_bez
   FROM DBP_MSI_VIEW_FLW_MATERIALIZED.TBL_MV_WG_SPR_ZU v01
   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id;