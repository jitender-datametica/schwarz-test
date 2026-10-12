create or replace view DBP_MSI_VIEW_FLW_MATERIALIZED.MV_L_FLW_ZERLEGE_GRUPPE_SPR_ZU_2(
	MANDANT_ID,
	ZERLEGE_GRUPPE_ID,
	ZERLEGE_GRUPPE_BEZ
) as

   SELECT
   mandant_id, zerlege_gruppe_id, zerlege_gruppe_bez

   FROM dbp_view.v_flw_zerlege_gruppe_spr_zu_2 v01

   JOIN dbp_msi.akt_msi_user_spr_zu_2 v02
   ON v01.spr_id = v02.spr_id;