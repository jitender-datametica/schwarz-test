create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_WUG_SPR_ZU(
	MANDANT_ID,
	WUG_ID,
	ARTHIERTYP_ID,
	WG_ID,
	SPR_ID,
	WUG_BEZ,
	WUG_ID_BEZ
) as
   SELECT v01.mandant_id, v01.wug_id, v01.arthiertyp_id, v01.wg_id, v01.spr_id, v01.wug_bez, CAST( CAST(v01.wug_id AS CHAR(10)) || '   ' || v01.wug_bez AS CHAR(50)) AS wug_id_bez
   FROM dbp_view.v_wug_spr_zu v01

   JOIN dbp_msi.akt_msi_user_spr_zu v02
   ON v01.spr_id = v02.spr_id

   WHERE v01.mandant_id IN (1,2)
   AND v01.arthiertyp_id = 2;